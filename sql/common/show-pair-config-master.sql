SELECT        sync_node.NodeId, sync_node.NodeName, sync_node.DataMsgConsUri, sync_node.DataMsgProdUri, sync_node.MgmtMsgConsUri, sync_node.MgmtMsgProdUri, 
                         sync_node.SyncDataPersistForm, sync_node.InMsgBatchSize, sync_node.MaxOutMsgBatchSize, 
                         sync_node.InChanDepthSize, sync_node.MaxOutChanDepthSize ,sync_pair.PairId, sync_pair.PairName, sync_pair.MaxSesDurValue, sync_pair.MaxSesDurUnit, sync_pair.SyncDataTransForm, sync_pair.SyncMsgTransForm, sync_pair.SyncMsgSecPol, 
                         sync_pair.SyncSessionId, sync_pair.SyncSessionState, sync_pair.SyncSessionStart, sync_pair.SyncConflictUri, sync_data_version.VersionName
FROM            sync_node INNER JOIN
                         sync_pair_nodes ON sync_node.NodeId = sync_pair_nodes.NodeId INNER JOIN
                         sync_pair ON sync_pair_nodes.PairId = sync_pair.PairId INNER JOIN
                         sync_pair_data_versions ON sync_pair.DataVersionMapId = sync_pair_data_versions.DataVersionMapId INNER JOIN
                         sync_data_version ON sync_pair_data_versions.VersionId = sync_data_version.VersionId
WHERE        (sync_node.NodeName = 'A') 
--OR
--                         (sync_node.NodeName = 'Z')