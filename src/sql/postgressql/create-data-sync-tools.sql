--1:
CREATE TABLE sync_data_version (
	DataVersionName		varchar(36)		NOT NULL,
	RecordCreated		timestamp		NOT NULL	default(now()),
	PRIMARY KEY (DataVersionName)
);

--2:
CREATE TABLE sync_data_entity (
	EntitySingularName	varchar(50)		NOT NULL,
	EntityPluralName	varchar(50)		NOT NULL,
	DataVersionName		varchar(36)		NOT NULL,
	ProcOrderAddUpdate	integer			NOT NULL,
	ProcessOrderDelete	integer			NOT NULL,
	EntityHandlerUri	varchar(2048) 	NULL,
	RecordCreated		timestamp		NOT NULL	default(now()),
	PRIMARY KEY (EntitySingularName)
);

--3:
CREATE TABLE sync_state (
	EntitySingularName	varchar(50)		NOT NULL,
	RecordId			varchar(112)	NOT NULL,
	DataVersionName		varchar(36)		NOT NULL,
	RecordHash			varchar(100)	NOT NULL,
	RecordData			bytea 			NOT NULL,
	RecordBytesSize		int				NOT NULL,
	IsDelete			boolean			NOT NULL 	default('false'),
	GroupName			varchar(256)	NULL, --RESERVED: Not currently in use
	GroupType			varchar(256)	NULL, --RESERVED: Not currently in use
	GroupSeqNum			int				NULL, --RESERVED: Not currently in use
	RecordCreated		timestamp		NOT NULL	default(now()),
	PRIMARY KEY (EntitySingularName, RecordId)
);

--4:
CREATE TABLE sync_node(
	NodeId				varchar(36) 	NOT NULL,
	NodeName			varchar(256) 	NOT NULL,
	DataVersionName		varchar(36)		NOT NULL,
	Enabled				boolean 		NOT NULL	default('true'),
	DataMsgConsUri		varchar(2048) 	NULL,
	DataMsgProdUri		varchar(2048) 	NULL,
	MgmtMsgConsUri		varchar(2048) 	NULL,
	MgmtMsgProdUri		varchar(2048) 	NULL,
	SyncDataPersistForm	varchar(36) 	NULL,
	InMsgBatchSize		int 			NULL 		default(100),
	MaxOutMsgBatchSize  int 			NULL 		default(200),
	InChanDepthSize		int 			NULL 		default(16),
	MaxOutChanDepthSize int 			NULL 		default(16),
	RecordCreated		timestamp		NOT NULL	default(now()),
	UNIQUE(NodeName),
	PRIMARY KEY (NodeId)
);

--5:
CREATE TABLE sync_peer_state (
	NodeId						varchar(36)		NOT NULL,
	EntitySingularName			varchar(50)		NOT NULL,
	RecordId					varchar(112)	NOT NULL,
	SessionBindId				varchar(36)		NULL,
	TransactionBindReceiveId	varchar(36)		NULL,
	TransactionBindSendId		varchar(36)		NULL,
	SentLastKnownHash			varchar(100)	NULL,
	PeerLastKnownHash			varchar(100)	NULL,
	IsConflict 					boolean			NOT NULL 	default('false'),
	SentSyncState				integer 		NOT NULL 	default(0),
	-- 0-never sent to peer (default on add record), 1-first time sent to peer, 2-standard sent to peer, 
	-- 3-acked by peer, 4-fast delete, 5-conflict not resolved (update-update), 6-conflict not resolved (update-delete),
	-- 7-conflict not resolved (delete-update), 8-conflict not resolved (update-update-dirty), 
	-- 9-conflict not resolved (update-delete-dirty), 10-conflict not resolved (delete-update-dirty)
	ChangedByClient				boolean			NOT NULL 	default('false'),
	LastUpdated					date			NULL,
	RecordCreated				timestamp		NOT NULL	default(now()),
	PRIMARY KEY (NodeId, EntitySingularName, RecordId),
	CONSTRAINT valid_sent_sync_state CHECK (SentSyncState >= 0 AND SentSyncState <= 10)
);

--6:
CREATE TABLE sync_data_field (
	EntitySingularName	varchar(50)		NOT NULL,
	FieldName			varchar(100)	NOT NULL, -- this is a canonical name regardless of local naming convensions using camel case starting with Upper Case
	DataVersionName		varchar(36) 	NOT NULL,
	DataTypeName		varchar(6)		NOT NULL,
	IsPrimaryKey		boolean			NOT NULL,
	RecordCreated		timestamp		NOT NULL	default(now()),
	PRIMARY KEY (EntitySingularName, FieldName),
	CONSTRAINT valid_date_type_name CHECK (DataTypeName = 'String' OR DataTypeName = 'Date' OR 
										  DataTypeName = 'Bool'	   OR DataTypeName = 'Int'  OR 
										  DataTypeName = 'Float'   OR DataTypeName = 'Binary')
);

--7:
CREATE TABLE sync_pair(
	PairId				varchar(36) 	NOT NULL,
	PairName			varchar(72) 	NOT NULL,
	MaxSesDurValue		int 			NULL 		default(10),
	MaxSesDurUnit		varchar(36) 	NOT NULL 	default('minutes'),
	SyncDataTransForm	varchar(36) 	NOT NULL 	default('json:V1'),
	SyncMsgTransForm	varchar(36) 	NOT NULL 	default('json:V1'),
	SyncMsgSecPol		varchar(36) 	NOT NULL 	default('none'),
	SyncSessionId		varchar(36)		NULL,
	SyncSessionState	varchar(36)		NOT NULL	default('Inactive'),
	SyncSessionStart	timestamp 		NULL,
	SyncConflictUri	    varchar(2048) 	NOT NULL 	default('none'),
	RecordCreated		timestamp		NOT NULL	default(now()),
	UNIQUE(PairName),
	PRIMARY KEY (PairId),
	CONSTRAINT valid_session_state CHECK (SyncSessionState = 'Inactive' OR SyncSessionState = 'Initializing' OR 
										  SyncSessionState = 'Seeding'  OR SyncSessionState = 'Queuing'      OR 
										  SyncSessionState = 'Syncing'  OR SyncSessionState = 'Canceling')
);

--8:
CREATE TABLE sync_pair_nodes(
	PairId				varchar(36) 	NOT NULL,
	NodeId				varchar(36) 	NOT NULL,
	TargetNodeId		varchar(36) 	NOT NULL,
	LastSeededDate		timestamp		NULL,
	SeededDataVersion	varchar(36)		NULL,
	SyncConflictUri	    varchar(2048) 	NOT NULL,
	TotalSessRecBytes	int				NOT NULL	default(0),
	TotalSessRecCount	int				NOT NULL	default(0),
	ProceSessRecBytes	int				NOT NULL	default(0),
	ProceSessRecCount	int				NOT NULL	default(0),
	RecordCreated		timestamp		NOT NULL	default(now()),
	PRIMARY KEY (PairId, NodeId, TargetNodeId)
);

--GRANT SELECT, INSERT, UPDATE, DELETE ON sync_pair_nodes TO doug;
--GRANT SELECT, INSERT, UPDATE, DELETE ON sync_pair TO doug;
--GRANT SELECT, INSERT, UPDATE, DELETE ON sync_node TO doug;

/*
sync_pair_nodes			>---*:1--- sync_node
	|-- NodeId  			>------- NodeId
	|-- NodeId  			>------- TargetNodeId
*/
ALTER TABLE sync_pair_nodes ADD CONSTRAINT FK_sync_pair_nodes_source_source_node 	
FOREIGN KEY(NodeId) REFERENCES sync_node (NodeId);

ALTER TABLE sync_pair_nodes ADD CONSTRAINT FK_sync_pair_nodes_source_target_node 	
FOREIGN KEY(TargetNodeId) REFERENCES sync_node (NodeId);

/*
sync_pair_nodes			>---*:1--- sync_pair
	|-- PairId  			>------- PairId
*/
ALTER TABLE sync_pair_nodes ADD CONSTRAINT FK_sync_pair_nodes_sync_pair 	
FOREIGN KEY(PairId) REFERENCES sync_pair (PairId);

/*
sync_pair_nodes			>---*:1--- sync_pair
	|-- PairId  			>------- PairId
*/
ALTER TABLE sync_pair_nodes ADD CONSTRAINT FK_sync_pair_nodes_sync_data_version 	
FOREIGN KEY(SeededDataVersion) REFERENCES sync_data_version (DataVersionName);

/*
sync_peer_state		>---*:1--- sync_node
	|--	NodeId			>------- NodeId
*/
ALTER TABLE sync_peer_state ADD CONSTRAINT FK_sync_peer_state_sync_node 	
FOREIGN KEY(NodeId) REFERENCES sync_node (NodeId);

/*
sync_peer_state 	>---*:1--- sync_state 
	|--	EntityId		>------- EntityId
	|--	RecordId  		>------- RecordId
*/
ALTER TABLE sync_peer_state ADD CONSTRAINT FK_sync_peer_state_sync_state 	
FOREIGN KEY(EntitySingularName, RecordId) REFERENCES sync_state (EntitySingularName, RecordId);

/*
sync_node			>---*:1--- sync_data_version
	|--	DataVersionId	>------- DataVersionId
*/
ALTER TABLE sync_node ADD CONSTRAINT FK_sync_node_sync_data_version 	
FOREIGN KEY(DataVersionName) REFERENCES sync_data_version (DataVersionName);

/*
sync_state				>---*:1--- sync_data_entity
	|-- EntityId  			>------- EntityId
*/
ALTER TABLE sync_state ADD CONSTRAINT FK_sync_state_sync_entity 		
FOREIGN KEY(EntitySingularName) REFERENCES sync_data_entity (EntitySingularName);

/*
sync_state				>---*:1--- sync_data_version
	|-- DataVersionName  			>------- DataVersionName
*/
ALTER TABLE sync_state ADD CONSTRAINT FK_sync_state_sync_data_version 		
FOREIGN KEY(DataVersionName) REFERENCES sync_data_version (DataVersionName);

/*
sync_data_field			>---*:1--- sync_data_entity
	|-- EntityId  			>------- EntityId
*/
ALTER TABLE sync_data_entity ADD CONSTRAINT FK_sync_data_entity_sync_data_version 		
FOREIGN KEY(DataVersionName) REFERENCES sync_data_version (DataVersionName);

/*
sync_data_field			>---*:1--- sync_data_entity
	|-- EntityId  			>------- EntityId
*/
ALTER TABLE sync_data_field ADD CONSTRAINT FK_sync_data_field_sync_data_entity 		
FOREIGN KEY(EntitySingularName) REFERENCES sync_data_entity (EntitySingularName);

/*
sync_data_field			>---*:1--- sync_data_version
	|-- DataVersion  			>------- DataVersion
*/
ALTER TABLE sync_data_field ADD CONSTRAINT FK_sync_data_field_sync_data_version 		
FOREIGN KEY(DataVersionName) REFERENCES sync_data_version (DataVersionName);
