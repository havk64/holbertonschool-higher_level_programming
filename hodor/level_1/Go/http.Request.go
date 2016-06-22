/*
// ===---Description---------------------------------------------------------------===
//  This files just is the Go representation of a http.Request.
//  It is kept here just for learn purposes.
//
//  by Alexandro de Oliveira, for Holberton School
// ===-----------------------------------------------------------------------------===
*/

package main

import (
	"crypto/tls"
	"io/ioutil"
	"mime/multipart"
	"net/http"
	"net/url"
	"strings"
)

func request() *http.Request {
	return &http.Request{
		Method: "POST",
		URL: &url.URL{
			Scheme:   "http",
			Opaque:   "",
			User:     (*url.Userinfo)(nil),
			Host:     "173.246.108.142",
			Path:     "/level1.php",
			RawPath:  "",
			RawQuery: "",
			Fragment: "",
		},
		Proto:      "HTTP/1.1",
		ProtoMajor: 1,
		ProtoMinor: 1,
		Header: {
			"User-Agent": []string{
				"havk64 - Golang async post request - for Holberton School",
			},
			"Content-Type": []string{
				"application/x-www-form-urlencoded",
			},
			"Cookie": []string{
				"HoldTheDoor=eee265b61a8b52529dc5e3865a5b5ddffcb69bf0",
			},
		},
		Body: ioutil.nopCloser{
			Reader: &strings.Reader{
				s:        "holdthedoor=Submit&id=99&key=eee265b61a8b52529dc5e3865a5b5ddffcb69bf0",
				i:        0,
				prevRune: -1,
			},
		},
		ContentLength:    69,
		TransferEncoding: []string{},
		Close:            false,
		Host:             "173.246.108.142",
		Form:             url.Values{},
		PostForm:         url.Values{},
		MultipartForm:    (*multipart.Form)(nil),
		Trailer:          http.Header{},
		RemoteAddr:       "",
		RequestURI:       "",
		TLS:              (*tls.ConnectionState)(nil),
		Cancel:           (<-chan struct{})(0x0),
	}
}
