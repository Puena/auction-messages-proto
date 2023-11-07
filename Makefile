src_dir = .
proto_dir = $(src_dir)/proto
go_dir = $(src_dir)/golang

installreq-go:
	@echo "start install protoc dependecies"
	go install -v google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install -v google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install -v github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc@latest
	@echo "done"


protobuild-go:
	@rm -f $(go_dir)/*.pb.go
	@rm -f $(go_dir)/*.md
	@echo "Generate go files from proto ..."
	@protoc \
	-I $(proto_dir) \
	--go_out=$(go_dir) \
	--go_opt=paths=source_relative \
    --go-grpc_out=$(go_dir) --go-grpc_opt=paths=source_relative $(proto_dir)/*.proto \
	--experimental_allow_proto3_optional
	@echo "Generate markdown docs from proto ..."
	@protoc \
	--doc_out=$(go_dir) \
	--doc_opt=markdown,README.md $(proto_dir)/*.proto \
	--experimental_allow_proto3_optional
