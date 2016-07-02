SELECT        sync_pair.PairId, sync_pair.PairName, sync_pair.MaxSesDurValue, sync_pair.MaxSesDurUnit, sync_pair.SyncDataTransForm, sync_pair.SyncMsgTransForm, 
                         sync_pair.SyncMsgSecPol, sync_pair.SyncSessionId, sync_pair.SyncSessionState, sync_pair.SyncSessionStart, sync_pair.SyncConflictUri, sync_pair.RecordCreated
FROM            sync_node INNER JOIN
                         sync_pair_nodes ON sync_node.NodeId = sync_pair_nodes.NodeId INNER JOIN
                         sync_pair ON sync_pair_nodes.PairId = sync_pair.PairId where ( 

 ( (sync_pair_nodes.NodeId = (select sync_node.NodeId from sync_node where(sync_node.NodeName = 'A'))) AND
   (sync_pair_nodes.TargetNodeId = (select sync_node.NodeId from sync_node where(sync_node.NodeName = 'Z'))) ) OR
 ( (sync_pair_nodes.NodeId = (select sync_node.NodeId from sync_node where(sync_node.NodeName = 'Z'))) AND
   (sync_pair_nodes.TargetNodeId = (select sync_node.NodeId from sync_node where(sync_node.NodeName = 'A'))) )

);


-- Get Nodes from Session Id
SELECT        NodeName, DataVersionName
FROM            sync_node right join (SELECT        NodeId
	FROM            sync_pair_nodes
	WHERE        (PairId = (
		SELECT        PairId
		FROM            sync_pair
		WHERE        (SyncSessionId = 'a')
		)
	)
) as A on sync_node.NodeId = A.NodeId

--SELECT        sync_node.*
--FROM            sync_node INNER JOIN
--                         sync_pair_nodes ON sync_node.NodeId = sync_pair_nodes.NodeId INNER JOIN
--                         sync_pair ON sync_pair_nodes.PairId = sync_pair.PairId
--WHERE        (sync_pair_nodes.PairId = '*pair-1' and sync_node.NodeName='A')

--update sync_peer_state set ChangedByClient='0' where RecordId='*record-2' and NodeId='*node-spoke1';
--update sync_peer_state set ChangedByClient='0' where RecordId='*record-3' and NodeId='*node-spoke1';

--update sync_state set RecordHash='hash-2a' where RecordId='*record-2';
--update sync_state set RecordHash='hash-3a' where RecordId='*record-3';


--delete from sync_peer_state where NodeId = '*node-spoke1'			

--select * from sync_pair;
--update sync_node set datamsgconsuri='hi' where NodeId in (select NodeId from sync_node limit 1);
--select * from sync_node
--select * from sync_node limit 1
--delete from sync_pair
--delete from sync_node
--Select SyncSessionId from sync_pair where PairId='79EC415D-FC24-416B-A5D7-73F185B1B4DA'


--SELECT        sync_pair.PairId, sync_pair.PairName, sync_pair.MaxSesDurValue, sync_pair.MaxSesDurUnit, sync_pair.SyncDataTransForm, sync_pair.SyncMsgTransForm, 
--                         sync_pair.SyncMsgSecPol, sync_pair.SyncSessionId, sync_pair.SyncSessionState, sync_pair.SyncSessionStart, sync_pair.SyncConflictUri, sync_pair.RecordCreated
--FROM            sync_node INNER JOIN
--                         sync_pair_nodes ON sync_node.NodeId = sync_pair_nodes.NodeId INNER JOIN
--                         sync_pair ON sync_pair_nodes.PairId = sync_pair.PairId where ( 
--
-- ( (sync_pair_nodes.NodeId = (select sync_node.NodeId from sync_node where(sync_node.NodeName = 'A'))) AND
--   (sync_pair_nodes.TargetNodeId = (select sync_node.NodeId from sync_node where(sync_node.NodeName = 'D'))) ) OR
-- ( (sync_pair_nodes.NodeId = (select sync_node.NodeId from sync_node where(sync_node.NodeName = 'D'))) AND
--   (sync_pair_nodes.TargetNodeId = (select sync_node.NodeId from sync_node where(sync_node.NodeName = 'A'))) )
--) limit 3;

--For Queuing, how to mark the records queued for syncing
--insert into sync_peer_state (NodeId, EntityId, RecordId) 
--select '*node-spoke1' NodeId, EntityId, RecordId from sync_state where 
--						RecordId not in (
--SELECT        sync_peer_state.RecordId
--FROM            sync_peer_state INNER JOIN
--                         sync_state ON sync_peer_state.EntityId = sync_state.EntityId AND sync_peer_state.RecordId = sync_state.RecordId
--WHERE        (sync_peer_state.NodeId = '*node-spoke1')
--);




--select '*node-spoke1' HardCodedNodeId, EntityId, RecordId, RecordHash from sync_state where 
--						RecordId not in (
--SELECT        sync_peer_state.RecordId
--FROM            sync_peer_state INNER JOIN
--                         sync_state ON sync_peer_state.EntityId = sync_state.EntityId AND sync_peer_state.RecordId = sync_state.RecordId
--WHERE        (sync_peer_state.NodeId = '*node-spoke1')
--);


--Update sync_pair SET SyncSessionId='', SyncSessionStart=$3, SyncSessionState='Initializing' 
--where PairId='*pair-1' SyncSessionState='Inactive';`

--SELECT        sync_pair.PairId, sync_pair.PairName, sync_pair.MaxSesDurValue, sync_pair.MaxSesDurUnit,
--sync_pair.SyncDataTransForm, sync_pair.SyncMsgTransForm,sync_pair.SyncMsgSecPol, sync_pair.SyncSessionId, 
--sync_pair.SyncSessionState, sync_pair.SyncSessionStart, sync_pair.SyncConflictUri, sync_pair.RecordCreated
--FROM            sync_node INNER JOIN
--                         sync_pair_nodes ON sync_node.NodeId = sync_pair_nodes.NodeId INNER JOIN
--                         sync_pair ON sync_pair_nodes.PairId = sync_pair.PairId
--WHERE        (sync_node.NodeName = 'A') OR
--                         (sync_node.NodeName = 'B');

--Update sync_pair SET SyncSessionId=null, SyncSessionStart=null, SyncSessionState='Inactive' where PairId='79EC415D-FC24-416B-A5D7-73F185B1B4DA' and SyncSessionState<>'Inactive' and SyncSessionId='F60E6276-7114-4FFD-B2B0-C0CCF40119A1';
--Update sync_pair SET SyncSessionId=null, SyncSessionStart=null, SyncSessionState='Inactive' where PairId='*pair-1';
--Update sync_pair SET SyncSessionId=null, SyncSessionStart=null, SyncSessionState='Inactive' where PairId='79EC415D-FC24-416B-A5D7-73F185B1B4DA';
--Update sync_pair SET PairId='79EC415D-FC24-416B-A5D7-73F185B1B4DA', SyncSessionId='F43D8318-0026-42AC-BBFD-D5179404FC60', SyncSessionStart='2004-10-19 10:23:54.123', SyncSessionState='Initializing' where SyncSessionState='Inactive' and PairId='79EC415D-FC24-416B-A5D7-73F185B1B4DA';

--Update sync_pair SET SyncSessionId='F43D8318-0026-42AC-BBFD-D5179404FC60', SyncSessionStart='2004-10-19 10:23:54.123', SyncSessionState='Initializing' where SyncSessionState='Inactive' and PairId='*pair-1';

--Update sync_pair SET PairId='79EC415D-FC24-416B-A5D7-73F185B1B4DA', SyncSessionId='F43D8318-0026-42AC-BBFD-D5179404FC60', SyncSessionStart='2004-10-19 10:23:54.123', SyncSessionState='Initializing' where SyncSessionState='Inactive' and PairId='79EC415D-FC24-416B-A5D7-73F185B1B4DA';