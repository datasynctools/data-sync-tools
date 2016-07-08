--For Intializing, how to check if a previously queued records has changed (if a result is greater than 0, then all data is NOT queued)
select count(*) from sync_peer_state where 
	ChangedByClient = '0' 
and
		NodeId = '*node-spoke1'
and
	RecordId in (
		SELECT RecordId from sync_peer_state 	where SentLastKnownHash not in	(
		SELECT  SentLastKnownHash       
		FROM            sync_peer_state INNER JOIN
                         sync_state ON sync_peer_state.EntityId = sync_state.EntityId AND 
						 sync_peer_state.RecordId = sync_state.RecordId AND 
						 sync_peer_state.SentLastKnownHash = sync_state.RecordHash)
	) 
and
	EntityId in (
		SELECT EntityId from sync_peer_state 	where SentLastKnownHash not in	(
		SELECT  SentLastKnownHash       
		FROM            sync_peer_state INNER JOIN
                         sync_state ON sync_peer_state.EntityId = sync_state.EntityId AND 
						 sync_peer_state.RecordId = sync_state.RecordId AND 
						 sync_peer_state.SentLastKnownHash = sync_state.RecordHash)
	);
