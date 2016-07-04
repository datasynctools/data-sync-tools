# DataSync.Tools

DataSync.Tools provides data synchronization services. The capabilities roadmap includes:

**1. Comprehensive Data Sync**

| Feature                   | Description               | Target Release |
| ------------------------- | ------------------------- | -------------- |
| Smart Persistence         | Where possible, hook into the pipeline of altering data data to optimize the sync flow via a Persistence Client                                  | 1.0             | 
| Communications Management | Abstract the developer from having to manage network communications through Sync Client & Agent                                                    | 1.0             | 
| Cluster Management        | APIs to manage metadata, nodes, sessions, maintenance mode (read/write, read only, disabled), and more                                             | 1.0             | 
| Partial Sync Support      | Allow data repositories with selective sync based on person, device type, or other configurable partial sync parameters                         | 1.0             | 
| Conflict Resolvers        | Common resolution strategies: NamedNodeWinner, TimeStampWinner(first,last), UserIntervension and Custom Conflict Resolver Plugins               | 1.0             | 

**2. Rich Platform Support**

| Feature                   | Description               | Target Release |
| ------------------------- | ------------------------- | -------------- |
| Operating Platforms       | Support for multiple operating system | 1.0 | 
| Databases                 | Support for multiple databases        | 1.0 |
| Language APIs             | Support for Language APIs             | 1.0 |

**3. Security**

| Feature                   | Description               | Target Release |
| ------------------------- | ------------------------- | -------------- |
| Authorization        | Sync (who can sync to whom), Cluster Management, Partial Sync | 1.0             | 
| Authentication       | Sync (who can sync to whom), Cluster Management               | 1.0             |
| Encryption           | Sync Payload                                                  | 2.0             |

**4. Integrated Data Modeling**

| Feature                   | Description               | Target Release |
| ------------------------- | ------------------------- | -------------- |
| Web-based Modeling             | Data modeling for synchronization is available through a web browser              | 2.0 |
| Cross-Language Code Generators | Data modeling for synchronization generates code helper code in various langauges | 2.0 |

**5. Natural Message Queuing**

| Feature                   | Description               | Target Release |
| ------------------------- | ------------------------- | -------------- |
| Persistent Queue               | Reliably, Efficiently, and Asynchronously Send-Receive Msgs through persistence syntax | 3.0 |
| Configurable Sync vs. Queue | Persistence syntax is configurable external to the application for switching between sync and queue behavior | 3.0 |
| Expired Messages               | Queued Messages expire based on time | 3.0 |

For more details see [Roadmap](Roadmap.md)

# Architecture Architecture

Basic Terms:
* **Sync Node** - a named data store (or parts of a data store) for syncing
* **Sync Session** - a unique identifier used to gather statics and control a synchornization instance

Major API Categories architectural areas:

1. **Persistence Client** - packages up changes to a data store in an optimized sync format 

1. **Change Client** - notifies an application sync node of changes from a Sync Client or Sync Agent 

1. **Sync Client** - orchestrates the initiation and flow of a sync session as well as maintains sync state of a local sync node

1. **Sync Agent** - handles sync client commands and maintains sync state for a local sync node

# Code Examples
## Persistence Client 
Insert code example here....

## Change Client attached to Sync Client 
Insert code example here....

## Change Client attached to Sync Agent 
Insert code example here....

## Sync Client 
Insert code example here....

## Sync Agent 
Insert code example here....

# Useful Links

* [Setting up a Development Enviornment](DevEnv.md)


# Unit Test Server (Go Code)

1. Change directories to the root source folder
(e.g. '/Users/doug/Documents/GitHub/threads/src/go/DataSyncToolsServer/')
2. Start server dependencies:
	- Postgress Database
	- Make sure database is installed (see 'src/sql/postgressql/create-database.sql'
3. Run 'go test -cover'

# Integration Test ClientServer (Swift-Go Code)

1. Change directories to the root source folder
(e.g. '/Users/doug/Documents/GitHub/threads/src/go/DataSyncToolsServer/')
2. Start server dependencies:
	- Postgress Database
	- Make sure database is installed (see 'src/sql/postgressql/create-database.sql'
3. Make Sure that test data is setup for dependencies:
	- '/src/sql/postgressql/create-data-sync-tools.sql'
	- '/src/sql/common/create-test-data.sql'
	- ''
3. Start Server './DataSyncToolsServer -dbusr doug -dbnm threads -dbpt 5432' or full command w/password as in './DataSyncToolsServer -dbusr doug -dbnm threads -dbpw myPw1 -dbpt 5432'
4. Test that Server is up and running:
	- 'http://localhost:8080/syncPairConfig/node1Name/A/node2Name/Z'
	- Expected:
	`{
		pairId: "*pair-1",
		pairName: "A <-> Z",
		...
		node1: {
			nodeId: "*node-spoke1",
			nodeName: "A",
			enabled: true,'
		...
		}
	}`


# Notes for Data Sync Tools Doc

Reserved Entity Names:
* entityName - reason: reserved by core data (conflicts with NSManagedObject)
* entity - reason: reserved by core data (conflicts with NSManagedObject)

# Notes for debugging

* iOS Core Data Model file: /Users/doug/Library/Developer/Xcode/DerivedData/DataSyncToolsCore-gskgwwwkeihspofdyurkdfblpzlr/Build/Products/Debug-iphonesimulator/DataSyncToolsCore.framework/TestModel.momd/TestModel.mom (where 'DataSyncToolsCore-gsk...' is the derived data folder for the project)
* iOS Core Data sqllite file: /Users/doug/Library/Developer/CoreSimulator/Devices/C8ED699D-6309-4775-A4A2-18B2385C0338/data/Documents/TestModel.sqlite (where 'C8ED...' is the id of the device)

#Tasks
* Rationalize field name mapping
