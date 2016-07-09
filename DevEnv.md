# Setting up a Development Enviornment

# Building Sync Agent (Go Code)

## Windows Pre-Requisites

* Install [Github Desktop](https://desktop.github.com/) and configure it to your github account
* Install [go](https://golang.org/dl/) and setup the enviornmental variable as illustrated in https://golang.org/doc/install#install and https://golang.org/doc/install#testing.
  * hint: on windows, GOPATH=C:\Users\(UserName)\Documents\GitHub
  * hint: on windows, add C:\Users\(UserName)\Documents\GitHub\bin to the windows PATH
* Install [data-sync-tools](https://github.com/datasynctools/data-sync-tools) to Github desktop to the "src" directory of your GOPATH.   
  * hint: on windows, install to C:\Users\(UserName)\Documents\GitHub\src. When finished 'C:\Users\(UserName)\Documents\GitHub\src\data-sync-tools'

## Pre Build Steps

1. If changes are made to the protocol buffers messages that affect file 'src/protobuf/DataSyncToolsApi/messages.pb.go', run steps 2-6. Else go to [Build Steps](DevEnv.md#build-steps).
2. Install go protocol buffers as instructed: https://github.com/golang/protobuf (only done once per dev environment).
3. For convenience, add the installed protoc program to your path. Also see https://groups.google.com/forum/#!topic/golang-nuts/Qs8d56uavVs
4. Open a command prompt to the "src/protobuf/DataSyncToolsApi" directory. Build the protocol buffers file:
for Winodws: "protoc --go_out=. -o schema.pb *.proto"
for Mac: "protoc --go_out=. -o schema.pb \*.proto"
5. Copy the file 'src/protobuf/DataSyncToolsAPI/Msgs/messages.pb.go' to 'src/go/src/datasync.tools/syncmsg/messages.pb.go' (replacing the existing file)
6. Open 'src/go/src/datasync.tools/syncmsg/messages.pb.go' and edit the page name from 'package messages' to 'package syncmsg'

## Build Steps

1. Change directories to 'go/cmd/DataSyncToolsAgent'
(e.g. '/Users/(UserName)/Documents/GitHub/src/data-sync-tools/go/cmd/DataSyncToolsAgent/')
2. run the command 'go build -o ~/bin/DataSyncToolsAgent' for unix-based environments or for windows 'go build -o %GOPATH%/bin/DataSyncToolsAgent.exe' to build for the platform of your compiler
- The above assumes a unix-style operating system. Convention is to add '.exe' for windows
- Point the -o path to your preferred output location as desired
3. For additional platforms setup the environment like so with Linux arm, Linux 32-bit, Linux 64-bit, Mac 64-bit, Windows 32-bit, and Windows 64-bit respectively:

Unix-style operation systems Example:
env GOOS=linux GOARCH=arm go build -o ~/bin/linux_arm/DataSyncToolsAgent
env GOOS=linux GOARCH=386 go build -o ~/bin/linux_386/DataSyncToolsAgent
env GOOS=linux GOARCH=amd64 go build -o ~/bin/linux_amd64/DataSyncToolsAgent
env GOOS=darwin GOARCH=amd64 go build -o ~/bin/darwin_amd64/DataSyncToolsAgent
env GOOS=windows GOARCH=386 go build -o ~/bin/windows_386/DataSyncToolsAgent.exe
env GOOS=windows GOARCH=amd64 go build -o ~/bin/windows_amd64/DataSyncToolsAgent.exe

Placeholder documentation, not complete. WARNING: *DO NOT USE*. Windows Example:
set GOOS=linux
set GOARCH=arm
go build -o %GOPATH%/bin/linux_arm/DataSyncToolsAgent

set GOOS=linux
set GOARCH=386
go build -o %GOPATH%/bin/linux_386/DataSyncToolsAgent

set GOOS=linux
set GOARCH=amd64
go build -o %GOPATH%/bin/linux_amd64/DataSyncToolsAgent

set env GOOS=darwin
set GOARCH=amd64
go build -o %GOPATH%/bin/darwin_amd64/DataSyncToolsAgent

set env GOOS=windows
set GOARCH=386 go build -o %GOPATH%/bin/windows_386/DataSyncToolsAgent.exe

set env GOOS=windows
set GOARCH=amd64
go build -o %GOPATH%/bin/windows_amd64/DataSyncToolsAgent.exe

See https://golang.org/doc/install/source#environment for a listing of other environments.
Other references:
- http://dave.cheney.net/2015/08/22/cross-compilation-with-go-1-5

## Generate Server Documentation

godoc server rendered documentation:
1. open up a command prompt
2. run 'godoc -notes=".\*" -http :6060'
3. open a web browser and go to 'http://localhost:6060/pkg/datasync.tools/'

static documentation: (unfinished documentation)
1. Change directories to 'src/go/src/datasync.tools/src'
2. run 'godoc -notes=".\*" -html datasync.tools/synchandler . > ~/Desktop/datasync.tools/synchandler.html'
3. run 'godoc -notes=".\*" -html datasync.tools/syncdao . > ~/Desktop/datasync.tools/syncdao.html'
4. run 'godoc -notes=".\*" -html datasync.tools/syncdao/syncdaopq . > ~/Desktop/datasync.tools/syncdaopq.html'

## Server Code Metrics

1. download and install 'https://github.com/fzipp/gocyclo'
2. run 'gocyclo -over 5 \*' on all code (the goal to have code that has a complexity under 5
3. download and install 'https://github.com/alecthomas/gometalinter'
4. run 'gometalinter | grep -v gotype | grep -v messages.pb.go'

## Server Code Coverage

Run the following 3 commands from 'synchandler':
go test -coverprofile=../../../../../../../../Desktop/coverage.out
go tool cover -func=../../../../../../../../Desktop/coverage.out
go tool cover -html=../../../../../../../../Desktop/coverage.out

Run the following 3 commands from 'syncdaopq':
go test -coverprofile=../../../../../../../../../Desktop/coverage.out
go tool cover -func=../../../../../../../../../Desktop/coverage.out
go tool cover -html=../../../../../../../../../Desktop/coverage.out

# Build Client (ios code)

## For 'DataSyncToolsAPI'
1. Bring up a command prompt in the root directory of the iOS project
2. Run 'carthage 'carthage bootstrap --platform iOS' (future runs can use 'carthage build --platform iOS')
3. If Changes are made to that affect Messages.proto.swift, run steps 4-6
4. Install go protocol buffers as instructed: https://github.com/golang/protobuf (only done once per dev environment)
5. Open a command prompt to the "/src/protobuf/DataSyncToolsApi" directory. Build the protocol buffers file:
protoc --go_out=. --swift_out=. -o schema.pb \*.proto
6. Copy the file 'Messages.proto.swift' to '/DataSyncToolsApi/DataSync/Messages.proto.swift' (replacing the existing file)
7. Open '/DataSyncToolsApi/DataSync/Messages.proto.swift' in your preferred editor. Make certain objects public by the following example. Find 'internal enum SentSyncStateEnum:Int32 {' and 'internal enum AckSyncStateEnum:Int32 {'. Change these to  to 'public enum SentSyncStateEnum:Int32 {' and 'internal enum AckSyncStateEnum:Int32 {'. Do the same for the following:
* SentSyncStateEnum (example above)
* AckSyncStateEnum (example above)
* SyncEntityMessageResponseResult
* SyncRequestEntityMessageResponseResult
8. Recompile the project
