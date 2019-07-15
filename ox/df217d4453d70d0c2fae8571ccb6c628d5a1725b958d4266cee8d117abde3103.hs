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
import Ox643243be8c2037b1d710ac8ea76680035d683db693496ad787165191088be82f (importList)
import Ox8af85018c2a63634b97acd6a8e0207d55924fa971270f126c842491abf09fadc (getOxHash)

-- ox export getGroupsOfFirstMatch
getGroupsOfFirstMatch :: [String] -> String -> [String]
getGroupsOfFirstMatch patterns content =
  head . fmap (getMatches . (content =~)) $ patterns
