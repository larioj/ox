module Main where

-- ox impurity filepath
import System.FilePath (joinPath)
-- ox impurity directory
import System.Directory (doesDirectoryExist, createDirectory)
import System.Environment (getArgs)
import System.IO (getContents)
import Data.List (intercalate)
import Control.Monad (unless, when)
import System.Exit (die)
import Ox41f3dd81ad49a76616afeca53570713522218bee8f562ce26e6aec4b60edfa7c (oxHash)

baseDir :: String
baseDir = "ox"

usage :: IO String
usage = do
  args <- getArgs
  case args of
    [lang] -> return lang
    _ -> die "Usage: ox-core <lang>"

main = do
  oxDirExists <- doesDirectoryExist baseDir
  unless oxDirExists $ createDirectory baseDir
  lang <- usage
  content <- getContents
  let hash = oxHash content
  let basename = intercalate "." [hash, lang]
  let outpath = joinPath [baseDir, basename]
  writeFile outpath content
  putStrLn outpath
