module Main where

import System.Environment (getArgs)
-- ox impurity regex-pcre
import Text.Regex.PCRE ((=~))
import Control.Monad (unless, forM_)
-- ox impurity directory
import System.Directory (doesFileExist, createDirectoryIfMissing, getDirectoryContents)
-- ox impurity filepath
import System.FilePath (joinPath, takeExtension, dropExtension, takeBaseName)
-- ox impurity split
import Data.List.Split (splitOn)
import Data.List (intercalate, nub)
import System.Exit (die)
import Ox669552b229f9bae85eeb5e089092ee70932c4ebb8bddfd9dff32152dbc9ba678 (spaced)
import Oxea291a39171517dfee51928348fbf732ca6d1deb8732a005db535919cba37969 (untrimmed)
import Ox7f42ecf7089e877e137a4d8bab4f3e72158671a198d81f55ef8a6694318e8c78 (line)
import Ox1cb05558db7e795771f81d06051ecfecf204778ea709f34695d06de9e9284cfe (getMatches)
import Oxb7a00fa696fcef772655d362ae3453e0badff869b84f961c13230172fd7cb933 (oxModule)
import Oxb4e01c9c75b148605bd73178da03cc59f2fc4f1fbc19b6016a7e773282ef3679 (getOxExports)

data Args
  = ListExports FilePath
  | BuildImpurities FilePath String
  | BuildNode FilePath FilePath

usage :: IO Args
usage = do
  args <- getArgs
  case args of
    ["list", "exports", path] -> return $ ListExports path
    ["list", "export", path] -> return $ ListExports path
    ["build", "impurities", dir, name] -> return $ BuildImpurities dir name
    ["build", "impurity", dir, name] -> return $ BuildImpurities dir name
    ["build", "node", dir, path] -> return $ BuildNode dir path
    _ -> die "usage: ox-haskell [opts]"

main :: IO ()
main = do
  args <- usage
  case args of
    ListExports node -> listExports node
    BuildNode dir node -> do
      createDirectoryIfMissing True dir
      buildNode dir node
    BuildImpurities dir name-> buildImpurities dir name

listExports :: FilePath -> IO ()
listExports path = do
  contents <- readFile path
  let exports = getOxExports "hs" contents
  putStrLn $ intercalate " " exports

buildNode :: FilePath -> FilePath -> IO ()
buildNode dir node = generateModule dir node

generateModule :: FilePath -> FilePath -> IO ()
generateModule outpath parent = do
  let hash = getHash parent
  let outfull = joinPath [outpath, "Ox" ++ hash ++ ".hs"]
  outfullExists <- doesFileExist outfull
  unless outfullExists $ do
    contents <- readFile parent
    forM_ (getChildren contents) $ generateModule outpath
    let outContents = "module Ox" ++ hash ++ " where \n\n" ++ contents
    writeFile outfull outContents

buildImpurities :: FilePath -> String -> IO ()
buildImpurities dir name = do
  dirCont <- getDirectoryContents dir
  let files = filter (=~ "\\.hs$") dirCont
  let paths = fmap (joinPath . (dir :) . return) files
  let modules = map takeBaseName files
  impurities <- fmap (nub . concat) $
    traverse (fmap getImpurities . readFile) paths
  let nixSpec = generateNixSpec name modules impurities
  writeFile (joinPath [dir, name ++ ".nix"]) nixSpec

getImpurities :: String -> [String]
getImpurities contents =
  lines contents >>= \l ->
    case words l of
      ["--", "ox", "impurity", i] -> [i]
      _ -> []

generateNixSpec :: String -> [String] -> [String] -> String
generateNixSpec name modules impurities =
  "{\n" ++
  "  src = ./.;\n" ++
  "  name = \"" ++ name ++ "\";\n" ++
  "  version = \"0.0.1\";\n" ++
  "  library = {\n" ++
  "    exposedModules = [\n" ++
  "      " ++ format 6 modules ++ "\n" ++
  "    ];\n" ++
  "  };\n" ++
  "  dependencies = [\n" ++
  "    " ++ format 4 ("base" : impurities) ++ "\n" ++
  "  ];\n" ++
  "  cabalVersion = \">=1.10\";\n" ++
  "}\n"
  where
    quote s = "\"" ++ s ++ "\""
    repeatN n = concat . take n . repeat
    format indent =
      intercalate ("\n" ++ repeatN indent " ") . map quote

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
