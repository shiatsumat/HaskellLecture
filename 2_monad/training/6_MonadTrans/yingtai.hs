import Control.Exception
import Control.Monad
import Control.Monad.Trans
import Control.Monad.Trans.List
import System.Directory
import System.FilePath

getSubFolders :: FilePath -> ListT IO FilePath
getSubFolders path = ListT $ handle ignore $
                        do xs <- getDirectoryContents path 
                           putStrLn $ "searching " ++ path
                           filterM doesDirectoryExist $ map (path </>) $ filter (`notElem`[".",".."]) xs
  where ignore = (\_-> return []) :: SomeException -> IO [FilePath]

getNSubFolders :: FilePath -> Int -> ListT IO FilePath
getNSubFolders path 0 = return path 
getNSubFolders path n = do xs <- getNSubFolders path $ n-1
                           ds <- getSubFolders xs 
                           lift $ putStrLn $ "I found it " ++ show n ++ " levels down!" 
                           return ds

main = do path <- getLine
          n <- readLn
          l <- runListT $ getNSubFolders path n 
          print l
