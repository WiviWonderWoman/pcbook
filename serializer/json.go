package serializer

import (
	"fmt"

	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"
)

// ProtobufToJSON converts protocol buffer message to JSON string
func ProtobufToJSON(message proto.Message) (string, error) {
	opt := protojson.MarshalOptions{
		UseEnumNumbers:    false,
		EmitDefaultValues: true,
		Indent:            "	",
		UseProtoNames:     true,
	}
	data, err := opt.Marshal(message)
	if err != nil {
		return "", fmt.Errorf("cannot marshal proto message to byte: %w", err)
	}
	return string(data), nil
}
