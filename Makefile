gen:
	protoc --proto_path=proto proto/*.proto --go_out=plugins=grpc:pb 

clean:
	rm pb/*.go

# -tls flag to enable/disable SSL/TLS
server:
	go run cmd/server/main.go -port 8080

# -tls flag to enable/disable SSL/TLS
client:
	go run cmd/client/main.go -address 0.0.0.0:8080

test:
	go test ./serializer ./service

cert: 
	cd cert; ./gen.sh; cd ..

.PHONY: gen clean server client test cert