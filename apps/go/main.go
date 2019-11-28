package main

import (
    "fmt"
    "os"
    "net/http"
)

func main()  {
  version := os.Getenv("VERSION")
  http.HandleFunc("/", func (w http.ResponseWriter, r *http.Request) {
    fmt.Fprint(w, "Welcome to my website! Version is " + version)
  })

  http.HandleFunc("/error", func (w http.ResponseWriter, r *http.Request) {
    fmt.Fprint(w, "Welcome to my website! Version is " + version)
  })

  http.HandleFunc("/compute-something", func (w http.ResponseWriter, r *http.Request) {
    fmt.Fprint(w, "Welcome to my website! Version is " + version)
  })
  http.ListenAndServe(":8080", nil)
}