import Control.Monad.Trans.List
import System.Directory
import Control.Monad
import Control.Applicative
import Control.Monad.Trans
getSubfolders :: FilePath -> ListT IO FilePath
{- edit here -}
getSubfolders path = do lift $ print $ "searching " ++ path
                        files <- lift $ getDirectoryContents path
                        let res = filterM doesDirectoryExist [path ++ "/" ++ name | name <- files, name /= "." && name /= ".."]
                        ListT res
{- pyaaaaaaa -}
getNSubfolders :: FilePath -> Int -> ListT IO FilePath
getNSubfolders path 0 = return path
getNSubfolders path n = do folders <- getNSubfolders path (n-1)
                           subs <- getSubfolders folders
                           return $ subs
                           


                              
                              
{- edit here -}
{- pyaaaaaaa -}
main = do path <- getLine
          n <- readLn
          l <- runListT $ getNSubfolders path n
          print l
