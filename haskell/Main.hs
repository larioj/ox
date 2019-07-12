module Main where

import System.Environment (getArgs)
-- ox impurity regex-pcre
import Text.Regex.PCRE ((=~))
import Control.Monad (unless, forM_)
-- ox impurity directory
import System.Directory (doesFileExist, createDirectoryIfMissing)
-- ox impurity filepath
import System.FilePath (joinPath, takeExtension, dropExtension, takeBaseName)
-- ox impurity split
import Data.List.Split (splitOn)
import Ox669552b229f9bae85eeb5e089092ee70932c4ebb8bddfd9dff32152dbc9ba678 (spaced)
import Oxea291a39171517dfee51928348fbf732ca6d1deb8732a005db535919cba37969 (untrimmed)
import Ox7f42ecf7089e877e137a4d8bab4f3e72158671a198d81f55ef8a6694318e8c78 (line)
import Ox1cb05558db7e795771f81d06051ecfecf204778ea709f34695d06de9e9284cfe (getMatches)

oxModule :: String
oxModule = "Ox\\.Ox(\\S+)"

importList :: String
importList = "\\(" ++ untrimmed "(\\S+)" ++ "\\)"

getHash :: FilePath -> String
getHash = last . splitOn "." . takeBaseName

getChildren :: String -> [FilePath]
getChildren contents = do
  l <- lines contents
  case getChild l of
    Just c -> [c]
    Nothing -> []

getChild :: String -> Maybe String
getChild l
  | l =~ simpleImport =
    let [hash] = getMatches (l =~ simpleImport) in
      Just $ "ox/" ++ hash ++ ".hs"
  | l =~ importWithList =
    let [hash, name] = getMatches (l =~ importWithList) in
      Just $ "ox/" ++ name ++ "." ++ hash ++ ".hs"
  | l =~ qualifiedImport =
    let [hash] = getMatches (l =~ qualifiedImport) in
      Just $ "ox/" ++ hash ++ ".hs"
  | l =~ qualifiedAsImport =
    let [hash] = getMatches (l =~ qualifiedAsImport) in
      Just $ "ox/" ++ hash ++ ".hs"
  | otherwise = Nothing
  where
    simpleImport      = line ["import", oxModule]
    importWithList    = line ["import", oxModule, importList]
    qualifiedImport   = line ["import", "qualified", oxModule]
    qualifiedAsImport = line ["import", "qualified", oxModule, "as", "\\S+"]

generateModule :: FilePath -> FilePath -> IO ()
generateModule outpath parent = do
  contents <- readFile parent
  forM_ (getChildren contents) $
    generateModule outpath
  let hash = getHash parent
  let outfull = joinPath [outpath, "Ox" ++ hash ++ ".hs"]
  let outContents = "module Ox" ++ hash ++ " where \n\n" ++ contents
  outfullExists <- doesFileExist outfull
  unless outfullExists $ writeFile outfull outContents

main = do
  [outpath, top] <- getArgs
  createDirectoryIfMissing True $ joinPath [outpath]
  generateModule outpath top
