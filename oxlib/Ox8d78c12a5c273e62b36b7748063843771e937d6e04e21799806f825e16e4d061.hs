module Ox8d78c12a5c273e62b36b7748063843771e937d6e04e21799806f825e16e4d061 where 

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

-- ox export OxConfig(..)
data OxConfig
  = OxConfig FilePath
