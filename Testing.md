
# Unit Testing Agent (Go Code)

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


