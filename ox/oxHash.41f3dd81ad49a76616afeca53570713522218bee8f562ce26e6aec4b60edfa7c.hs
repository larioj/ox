import System.Environment (getArgs)
-- ox impurity directory
import System.Directory (doesDirectoryExist, createDirectory)
import System.IO (getContents)
import Data.List (intercalate)
import Control.Monad (forM_, unless, when)
-- ox impurity cryptohash
import Crypto.Hash.SHA256 (hash)
-- ox impurity base16-bytestring
import Data.ByteString.Base16 (encode)
-- ox impurity bytestring
import Data.ByteString.Char8 (pack, unpack)
-- ox impurity containers
import Data.Map (Map, (!))
import qualified Data.Map as Map
-- ox impurity filepath
import System.FilePath (joinPath)
import Oxc602fdae6c0cb90de319ab7b2a2c2c52b46891936f77150d478579476126a7b0 (commentToken)

-- ox export oxHash
oxHash :: String -> String
oxHash = unpack . encode . hash . pack
