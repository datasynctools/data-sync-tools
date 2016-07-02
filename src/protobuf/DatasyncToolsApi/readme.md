#Environment Setup

1. Install go protocol buffers as instructed: https://github.com/golang/protobuf
2. Install swift protocol buffers as instructed: https://github.com/alexeyxo/protobuf-swift
3. Build the protocol buffers file:
* protoc --go_out=. --swift_out=. -o schema.pb *.proto