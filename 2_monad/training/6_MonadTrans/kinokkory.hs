import Control.Monad.Trans.List
import System.Directory
import Control.Monad
import Control.Applicative

getSubfolders :: FilePath -> ListT IO FilePath
getSubfolders path = ListT $ getDirectoryContents path >>= return . map ((path++"/")++) . filter (\p -> p/=".."&&p/=".") >>= filterM doesDirectoryExist

getNSubfolders :: FilePath -> Int -> ListT IO FilePath
getNSubfolders path 0 = return path
getNSubfolders path n = getNSubfolders path (n-1) >>= getSubfolders

main = do path <- getLine
          n <- readLn :: IO Int
          l <- runListT $ getNSubfolders path n
          print l
