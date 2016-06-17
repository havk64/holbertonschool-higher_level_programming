#!/usr/bin/env stack
-- stack --install-ghc --resolver lts-5.13 runghc --package http-client-tls

-- ===---Hodor Level 0---------------------------------------------------------------===
--  Solution for the Hodor Project, Level 0 by Julien Barbier.
--  Using the purely Functional Haskell Programming Language.
--
--  by Alexandro de Oliveira, for Holberton School
-- ===-----------------------------------------------------------------------------===

{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString.Lazy.Char8 as L8
import           Network.HTTP.Client
-- import           Network.HTTP.Client.TLS -- if https use "tlsManagerSettings" in newManager.
import           Network.HTTP.Types.Status  (statusCode)

main :: IO ()
main = do
    manager <- newManager defaultManagerSettings

    initialRequest <- parseUrl "http://173.246.108.142/level0.php"
    let body =
            [ ("id", "23")
            , ("holdthedoor", "submit")
            ]
        request = (urlEncodedBody body initialRequest)
            { requestHeaders =
                [ ("User-Agent", "havk64 using Haskell Language"),
                ("Referer", "http://173.246.108.142/level0.php"),
                ("Content-Type", "application/x-www-form-urlencoded")
                ]
            }

    response <- httpLbs request manager
    putStrLn $ "The status code was: "
            ++ show (statusCode $ responseStatus response)
    L8.putStrLn $ responseBody response
