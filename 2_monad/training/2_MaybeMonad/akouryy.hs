import qualified Data.ByteString.Char8 as BS
readInts :: Int -> BS.ByteString -> Maybe [Int]
readInts 0 _ = Just []
readInts k s = do (x, s') <- BS.readInt s
                  xs <- readInts (k - 1) $ BS.tail s'
                  Just (x : xs)
main = do k <- readLn
          s <- BS.getContents
          print $ readInts k s
