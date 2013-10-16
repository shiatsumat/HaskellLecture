import qualified Data.ByteString.Lazy.Char8 as BS
import Data.Maybe
import Data.List
import Control.Monad

type BString = BS.ByteString
readInt = fst.fromJust.BS.readInt

main = do s <- BS.getContents
          let (g:n:k:as') = map readInt $ BS.lines s
          print $ dice (take k as') g n

dice :: [Int] -> Int -> Int -> [Int]
dice _ _ 0 = return 0
dice as g n = sort $ nub $ do
    x <- dice as g (n-1)
    a <- as
    if x==g || x+a>=g then return g else
        if x+a<0 then return 0 else return (x+a)

