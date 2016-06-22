/*
// ===---Description---------------------------------------------------------------===
//  Solution for the Hodor Project, Level 0 by Julien Barbier.
//  It needs the main.go file to compile.
//
//  by Alexandro de Oliveira, for Holberton School
// ===-----------------------------------------------------------------------------===
*/

package main

import (
	"net/http"
	"net/url"
)

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
		Path:     "/level0.php",
		RawPath:  "",
		RawQuery: "",
		Fragment: "",
	}
}

//===--Function clientPost()-----------------------------------------------===//
// clientPost() is used to fill the form for que POST request.
//===----------------------------------------------------------------------===//
func clientPost() *url.Values {
	q := &url.Values{ // Custom Query created based in the the type url.Values,
		"id": []string{ // that is basically: map[string][]string
			"23",
		},
		"holdthedoor": []string{
			"Submit",
		},
	}
	return q
}

//===--Function customHeader()---------------------------------------------===//
// customHeader() is used to define the request Header without function helpers.
// It uses the format of the http.Header Struct used by net/http package.
//===----------------------------------------------------------------------===//
func customHeader() http.Header {
	return http.Header{
		"User-Agent": []string{
			"havk64 - Using Golang async requests",
		},
		"Content-type": []string{
			"application/x-www-form-urlencoded",
		},
	}
}
