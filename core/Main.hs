module Main where

-- ox impurity directory
import System.Directory (createDirectoryIfMissing)
-- ox impurity optparse-applicative
import Options.Applicative (Parser, strArgument, metavar, showDefault,
                            value, long, help, strOption, ParserInfo, info,
                            fullDesc, progDesc, helper, header, (<**>),
                            execParser)
import Ox41f3dd81ad49a76616afeca53570713522218bee8f562ce26e6aec4b60edfa7c (oxHash)
import Oxf32288657fd6aa5432e54c6f99c43f359df4a649376c779a52f24aa64d4bbb44 (writeContent)
import Ox3b77d75c1d53661a23e70c4aea089ebd2206074c794a8863f2c039255144f45e (OxConfig(..))


oxConfigSpec :: Parser OxConfig
oxConfigSpec = OxConfig
  <$> strOption
    (  long "ox-dir"
    <> metavar "OX_DIR"
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
    <> progDesc "ox: A content addressable, source level dependency manager"
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
