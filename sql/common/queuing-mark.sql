--For Queuing, marks the finite data set to be synced in this session
update sync_peer_state set SessionBindId='my-session-id-1' where NodeId='*node-spoke1' and ChangedByClient = '1'
