package main

import (
	"net/http"
	"net/url"
)

func myValue() string {
	return "eee265b61a8b52529dc5e3865a5b5ddffcb69bf0"
}

//===--Function parsedURL()------------------------------------------------===//
// parsedURL() is used to define the URL.
// I chose to split each item(parse) in order to have more control on them.
// To obtain this result you can use url.Parse(URL) in a raw URL, which will
// return an object of type url.URL that is defined by a struct.
//===----------------------------------------------------------------------===//
func parsedURL() *url.URL {

	return &url.URL{
		Scheme:   "http",
		Opaque:   "",
		User:     (*url.Userinfo)(nil),
		Host:     "173.246.108.142",
		Path:     "/level1.php",
		RawPath:  "",
		RawQuery: "",
		Fragment: "",
	}
}

//===--Function clientPost()-----------------------------------------------===//
// clientPost() is used to fill the form for que POST request.
//===----------------------------------------------------------------------===//
func clientPost() *url.Values {
	post := &url.Values{ // Custom Query created based in the the type url.Values,
		"id": []string{ // that is basically: map[string][]string
			"23",
		},
		"holdthedoor": []string{
			"Submit",
		},
		"key": []string{
			myValue(),
		},
	}
	return post
}

//===--Function customHeader()---------------------------------------------===//
// customHeader() is used to define the request Header without function helpers.
// It uses the format of the http.Header Struct used by net/http package.
//===----------------------------------------------------------------------===//
func customHeader() http.Header {
	return http.Header{
		"User-Agent": []string{
			"havk64 - Golang async Post Requests",
		},
		"Content-type": []string{
			"application/x-www-form-urlencoded",
		},
		"Cookie": []string{
			"HoldTheDoor=" + myValue(),
		},
	}
}
