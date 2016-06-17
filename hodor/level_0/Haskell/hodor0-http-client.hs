#!/usr/bin/env stack
-- stack --resolver lts-5.13 runghc --package http-client-tls
import Network.HTTP.Client
import Network.HTTP.Client.TLS   (tlsManagerSettings)
import Network.HTTP.Types.Status (statusCode)

main :: IO ()
main = do
    manager <- newManager tlsManagerSettings

    request <- parseUrl "http://173.246.108.142/level0.php"
    response <- httpLbs request manager

    putStrLn $ "The status code was: " ++
               show (statusCode $ responseStatus response)
    print $ responseBody response
