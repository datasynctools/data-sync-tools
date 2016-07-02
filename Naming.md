
# Project Organization
```
${ProjectName}
	/src
		/iOS
			/${module}
			/...
		/AppleWatch (Future)
			/${module}
			/...
		/AppleCommon (Future)
			/${module}
			/...
		/AppleTV (Future)
		/dotNet (Future)
			/${module}
			/...
		/go
			/src/${module}
			/src/...
		/java
			/${module}
			/...
		/osX
			/${module}
			/...
		/protobuf
			/${module}
			/...
		/sql
			/${vendor}
			/...
```
# Language Naming

## Overall

## Go

* Follow guidance at https://blog.golang.org/package-names
* File Names
 * should use the singular
   * better: 'message.go'
   * worse: 'messages.go'
 * When establishing an interface that will be implemented in another package, file names should mirror a likely implementation files
   * better:
 ```
 ${ProjectName}
 	/src
 		/go/src/api/customer_repository.go
    /go/src/api/order_repository.go
    /go/src/database/mysql/customer_repository.go
    /go/src/database/mysql/order_repository.go
    /go/src/database/mysql/repository_util.go
 ```
   * worse:
```
${ProjectName}
 /src
   /go/src/api/customer_repository.go
   /go/src/api/order_repository.go
   /go/src/database/mysql/data_reader.go
   /go/src/database/mysql/data_writer.go
   /go/src/database/mysql/data_util.go
```

## Swift


* Follow api guidance at https://swift.org/documentation/api-design-guidelines.html
* Follow Naming guidance at http://programmers.stackexchange.com/questions/263521/swift-protocol-naming-conventions
