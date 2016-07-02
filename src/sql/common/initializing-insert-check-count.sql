--For Intializing, how to check if previously unqueued records are present (if a result is greater than 0, then all data is NOT queued)
select count(RecordId) from sync_state where 
						RecordId not in (
SELECT        sync_peer_state.RecordId
FROM            sync_peer_state INNER JOIN
                         sync_state ON sync_peer_state.EntityId = sync_state.EntityId AND sync_peer_state.RecordId = sync_state.RecordId
WHERE        (sync_peer_state.NodeId = '*node-spoke1')
);