--Create Contacts
CREATE TABLE contacts (
	ContactId		varchar(36)		NOT NULL,
	DateOfBirth		timestamp		NULL,
	FirstName		varchar(36)		NULL,
	LastName		varchar(36)		NULL,
	HeightFt		int				NULL,
	HeightInch		real			NULL,
	PreferredHeight	smallint		NOT NULL	default(1),
	PRIMARY KEY (ContactId)
);

--1: sync_data_version
insert into sync_data_version (DataVersionName) values ('Demo Model 1');
insert into sync_data_version (DataVersionName) values ('Demo Model 2 (orphand node)');

--2: sync_entity
INSERT INTO sync_data_entity (EntityName,DataVersionName,ProcOrderAddUpdate,ProcessOrderDelete,EntityHandlerUri,RecordCreated) values ('Entity 1','Demo Model 1',1,4,'none','2015-10-14 08:40:05.000');
INSERT INTO sync_data_entity (EntityName,DataVersionName,ProcOrderAddUpdate,ProcessOrderDelete,EntityHandlerUri,RecordCreated) values ('Entity 2','Demo Model 1',2,3,'none','2015-10-14 08:40:05.000');
INSERT INTO sync_data_entity (EntityName,DataVersionName,ProcOrderAddUpdate,ProcessOrderDelete,EntityHandlerUri,RecordCreated) values ('Entity 3','Demo Model 1',2,3,'none','2015-10-14 08:40:05.000');
INSERT INTO sync_data_entity (EntityName,DataVersionName,ProcOrderAddUpdate,ProcessOrderDelete,EntityHandlerUri,RecordCreated) values ('Entity 4','Demo Model 1',3,2,'none','2015-10-14 08:40:05.000');
INSERT INTO sync_data_entity (EntityName,DataVersionName,ProcOrderAddUpdate,ProcessOrderDelete,EntityHandlerUri,RecordCreated) values ('Entity 5','Demo Model 1',4,1,'none','2015-10-14 08:40:05.000');

--3: sync_state
INSERT INTO sync_state (EntityName,RecordId,DataVersionName,RecordHash,RecordData,RecordBytesSize,IsDelete,RecordCreated) VALUES ('Entity 1','*record-1','Demo Model 1','hash-1','<record data>',10,'false','2015-10-14 08:40:05.000');
INSERT INTO sync_state (EntityName,RecordId,DataVersionName,RecordHash,RecordData,RecordBytesSize,IsDelete,RecordCreated) VALUES ('Entity 1','*record-2','Demo Model 1','hash-2','<record data>',11,'false','2015-10-14 08:40:05.000');
INSERT INTO sync_state (EntityName,RecordId,DataVersionName,RecordHash,RecordData,RecordBytesSize,IsDelete,RecordCreated) VALUES ('Entity 1','*record-3','Demo Model 1','hash-3','<record data>',12,'false','2015-10-14 08:40:05.000');

--4: sync_node
INSERT INTO sync_node(nodeId,nodeName, DataVersionName) VALUES('*node-spoke1','A', 'Demo Model 1');
INSERT INTO sync_node(nodeId,nodeName, DataVersionName) VALUES('*node-spoke2','B', 'Demo Model 2 (orphand node)'); --this one has orphaned data profile
INSERT INTO sync_node(nodeId,nodeName, DataVersionName) VALUES('*node-spoke3','C', 'Demo Model 1');
INSERT INTO sync_node(nodeId,nodeName, DataVersionName) VALUES('*node-hub','Z', 'Demo Model 1');

--5: sync_peer_state
INSERT INTO sync_peer_state (NodeId,EntityName,RecordId,SessionBindId,TransactionBindId,SentLastKnownHash,PeerLastKnownHash,IsConflict,SentSyncState,ChangedByClient,LastUpdated) VALUES ('*node-hub','Entity 1','*record-1',NULL,NULL,NULL,NULL,'false',0,'true','2015-10-14 08:40:05.000');
INSERT INTO sync_peer_state (NodeId,EntityName,RecordId,SessionBindId,TransactionBindId,SentLastKnownHash,PeerLastKnownHash,IsConflict,SentSyncState,ChangedByClient,LastUpdated) VALUES ('*node-hub','Entity 1','*record-2',NULL,NULL,NULL,NULL,'false',0,'true','2015-10-14 08:40:05.000');
INSERT INTO sync_peer_state (NodeId,EntityName,RecordId,SessionBindId,TransactionBindId,SentLastKnownHash,PeerLastKnownHash,IsConflict,SentSyncState,ChangedByClient,LastUpdated) VALUES ('*node-hub','Entity 1','*record-3',NULL,NULL,NULL,NULL,'false',0,'true','2015-10-14 08:40:05.000');

--6: sync_data_field
INSERT INTO sync_data_field (EntityName, FieldName, DataTypeName, DataVersionName) VALUES ('Entity 1','FirstName','String','Demo Model 1');
INSERT INTO sync_data_field (EntityName, FieldName, DataTypeName, DataVersionName) VALUES ('Entity 1','LastName','String','Demo Model 1');

--7: sync_pair
INSERT INTO sync_pair(PairId,PairName) VALUES('*pair-1','A <-> Z');
INSERT INTO sync_pair(PairId,PairName) VALUES('*pair-2','B <-> Z');
INSERT INTO sync_pair(PairId,PairName) VALUES('*pair-3','A <-> B (Partial)');
INSERT INTO sync_pair(PairId,PairName) VALUES('*pair-4','C <-> Z (Dup 1 or 2)');
INSERT INTO sync_pair(PairId,PairName) VALUES('*pair-5','C <-> Z (Dup 2 or 2)');

--8: sync_pair_nodes
INSERT INTO sync_pair_nodes(pairId,NodeId,targetNodeId,SeededDataVersion,SyncConflictUri) VALUES('*pair-1','*node-hub','*node-spoke1','Demo Model 1','none');
INSERT INTO sync_pair_nodes(pairId,NodeId,targetNodeId,SeededDataVersion,SyncConflictUri) VALUES('*pair-1','*node-spoke1','*node-hub','Demo Model 1','none');
INSERT INTO sync_pair_nodes(pairId,NodeId,targetNodeId,SeededDataVersion,SyncConflictUri) VALUES('*pair-2','*node-hub','*node-spoke2','Demo Model 1','none');
INSERT INTO sync_pair_nodes(pairId,NodeId,targetNodeId,SeededDataVersion,SyncConflictUri) VALUES('*pair-2','*node-spoke2','*node-hub','Demo Model 1','none');
INSERT INTO sync_pair_nodes(pairId,NodeId,targetNodeId,SeededDataVersion,SyncConflictUri) VALUES('*pair-3','*node-spoke2','*node-spoke1','Demo Model 1','none');
INSERT INTO sync_pair_nodes(pairId,NodeId,targetNodeId,SeededDataVersion,SyncConflictUri) VALUES('*pair-4','*node-hub','*node-spoke3','Demo Model 1','none');
INSERT INTO sync_pair_nodes(pairId,NodeId,targetNodeId,SeededDataVersion,SyncConflictUri) VALUES('*pair-4','*node-spoke3','*node-hub','Demo Model 1','none');
INSERT INTO sync_pair_nodes(pairId,NodeId,targetNodeId,SeededDataVersion,SyncConflictUri) VALUES('*pair-5','*node-hub','*node-spoke3','Demo Model 1','none');
INSERT INTO sync_pair_nodes(pairId,NodeId,targetNodeId,SeededDataVersion,SyncConflictUri) VALUES('*pair-5','*node-spoke3','*node-hub','Demo Model 1','none');
