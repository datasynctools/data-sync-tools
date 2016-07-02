# Data Sync Tools Roadmap

# YOU ARE HERE 0.6.x
* Sync between iOS and Server with no conflict resolution (add, update, delete) on a single entity with iOS Persistence Client, iOS Sync Client, Go Sync Agent
  * Add - Done
  * Update - Done
  * Delete - *NOT STARTED*
  * Unit Tests with 80% Coverage - Started
  * Integration Tests with Detailed Verification 80% Coverage - Started
  * First cut Persistence client (iOS), Sync Client (iOS), Sync Agent (go)
    * Persistence client (iOS) - Done
    * Sync Client (iOS) - Done
    * Sync Agent (go) - Done

# 0.7.x
* Conflict Resolution
* Opportunistic refactoring (api concept doc started)
* Test refactoring started

# 0.8.x
* Multiple complex-related entities (including multiple threads within a entity optimization)
* Opportunistic refactoring (api concept doc started)
* Test refactoring continued

# 0.9.x
* Data Version Support

# 0.10.x
* Low hanging fruit performance optimizations (reduced network connectivity & improve caching)

# 0.11.x
* Filtered Sync

# 0.12.x
* Security added: 1. Sync Session Creation (can't start a sync session between two nodes without authentication), 2. Sync Session Msgs (protect against node hoping: after being authenticated between two nodes, don't allow a client to trick the agent into updating data for a different node), 3. HTTP/S (TLS), 4. Protections against SQL Injection
* Refactor designed (api concept matured)

# 0.13.x - Threads Ready
* Threads ready: bi-directional sync with auto-client registration, full and filtered data sync, sync security
* Big Refactor for common Interfaces
* All tests at >80%
* Swift Client Interfaces for iOS 1.0 RC1
* Server Interfaces for Linux, Mac RC1

# 0.14.x
* Embedded SQLLite Server implementation
* Database refactoring (api concept matured)
* Database tests >80%

# 0.15.x
* Multi-tenancy, Application Domains, and Shared Models between all (with ownership model)

# 0.16.x
* Server Interfaces for Linux, Mac, Windows 1.0 RC1

# 0.17.x
* Simple Web Management Console
* Solicit Seed Customers/Clients

# 0.18.x
* Android Development
* Java Client Interfaces for Android RC1
* Documentation Updated

# 1.0
* First Public Release
* Contributors Guide
* License Determined
* Supported Environments (Tested)

| Per. Client | Sync Client | Sync Agent | Language Interfaces | OSes | Platforms | Databases |
| ----------- | ----------- | ------ | ------------------- | ---- | --------- | --------- |
| Y           | Y           |        | Swift               | <ul><li>IOS</ul></li> | <ul><li>IOS-ARM</ul></li> | <ul><li>SLITE-IOS-ARM-CD</li></ul> |
| Y           |             |        | Java                | <ul><li>AND</ul></li> | <ul><li>AND-ARM</ul></li> | <ul><li>SLITE-IOS-ARM-JD</ul></li> |
| Y           | Y           | Y      | Go                  | <ul><li>LIN</li><li>OSX</li></ul> | <ul><li>LIN-X64</li><li>LIN-ARM</li><li>OSX-64</li></ul> | <ul><li>POSTG-LIN-X64-NA</li><li>POSTG-OSX-X64-NA</li><li>SLITE-LIN-ARM-NA</li><li>SLITE-LIN-X64-NA</li><li>SLITE-OSX-X64-NA</li></ul> |

* Available Environments. (Built/Availble But Not Tested. This is in the category of it theoretically "should work" but it has not even been booted up for connection to confirm)

| Per. Client | Sync Client | Sync Agent | Language Interfaces | OSes | Platforms | Databases      |
| ----------- | ----------- | ------ | ------------------- | ---- | --------- | -------------- |
| Y           | Y           |        | Swift               | OSX  | <ul><li>OSX-X64</li></ul> | <ul><li>POSTG-OSX-X64</li><li>SLITE-OXS-X64</li></ul> |
| Y           |             |        | Java                | <ul><li>LIN</li><li>OSX</li><li>WIN</li></ul> | <ul><li>LIN-X32</li><li>LIN-X64</li><li>OSX-X64</li><li>WIN-X32</li><li>WIN-X64</li></ul>         | <ul><li>POSTG-LIN-X32-JD</li><li>POSTG-LIN-X64-JD</li><li>POSTG-OSX-X64-JD</li><li>POSTG-WIN-X32-JD</li><li>POSTG-WIN-X64-JD</li></ul> |
| Y           | Y           | Y      | Go                  | <ul><li>LIN</li><li>WIN</li></ul> | <ul><li>LIN-X32</li><li>WIN-X64</li><li>WIN-X32</li></ul> | <ul><li>POSTG-LIN-X32-NA</li><li>POSTG-WIN-X32-NA</li><li>POSTG-WIN-X64-NA</li></ul> |

# 1.1.x
* Performance testing harness
* Performance optimization (non-API changes)

# 1.2.x
* Model Generation Beta

| Model Gen | Per. Client | Sync Client | Sync Agent | Language Interfaces | OSes | Platforms | Databases |
| --------- | ----------- | ----------- | ------ | ------------------- | ---- | --------- | --------- |
| Y*        | Y           | Y           |        | Swift               | <ul><li>IOS</ul></li> | <ul><li>IOS-ARM</ul></li> | <ul><li>SLITE-IOS-ARM-CD</li></ul> |
| Y*        | Y           |             |        | Java                | <ul><li>AND</ul></li> | <ul><li>AND-ARM</ul></li> | <ul><li>SLITE-IOS-ARM-JD</ul></li> |
| Y*        | Y           | Y           | Y      | Go                  | <ul><li>LIN</li><li>OSX</li></ul> | <ul><li>LIN-X64</li><li>LIN-ARM</li><li>OSX-64</li></ul> | <ul><li>POSTG-LIN-X64-NA</li><li>POSTG-OSX-X64-NA</li><li>SLITE-LIN-ARM-NA</li><li>SLITE-LIN-X64-NA</li><li>SLITE-OSX-X64-NA</li></ul> |
| Y*        |             |             |        | Python              | <ul><li>LIN</li></ul>  | <ul><li>AND-ARM</ul></li> | <ul><li>SLITE-LIN-ARM-NA</li></ul> |
| Y*        |             |             |        | .NET              | <ul><li>WIN</li></ul>  | <ul><li>WIN-X64</ul></li> | <ul><li>?</li></ul> |

\* Beta (Preview only)

# 2.0.x
* New datastore abstraction API
* Data Versioning and Upgrading Support
* Web Console Admin Introduced
* New Store: Excel (using datastore API). Support for Windows and OSX (using Go)
* Performance optimization (API changes)
* Model Generation Supported (API changes)

# 3.x
* New datastore: Cassandra
* Performance optimization (API changes)
* Model Generation (API changes)

# Legend
## Operating System

| Key | Name |
| --- | --- |
| LIN | Linux |
| AND | Android |
| IOS | iOS |
| OXS | OSX |
| WIN | Windows |

## Platforms (Architectures)

| # | Name | Architecture |
| -- | -- | -- |
| LIN-X64 | Linux | amd64 |
| LIN-X32 | Linux | x86 |
| LIN-ARM | Linux | arm |
| AND-ARM | Android | arm |
| IOS-ARM | iOS | arm |
| OSX-X64 | OSX | amd64 |
| WIN-X64 | Windows | amd64 |
| WIN-X32 | Windows | x86 |

## Database Platforms, API, and Architectures
| Key             | Name  | Operating System Key | Architecture # | API |
| :---------------| ----------- | --- | ------- | --------- |
| POSTG-LIN-X64-NA | PostgresSQL | LIN | LIN-X64 | Native    |
| POSTG-LIN-X32-NA | PostgresSQL | LIN | LIN-X32 | Native    |
| POSTG-OSX-X64-NA | PostgresSQL | OIN | OSX-X64 | Native    |
| POSTG-WIN-X64-NA | PostgresSQL | WIN | WIN-X64 | Native    |
| POSTG-WIN-X64-NA | PostgresSQL | WIN | WIN-X32 | Native    |
| POSTG-LIN-X64-JD | PostgresSQL | LIN | LIN-X64 | JDBC      |
| POSTG-LIN-X32-JD | PostgresSQL | LIN | LIN-X32 | JDBC      |
| POSTG-OSX-X64-JD | PostgresSQL | OIN | OSX-X64 | JDBC      |
| POSTG-WIN-X64-JD | PostgresSQL | WIN | WIN-X64 | JDBC      |
| POSTG-WIN-X64-JD | PostgresSQL | WIN | WIN-X32 | JDBC      |
| SLITE-LIN-X64-NA | SQLite      | LIN | LIN-X64 | Native    |
| SLITE-LIN-X32-NA | SQLite      | LIN | LIN-X32 | Native    |
| SLITE-LIN-ARM-NA | SQLite      | LIN | LIN-ARM | Native    |
| SLITE-AND-ARM-JD | SQLite      | LIN | LIN-ARM | JDBC      |
| SLITE-IOS-ARM-CD | SQLite      | IOS | IOS-ARM | Core Data |
| SLITE-OXS-X64-CD | SQLite      | OSX | OSX-X64 | Core Data |
| SLITE-WIN-X64-NA | SQLite      | WIN | WIN-X64 | Native    |
| SLITE-WIN-X64-NA | SQLite      | WIN | WIN-X32 | Native    |
| CASS-LIN-X64-CQL | Cassandra   | LIN | LIN-X64 | CQL       |
