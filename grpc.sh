#!/bin/bash

git clone https://github.com/grpc/grpc-go.git /root/go/src/google.golang.org/grpc
git clone https://github.com/golang/net.git /root/go/src/golang.org/x/net
git clone https://github.com/golang/text.git /root/go/src/golang.org/x/text
go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
git clone https://github.com/google/go-genproto.git /root/go/src/google.golang.org/genproto
 cd /root/go/src/
 # go install google.golang.org/grpc

