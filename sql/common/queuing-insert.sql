--For Queuing, how to mark previously unqueued records
insert into sync_peer_state (NodeId, EntityId, RecordId, SentLastKnownHash, ChangedByClient) 
select '*node-spoke1' NodeId, EntityId, RecordId, RecordHash, '1' ChangedByClient from sync_state where 
						RecordId not in (
SELECT        sync_peer_state.RecordId
FROM            sync_peer_state INNER JOIN
                         sync_state ON sync_peer_state.EntityId = sync_state.EntityId AND sync_peer_state.RecordId = sync_state.RecordId
WHERE        (sync_peer_state.NodeId = '*node-spoke1')
);