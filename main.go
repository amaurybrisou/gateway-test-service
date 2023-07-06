package main

import (
	"fmt"
	"log"
	"net/http"
	"sync"

	"github.com/amaurybrisou/ablib/core"
)

func main() {
	addr := core.LookupEnv("LISTEN_ADDR", "0.0.0.0")
	port := core.LookupEnvInt("LISTEN_PORT", 8090)

	router := http.NewServeMux()
	router.HandleFunc("/", helloHandler)
	router.HandleFunc("/healthcheck", func(w http.ResponseWriter, r *http.Request) { w.WriteHeader(http.StatusOK) })

	wg := sync.WaitGroup{}

	wg.Add(1)
	go func() {
		fmt.Printf("Server listening on %s:%d\n", addr, port)
		log.Fatal(http.ListenAndServe(fmt.Sprintf("%s:%d", addr, port), router)) //nolint
		wg.Done()
	}()

	wg.Wait()
}

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World!\n")
}
