#!/usr/bin/env Rscript

# ===---Description------------------------------------------------------------===
#   Solution for the Hodor Project, Level 1 by Julien Barbier.
#   Using a R Language script with httr library.
#   To run this file you need to install R language.
#   You can run it using interactive(R console) or non interactive(Rscript)
#   sessions:
#   - Interactive -
#   $ R
#   > source("nameoffile.r")
#   - Non Interactive:
#   $ Rscript nameofthefile.r
#
#   by Alexandro de Oliveira, for Holberton School
# ===---------------------------------------------------------------------------===

library('httr')

# Accepting command line arguments:
# args	<- commandArgs(trailingOnly = TRUE)

# Function to get a cookie from a HEAD request and set the header to next request.
setRequest  <- function() {
    head    <- HEAD(url)
    cookie  <- cookies(head)$value
    headers <- add_headers("User-Agent" = "havk64 R Language Requests")
    body    <- list(id = "23", holdthedoor = "submit", key = cookie)
    request <- list( body = body, headers = headers)
    return(request)
}

# Defining variables:
url     <- "http://173.246.108.142/level1.php"

# Getting a fresh cookie to set the request:
request <- setRequest()

# Get number from user:
cat("How many votes? => ")
total   <- as.integer(readLines("stdin", 1))
count   <- 0L

while(count < total) {
    p <- POST(url, body = request$body, encode = "form", request$headers, set_cookies("Cookie" = paste(cookies(head)$name, sep="=", cookies(head)$value)))
    resp = headers(p)$`set-cookie`
    if(!is.null(resp)) {
        cat(".")
        count <- count + 1L
    } else {
        cat("x")
    }
}
cat('\n', "You voted ", total, " times\n")
