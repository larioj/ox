module Main where

import System.Environment (getArgs)
import System.Directory (doesDirectoryExist, createDirectory)
import System.IO (getContents)
import Data.List (intercalate)
import Control.Monad (forM_, unless)
import Crypto.Hash.SHA256 (hash)
import Data.ByteString.Base16 (encode)
import Data.ByteString.Char8 (pack, unpack)
import Data.Map (Map, (!))
import qualified Data.Map as Map
import System.FilePath (joinPath)

baseDir = "ox"

commentToken :: Map String String
commentToken = Map.fromList
  [ ("hs", "--")
  , ("c", "//")
  ]

getExports :: String -> String -> [String]
getExports lang content =
  (fmap words . lines $ content) >>= \ws ->
    case ws of
      [cmt, "ox", "export", name] ->
        if cmt == (commentToken ! lang) then [name] else []
      [cmtOx, "export", name] ->
        if cmtOx == (commentToken ! lang ++ "ox") then [name] else []
      other -> []

getHash :: String -> String
getHash = unpack . encode . hash . pack

main = do
  oxDirExists <- doesDirectoryExist baseDir
  unless oxDirExists $ createDirectory baseDir
  [lang] <- getArgs
  content <- getContents
  let hash = getHash content
  let exports = getExports lang content
  forM_ exports $ \export -> do
    let basename = intercalate "." [export, hash, lang]
    let outpath = joinPath [baseDir, basename]
    writeFile outpath content
  let basename = intercalate "." [hash, lang]
  let outpath = joinPath [baseDir, basename]
  writeFile outpath content
  putStrLn outpath
