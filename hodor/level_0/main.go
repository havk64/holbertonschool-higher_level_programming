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
	vote := connect()
	for i := 0; i < 1024; i++ {
		wg.Add(1)
		time.Sleep(25 * time.Millisecond) // Makes one request each 25 milliseconds(to avoid too many open files)
		go func(i int) {                   // Starting the goroutines.
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

	return func(n int) { // This closure will "remember" its environment and optimize the request.
		req, err := http.NewRequest("POST", u.String(), strings.NewReader(data.Encode()))
		check(err)
		req.Header = customHeader()
		resp, err := client.Do(req)
		check(err)
		defer resp.Body.Close()
		defer fmt.Printf("Vote number: %d \n", n)
	}
}
