/*
// ===---Description---------------------------------------------------------------===
//  Solution for the Hodor Project, Level 2 by Julien Barbier.
//  It needs the url.go file to compile.
//
//  by Alexandro de Oliveira, for Holberton School
// ===-----------------------------------------------------------------------------===
*/
package main

import (
	"fmt"
	"net/http"
	"strings"
	"sync"
	"time"
)

//===--Initializing the http Client for the whole session------------------===//
// check() function checks if an error occurred, calls os.Exit(1)
// to exit and prints the error to the screeen.
//===----------------------------------------------------------------------===//

var (
	httpClient *http.Client
)

// MaxIdleConnections and RequestTimeout
const (
	MaxIdleConnections int = 20
	RequestTimeout     int = 5
)

// init HTTPClient
func init() {
	httpClient = createHTTPClient()
}

// createHTTPClient for connection re-use
func createHTTPClient() *http.Client {
	client := &http.Client{
		Transport: &http.Transport{
			MaxIdleConnsPerHost: MaxIdleConnections,
		},
		Timeout: time.Duration(RequestTimeout) * time.Second,
	}

	return client
}

//===--Function check()----------------------------------------------------===//
// check() function checks if an error occurred, calls os.Exit(1)
// to exit and prints the error to the screeen.
//===----------------------------------------------------------------------===//
func check(e error) {
	if e != nil {
		fmt.Println(e)
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
	vote := connect()
	const total = (1 << 10)
	for i := 0; i < total; i++ {
		wg.Add(1)
		time.Sleep(50 * time.Millisecond) // Makes one request each 25 milliseconds(to avoid too many open files)
		go func(i int) {                  // Starting the goroutines.
			defer wg.Done()
			vote(i)
		}(i)
	}
	wg.Wait()
	defer fmt.Println("1024 votes confirmed in user 23 in: ", time.Since(start))
}

//===--Function connect()-----------------------------------------------------===//
// connect() saves some repetitive data in a "Closure" that will be returned
// and once assigned to a variable can be used to make the post request.
//===----------------------------------------------------------------------===//
func connect() func(int) {
	client := &http.Client{}
	u := parsedURL()
	data := clientPost()
	counter := 0
	return func(n int) { // This closure will "remember" its environment and optimize the request.
		req, err := http.NewRequest("POST", u.String(), strings.NewReader(data.Encode()))
		check(err)
		req.Header = customHeader()
		resp, err := client.Do(req)

		if resp.StatusCode == 200 && err == nil {
			fmt.Printf("Vote number: %d \n", (counter + 1))
			counter++
		} else {
			fmt.Println("Connection error: (vote not computed!)")
		}
		// *Optionally prints the response body.
		//_, _ = io.Copy(os.Stdout, resp.Body)
		defer resp.Body.Close()
	}
}
