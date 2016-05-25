package main

import (
	"net/http"
	"net/url"
)

//===--Function customURL()------------------------------------------------===//
// customURL() is used to define a custom URL.
// I chose to split each item in order to have more control on each item.
//===----------------------------------------------------------------------===//
func customURL() *url.URL {

	/* We return the reference to url.URL struct, which has the right format to *
	 * stringify the Url using the encoded reference to url.Values as RawQuery. */
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
			"Holberton_School - Using Golang",
		},
		"Accept": []string{
			"text/html,application/xhtml+xml,applxml;q=0.9,image/webp,*/*;q=0.8",
		},
		"Content-type": []string{
			"application/x-www-form-urlencoded",
		},
		"Upgrade-Insecure-Requests": []string{
			"1",
		},
	}
}
