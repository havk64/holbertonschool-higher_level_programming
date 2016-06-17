-- ===---Hodor Level 0----------------------------------------------------------===
--  Solution in Shell Script for Hodor Project Level 0, by Julien Barbier
--  Using Http Enumerator deprecated package.
--
--  by Alexandro de Oliveira, for Holberton School.
-- ===--------------------------------------------------------------------------===

{-# LANGUAGE OverloadedStrings #-}

import Network.HTTP.Enumerator
import Network.HTTP.Types
import qualified Data.ByteString.Lazy as L

main = do
  req0 <- parseUrl "http://173.246.108.142/level0.php"

  let req = req0 { method = methodPost
                 , requestHeaders = [("Content-Type", "application/x-www-form-urlencoded")]
                 , requestBody = RequestBodyLBS "{\"id\": \"23\", \"holdthedoor\": \"submit\"}"
                 }

  res <- withManager $ httpLbs req

  L.putStrLn $ responseBody res
