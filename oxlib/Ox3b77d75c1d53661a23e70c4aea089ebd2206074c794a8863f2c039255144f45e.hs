module Ox3b77d75c1d53661a23e70c4aea089ebd2206074c794a8863f2c039255144f45e where 

import System.Directory (createDirectoryIfMissing)
-- ox impurity optparse-applicative
import Options.Applicative (Parser, strArgument, metavar, showDefault,
                            value, long, help, strOption, ParserInfo, info,
                            fullDesc, progDesc, helper, header, (<**>),
                            execParser)
import Ox41f3dd81ad49a76616afeca53570713522218bee8f562ce26e6aec4b60edfa7c (oxHash)
import Oxf32288657fd6aa5432e54c6f99c43f359df4a649376c779a52f24aa64d4bbb44 (writeContent)

-- ox export OxConfig(..)
data OxConfig
  = OxConfig FilePath
