module Main where

-- ox impurity directory
import System.Directory (createDirectoryIfMissing)
import System.Environment (getArgs)
import System.IO (getContents)
import System.Exit (die)
import Ox41f3dd81ad49a76616afeca53570713522218bee8f562ce26e6aec4b60edfa7c (oxHash)
import Oxf32288657fd6aa5432e54c6f99c43f359df4a649376c779a52f24aa64d4bbb44 (writeContent)

baseDir :: String
baseDir = "ox"

usage :: IO String
usage = do
  args <- getArgs
  case args of
    [lang] -> return lang
    _ -> die "Usage: ox-core <lang>"

main = do
  createDirectoryIfMissing True baseDir
  lang <- usage
  content <- getContents
  path <- writeContent baseDir lang content
  putStrLn path
