package main

import (
	"fmt"
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
	vote := request()
	for i := 0; i < 1024; i++ {
		wg.Add(1)
		time.Sleep(50 * time.Millisecond) // Makes one request each 50 milliseconds(to avoid too many open files)
		go func(i int) {                  // Starting the goroutines.
			defer wg.Done() // Defer when it's done.
			vote(i)         // Calling the function to make the request.
		}(i)
	}
	wg.Wait()
	defer fmt.Println("1024 votes confirmed in user 23 in: ", time.Since(start))
}

//===--Function vote()-----------------------------------------------------===//
// vote() gets makes the post request using functions defined in url.go file.
//===----------------------------------------------------------------------===//
func request() func(int) {
	u := parsedURL()
	client := &http.Client{}
	data := clientPost()

	return func(n int) {
		req, err := http.NewRequest("POST", u.String(), strings.NewReader(data.Encode()))
		check(err)
		req.Header = customHeader()
		resp, error := client.Do(req)
		check(error)
		defer resp.Body.Close()
		defer fmt.Printf("Vote number: %d\n", n)
	}
}
