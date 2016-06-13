# ===---Description------------------------------------------------------------===
#   Solution for the Hodor Project, Level 0 by Julien Barbier.
#   Using a R Language script with httr library.
#
#   by Alexandro de Oliveira, for Holberton School
# ===---------------------------------------------------------------------------===

library('httr')

body <- list(id = 23, holdthedoor = submit)
for(i in 1:1024) {
    p <- POST("http://173.246.108.142/level0.php", body = body, encode = "form", add_headers("User-Agent" = "havk64 R Language Requests"))
    cat("Vote number: ", i, "\n")
}
