import Control.Monad.Trans.List
import System.Directory
import Control.Applicative

getSubFolder :: FilePath -> ListT IO FilePath
getSubFolder path = ListT $ (filter <$> doesDirectoryExist <*> getDirectoryContents path)

getNSubFolder :: FilePath -> Int -> ListT IO FilePath
getNSubFolder path n = undefined

main = print 0
