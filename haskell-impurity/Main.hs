module Main where

import System.Environment (getArgs)
import System.Directory (getDirectoryContents)
import Data.List (intercalate, nub)
import System.FilePath (takeBaseName, joinPath)
import Text.Regex.PCRE ((=~))

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
      intercalate (repeatN indent " " ++ "\n") . map quote

main :: IO ()
main = do
  [dir, name] <- getArgs
  dirCont <- getDirectoryContents dir
  let files = filter (=~ "\\.hs$") dirCont
  let paths = fmap (joinPath . (dir :) . return) files
  let modules = map takeBaseName files
  impurities <- fmap (nub . concat) $
    traverse (fmap getImpurities . readFile) paths
  let nixSpec = generateNixSpec name modules impurities
  writeFile (joinPath [dir, name ++ ".nix"]) nixSpec
