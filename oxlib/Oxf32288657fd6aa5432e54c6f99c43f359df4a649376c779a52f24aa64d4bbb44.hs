module Oxf32288657fd6aa5432e54c6f99c43f359df4a649376c779a52f24aa64d4bbb44 where 

import System.FilePath (joinPath)
-- ox impurity directory
import System.Directory (createDirectoryIfMissing)
import System.Environment (getArgs)
import System.IO (getContents)
import System.Exit (die)
import Ox41f3dd81ad49a76616afeca53570713522218bee8f562ce26e6aec4b60edfa7c (oxHash)

-- ox export writeContent
writeContent :: FilePath -> String -> String -> IO FilePath
writeContent dest contentType content = do
  let hash = oxHash content
  let name = hash ++ "." ++ contentType
  let path = joinPath [dest, name]
  writeFile path content
  return path
