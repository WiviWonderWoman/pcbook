gen:
	protoc --proto_path=proto proto/*.proto --go_out=pb 

clean:
	rm pb/*.go

run:
	go run main.go

test:
	go test ./serializer/file_test.go
