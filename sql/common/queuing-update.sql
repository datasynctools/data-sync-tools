--For Queuing, how to mark changes to previously queued records
update sync_peer_state set ChangedByClient = '1' where 
	EntityId in (
		select EntityId from sync_peer_state where 
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
			)
	)
and
	RecordId in (
		select RecordId from sync_peer_state where 
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
			)
	)
and
	NodeId = '*node-spoke1';




--old
update sync_peer_state set ChangedByClient = '1' where 
	EntityId in (
		select EntityId from sync_peer_state where 
			ChangedByClient = '0' 
		and
			RecordId not in (
				SELECT        sync_peer_state.SentLastKnownHash
				FROM            sync_peer_state INNER JOIN
						         sync_state ON sync_peer_state.EntityId = sync_state.EntityId AND sync_peer_state.RecordId = sync_state.RecordId
				WHERE        (sync_peer_state.NodeId = '*node-spoke1')
			) 
		and
			EntityId not in (
				SELECT        sync_peer_state.SentLastKnownHash
				FROM            sync_peer_state INNER JOIN
						         sync_state ON sync_peer_state.EntityId = sync_state.EntityId AND sync_peer_state.RecordId = sync_state.RecordId
				WHERE        (sync_peer_state.NodeId = '*node-spoke1')
			)
		and 
			NodeId = '*node-spoke1'
	) 
and
	RecordId in (
		select RecordId from sync_peer_state where 
			ChangedByClient = '0' 
		and
			RecordId not in (
				SELECT        sync_peer_state.SentLastKnownHash
				FROM            sync_peer_state INNER JOIN
						         sync_state ON sync_peer_state.EntityId = sync_state.EntityId AND sync_peer_state.RecordId = sync_state.RecordId
				WHERE        (sync_peer_state.NodeId = '*node-spoke1')
			) 
		and
			EntityId not in (
				SELECT        sync_peer_state.SentLastKnownHash
				FROM            sync_peer_state INNER JOIN
						         sync_state ON sync_peer_state.EntityId = sync_state.EntityId AND sync_peer_state.RecordId = sync_state.RecordId
				WHERE        (sync_peer_state.NodeId = '*node-spoke1')
			)
		and 
			NodeId = '*node-spoke1'
	) 
and
	NodeId = '*node-spoke1';
