import qualified Data.ByteString.Char8 as BS

readInts :: Int -> BS.ByteString -> Maybe [Int]
readInts 0 _ = return []
readInts k s = do (n,s') <- BS.readInt s
                  ns <- readInts (k-1) (BS.tail s')
                  return (n:ns)

main = do k <- readLn
          s <- BS.getContents
          print $ readInts k s

