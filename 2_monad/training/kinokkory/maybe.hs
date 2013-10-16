import qualified Data.ByteString.Char8 as BS

type BString = BS.ByteString

main = do k <- readLn
          s <- BS.getContents
          print $ readInts k s

readInts :: Int -> BString -> Maybe [Int]
readInts 0 _ = return []
readInts k s = do (n,s') <- BS.readInt s
                  ns <- readInts (k-1) (BS.tail s')
                  return (n:ns)

