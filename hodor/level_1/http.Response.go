/*
// ===---Description---------------------------------------------------------------===
//  This files just is the Go representation of a http.Request.
//  It is Kept here just for learn purposes.
//
//  by Alexandro de Oliveira, for Holberton School
// ===-----------------------------------------------------------------------------===
*/

package main

import (
	"bufio"
	"crypto/tls"
	"io"
	"mime/multipart"
	"net/url"
	"strings"
	"sync"
)

func response() *http.Response {
	&http.Response{
		Status:     "200 OK",
		StatusCode: 200,
		Proto:      "HTTP/1.1",
		ProtoMajor: 1,
		ProtoMinor: 1,
		Header: {
			"Date": []string{
				"Thu, 26 May 2016 04:13:14 GMT",
			},
			"Server": []string{
				"Apache/2.2.22 (Ubuntu)",
			},
			"X-Powered-By": []string{
				"PHP/5.3.10-1ubuntu3.22",
			},
			"Set-Cookie": []string{
				"HoldTheDoor=12ff1141fc8808bff3b3434757ce7553f26648b4; expires=Thu, 26-May-2016 05:13:14 GMT",
			},
			"Vary": []string{
				"Accept-Encoding",
			},
			"Content-Type": []string{
				"text/html",
			},
		},
		Body: &http.bodyEOFSignal{
			body: &http.gzipReader{
				body: &http.body{
					src: &io.LimitedReader{
						R: &bufio.Reader{
							buf: []uint8{},
							rd: http.noteEOFReader{
								r: &net.TCPConn{
									conn: net.conn{
										fd: &net.netFD{
											fdmu: net.fdMutex{
												state: 0x0000000000000000,
												rsema: 0x00000000,
												wsema: 0x00000000,
											},
											sysfd:       3,
											family:      2,
											sotype:      1,
											isConnected: true,
											net:         "tcp",
											laddr: &net.TCPAddr{
												IP: net.IP{
													0xc0, 0xa8, 0x01, 0x1f,
												},
												Port: 62358,
												Zone: "",
											},
											raddr: &net.TCPAddr{
												IP: net.IP{
													0xad, 0xf6, 0x6c, 0x8e,
												},
												Port: 80,
												Zone: "",
											},
											pd: net.pollDesc{
												runtimeCtx: 0x1441750,
											},
										},
									},
								},
								sawEOF: &false,
							},
							r:            324,
							w:            858,
							err:          nil,
							lastByte:     10,
							lastRuneSize: -1,
						},
						N: 534,
					},
					hdr:          nil,
					r:            (*bufio.Reader)(nil),
					closing:      false,
					doEarlyClose: false,
					mu: sync.Mutex{
						state: 0,
						sema:  0x00000000,
					},
					sawEOF:     false,
					closed:     false,
					earlyClose: false,
					onHitEOF:   func() {},
				},
				zr: nil,
			},
			mu: sync.Mutex{
				state: 0,
				sema:  0x00000000,
			},
			closed:       false,
			rerr:         nil,
			fn:           func(error) error {},
			earlyCloseFn: func() error {},
		},
		ContentLength:    -1,
		TransferEncoding: []string{},
		Close:            false,
		Trailer:          http.Header{},
		Request: &http.Request{
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
					"havk64 - Golang async Post Requests",
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
					i:        69,
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
		},
		TLS: (*tls.ConnectionState)(nil),
	}
}
