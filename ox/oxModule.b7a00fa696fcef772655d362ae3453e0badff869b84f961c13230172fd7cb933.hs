import System.Environment (getArgs)
-- ox impurity regex-pcre
import Text.Regex.PCRE ((=~))
import Control.Monad (unless, forM_)
-- ox impurity directory
import System.Directory (doesFileExist, createDirectoryIfMissing)
-- ox impurity filepath
import System.FilePath (joinPath, takeExtension, dropExtension, takeBaseName)
-- ox impurity split
import Data.List.Split (splitOn)
import Ox669552b229f9bae85eeb5e089092ee70932c4ebb8bddfd9dff32152dbc9ba678 (spaced)
import Oxea291a39171517dfee51928348fbf732ca6d1deb8732a005db535919cba37969 (untrimmed)
import Ox7f42ecf7089e877e137a4d8bab4f3e72158671a198d81f55ef8a6694318e8c78 (line)
import Ox1cb05558db7e795771f81d06051ecfecf204778ea709f34695d06de9e9284cfe (getMatches)

-- ox export oxModule
oxModule :: String
oxModule = "Ox\\.Ox(\\S+)"
