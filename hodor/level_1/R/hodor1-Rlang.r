#!/usr/bin/env Rscript

# ===---Description------------------------------------------------------------===
#   Solution for the Hodor Project, Level 1 by Julien Barbier.
#   Using a R Language script with httr library.
#   To run this file you need to install R language.
#   You can run it using interactive(R console) or non interactive(Rscript)
#   sessions:
#   - Interactive -
#   $ R
#   $ source("nameoffile.r")
#   - Non Interactive:
#   $ Rscript nameofthefile.r
#
#   by Alexandro de Oliveira, for Holberton School
# ===---------------------------------------------------------------------------===

library('httr')

# Accepting command line arguments:
# args	<- commandArgs(trailingOnly = TRUE)

# Function to get a cookie from a HEAD request and set the header to next request.
# (We could also to get just one cookie at the beginning and use it to all requests)
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

# Get number from user(interactive(R console) or non interactive(Rscript/batch) sessions):
cat("How many votes? => ")
total   <- as.integer(readLines("stdin", 1))
count   <- 0

while(count < total) {
    request <- setRequest()
    p <- POST(url, body = request$body, encode = "form", request$headers)
    resp = headers(p)$`set-cookie`
    if(!is.null(resp)) {
        cat(".")
        count <- count + 1
    } else {
        cat("x")
    }
}
cat('\n', "You voted ", total, " times\n")
