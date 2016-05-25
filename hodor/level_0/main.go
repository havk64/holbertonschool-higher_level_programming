package main

import (
	"fmt"
	"log"
	"net/http"
	"strings"
	"sync"
	"time"
)

//===--Function check()----------------------------------------------------===//
// check() function checks if an error occurred, calls os.Exit(1)
// to exit and prints the error to the screeen.
//===----------------------------------------------------------------------===//
func check(e error) {
	if e != nil {
		log.Fatal(e)
	}
}

//===--Function main()-----------------------------------------------------===//
// main() calls the function vote 1024 times waiting 100 milliseconds to avoid
// to have too many open files all at once.
// It uses goroutines to make asyncronous requests and WaitGroup to syncronize
// all requests and return at the end.
//===----------------------------------------------------------------------===//
func main() {
	start := time.Now()
	var wg sync.WaitGroup
	for i := 0; i < 1024; i++ {
		wg.Add(1)
		time.Sleep(100 * time.Millisecond) // Makes one request each 100 milliseconds(to avoid too many open files)
		go func(i int) {                   // Starting the goroutines.
			defer wg.Done()
			vote(i)
		}(i)
	}
	wg.Wait()
	defer fmt.Println("1024 votes confirmed in user 23 in: ", time.Since(start))
}

//===--Function vote()-----------------------------------------------------===//
// vote() gets makes the post request using functions defined in url.go file.
//===----------------------------------------------------------------------===//
func vote(n int) {
	start := time.Now()
	client := &http.Client{}
	u := parsedURL()
	data := clientPost()
	req, err := http.NewRequest("POST", u.String(), strings.NewReader(data.Encode()))
	check(err)
	req.Header = customHeader()
	resp, err := client.Do(req)
	check(err)
	defer resp.Body.Close()
	defer fmt.Printf("Vote #%d at %d\n", n, time.Since(start))
}
