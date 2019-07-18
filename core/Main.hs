module Main where

-- ox impurity directory
import System.Directory (createDirectoryIfMissing)
-- ox impurity optparse-applicative
import Options.Applicative (Parser, strArgument, metavar, showDefault,
                            value, long, help, strOption, ParserInfo, info,
                            fullDesc, progDesc, helper, header, (<**>),
                            execParser)
import System.Environment (getArgs)
import System.IO (getContents)
import System.Exit (die)
import Ox41f3dd81ad49a76616afeca53570713522218bee8f562ce26e6aec4b60edfa7c (oxHash)
import Oxf32288657fd6aa5432e54c6f99c43f359df4a649376c779a52f24aa64d4bbb44 (writeContent)

data OxConfig
  = OxConfig FilePath

oxConfigSpec :: Parser OxConfig
oxConfigSpec = OxConfig
  <$> strOption
    (  long "ox-dir"
    <> help "Directory where to store hashed content"
    <> showDefault
    <> value "ox"
    )

data OxCoreArgs
  = Write OxConfig String FilePath

oxCoreArgsSpec :: Parser OxCoreArgs
oxCoreArgsSpec = Write
  <$> oxConfigSpec
  <*> strArgument
    (  metavar "MIME"
    <> help "MIME type of input content"
    )
  <*> strArgument
    (  metavar "FILE"
    <> showDefault
    <> value "/dev/stdin"
    <> help "Input file with content to store"
    )

oxCoreInfo :: ParserInfo OxCoreArgs
oxCoreInfo =
  info (oxCoreArgsSpec <**> helper)
    (  fullDesc
    <> progDesc "A content addressable, source level dependency manager"
    <> header "ox-core - language independent ox operations"
    )

main :: IO ()
main = do
  args <- execParser oxCoreInfo
  case args of
    Write (OxConfig baseDir) mime path ->
      oxWrite baseDir mime path

oxWrite :: FilePath -> String -> FilePath -> IO ()
oxWrite baseDir lang source = do
  createDirectoryIfMissing True baseDir
  content <- readFile source
  path <- writeContent baseDir lang content
  putStrLn path
