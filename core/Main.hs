module Main where

import System.Environment (getArgs)
import System.Directory (doesDirectoryExist, createDirectory)
import System.IO (getContents)
import Data.List (intercalate)
import Control.Monad (forM_, unless)
import Crypto.Hash.SHA256 (hash)
import Data.ByteString.Base16 (encode)
import Data.ByteString.Char8 (pack, unpack)

baseDir = "ox"

getExports :: String -> [String]
getExports content =
  (fmap words . lines $ content) >>= \ws ->
    case ws of
      ["#", "ox", "export", name] -> [name]
      ["#ox", "export", name] -> [name]
      other -> []

getHash :: String -> String
getHash = ("BASE16.SHA256." ++) . unpack . encode . hash . pack

main = do
  oxDirExists <- doesDirectoryExist baseDir
  unless oxDirExists $ createDirectory baseDir
  [lang] <- getArgs
  content <- getContents
  let hash = getHash content
  let exports = getExports content
  forM_ exports $ \export -> do
    let basename = intercalate "." [export, lang, hash, "ox"]
    let outpath = intercalate "/" [baseDir, basename]
    putStrLn outpath
    writeFile outpath content
