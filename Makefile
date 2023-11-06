src_dir = .
proto_dir = $(src_dir)/proto
go_dir = $(src_dir)/golang

installreq-go:
	echo "start install protoc dependecies"
	go install -v google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install -v google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install -v github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@latest
	echo "done"


protobuild-go:
	protoc \
	-I $(proto_dir) \
	--doc_out=$(go_dir) \
	--doc_opt=markdown,README.md $(proto_dir)/*.proto \
	--go_out=$(go_dir) \
	--go_opt=paths=source_relative \
    --go-grpc_out=$(go_dir) --go-grpc_opt=paths=source_relative $(proto_dir)/*.proto \
	--experimental_allow_proto3_optional