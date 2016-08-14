# ===---Description------------------------------------------------------------===
#   Solution for the Hodor Project, Level 3 by Julien Barbier.
#   Using a R Language script with httr library.
#   To run this file install R language and run:
#   $ R -f filename
#
#   by Alexandro de Oliveira, for Holberton School
# ===---------------------------------------------------------------------------===

library('httr')

code    <- "http://173.246.108.142/captcha.php"
url     <- "http://173.246.108.142/level3.php"

header  <- add_headers("User-Agent" = "Windows NT 5.1 - havk64 R Language Requests", "Referer" = url)
votes   <- 0L
cat("How many votes? => ")
total   <- as.integer(readLines("stdin", 1))

while(votes < total) {
    # Some great code goes here!  >:-)
    fetch   <- GET(code, header)
    bin     <- content(fetch, "raw")
    writeBin(bin, "tmp.txt")
    img     <- try(system("tesseract tmp.txt - ", intern = TRUE, ignore.stderr = TRUE))
    captcha <- img[1]
    cat(captcha, "\n", nchar(captcha))

    head    <- HEAD(url)            # Head request
    cookie  <- cookies(head)$value
    cat(cookie, "\n")
    body    <- list(id = "23", holdthedoor = "submit", key = cookie[2], captcha = captcha)

    p       <- POST(url, body = body, encode = "form", header)
    s       <- content(p, "text", encoding = 'UTF8')[1]

    match   <- headers(p)$`set-cookie`
    if(!is.null(match)) {
        cat("Vote number: ", (votes + 1) , "\n")
        votes <- votes + 1
    } else {
        cat( "Failed...", "\n")
    }
}

cat("Total of valid votes: ", votes + 1, "\n")
