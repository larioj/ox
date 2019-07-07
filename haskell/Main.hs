module Main where

import System.Environment (getArgs)
import Text.Regex.PCRE ((=~))
import Data.List (intercalate)
import Control.Monad (unless, forM_)
import System.Directory (doesFileExist, createDirectoryIfMissing)
import System.FilePath (joinPath, takeExtension, dropExtension)

line :: [String] -> String
line r = "^" ++ (untrimmed $ spaced r) ++ "$"

untrimmed :: String -> String
untrimmed s = "\\s*" ++ s ++ "\\s*"

-- ox export spaced
spaced :: [String] -> String
spaced = intercalate "\\s+"

oxModule :: String
oxModule = "Ox\\.Ox(\\S+)"

importList :: String
importList = "\\(" ++ untrimmed "(\\S+)" ++ "\\)"

getMatches :: (String, String, String, [String]) -> [String]
getMatches (_, _, _, r) = r

getHash :: FilePath -> String
getHash = tail . takeExtension . dropExtension

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
