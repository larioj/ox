module Main where

import System.Environment (getArgs)
-- ox impurity regex-pcre
import Text.Regex.PCRE ((=~))
import Control.Monad (unless, forM_)
-- ox impurity directory
import System.Directory (doesFileExist, createDirectoryIfMissing, getDirectoryContents)
-- ox impurity filepath
import System.FilePath (joinPath, takeBaseName)
import Data.List (intercalate, nub)
import System.Exit (die)
import Oxb4e01c9c75b148605bd73178da03cc59f2fc4f1fbc19b6016a7e773282ef3679 (getOxExports)
import Ox8af85018c2a63634b97acd6a8e0207d55924fa971270f126c842491abf09fadc (getOxHash)
import Oxc0e610061a8fe2ad137373a567cabe9feaf96682a5440265ee37ed919495cc8b (generateNixSpec)
import Ox032615f6f9c4ddfd9160cd9efa53166e0df04a86d7ea36d632bc57cb3520d86f (listOxImpurities)
import Ox11a48ea0be8b0a1cfc9b58e2241cadd8e3106ab19e78cf0bf1e86ae787ec9b3d (getChildren)

oxDir :: FilePath
oxDir = "ox"

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
  let hash = getOxHash parent
  let outfull = joinPath [outpath, "Ox" ++ hash ++ ".hs"]
  outfullExists <- doesFileExist outfull
  unless outfullExists $ do
    contents <- readFile parent
    forM_ (getChildren oxDir contents) $ generateModule outpath
    let outContents = "module Ox" ++ hash ++ " where \n\n" ++ contents
    writeFile outfull outContents

buildImpurities :: FilePath -> String -> IO ()
buildImpurities dir name = do
  dirCont <- getDirectoryContents dir
  let files = filter (=~ "\\.hs$") dirCont
  let paths = fmap (joinPath . (dir :) . return) files
  let modules = map takeBaseName files
  impurities <- fmap (nub . concat) $
    traverse (fmap listOxImpurities . readFile) paths
  let nixSpec = generateNixSpec name modules impurities
  writeFile (joinPath [dir, name ++ ".nix"]) nixSpec
