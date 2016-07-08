SELECT      sync_version_entities.ProcOrderAddUpdate, sync_version_entities.ProcessOrderDelete, sync_entity.EntityName, sync_entity.EntityHandlerUri
FROM            sync_data_version INNER JOIN
                         sync_version_entities ON sync_data_version.VersionId = sync_version_entities.VersionId INNER JOIN
                         sync_entity ON sync_version_entities.EntityId = sync_entity.EntityId CROSS JOIN
                         sync_node
WHERE        (sync_node.NodeName = 'A') 
--OR
--                         (sync_node.NodeName = 'Z')
--ORDER BY sync_node.NodeName