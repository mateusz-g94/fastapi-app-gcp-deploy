package p

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"context"
        
	"google.golang.org/api/idtoken"

	zlog "github.com/rs/zerolog/log"
)

func Consume(w http.ResponseWriter, r *http.Request) {
	var d struct {
		Service  string `json:"service"`
		Endpoint string `json:"endpoint"`
	}

	if err := json.NewDecoder(r.Body).Decode(&d); err != nil {
		switch err {
		case io.EOF:
			zlog.Error().Msg(fmt.Sprintf("json io.EOF: %v", err))
			return
		default:
			zlog.Error().Msg(fmt.Sprintf("json.NewDecoder: %v", err))
			http.Error(w, http.StatusText(http.StatusBadRequest), http.StatusBadRequest)
			return
		}
	}
	config := make(map[string]*string)
	load_vars(config)
	config["SERVICE"] = &d.Service

	ctx := context.Background()
	client, err := idtoken.NewClient(ctx, "https://fastapi-app-0101-yq35nm2v3q-ew.a.run.app")
    if err != nil {
		zlog.Error().Msg(fmt.Sprintf("idtoken.NewClient: %w", err))
        os.Exit(1)
	}

	resp, err := client.Get(d.Endpoint)
    if err != nil {
		zlog.Error().Msg(fmt.Sprintf("client.Get: %w", err))
        os.Exit(1)
    }
	// resp, err := http.Get(d.Endpoint)
	// if err != nil {
	// 	zlog.Error().Msg(fmt.Sprintf("http call fail: %v", err))
	// 	os.Exit(1)
	// }

	mf, err := parseMF(io.Reader(resp.Body))
	if err != nil {
		zlog.Error().Msg(fmt.Sprintf("http parsing fail: %v", err))
		os.Exit(1)
	}

	sendToGCPMonitoring(mf, config)
}
