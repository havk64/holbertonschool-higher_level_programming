# ===---Description------------------------------------------------------------===
#   Solution for the Hodor Project, Level 0 by Julien Barbier.
#   Using a R Language script with httr library.
#   To run this file install R language and run:
#   $ R -f filename
#
#   by Alexandro de Oliveira, for Holberton School
# ===---------------------------------------------------------------------------===

library('httr')

url     <- "http://173.246.108.142/level0.php"
header  <- add_headers("User-Agent" = "havk64 R Language Requests")
body    <- list(id = "23", holdthedoor = "submit")
count   <- 1L
total   <- as.integer(readline(prompt = "How many votes? => "))

while(count < total) {
    p <- POST(url, body = body, encode = "form", header)
    s <- content(p, "text", encoding = 'UTF8')[1]
    match = grep("I voted!", s, perl = TRUE, value = FALSE) # Regexp to check of vote is valid.
    if(!is.null(match)) {
        cat('.')
        count <- count + 1L
    } else {
        cat('x')
    }
}
cat("\n", "Total votes:", total, '\n')
