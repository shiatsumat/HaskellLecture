import qualified Data.ByteString.Char8 as BS

readInts :: Int -> BS.ByteString -> Maybe [Int]
readInts 0 _ = Just []
readInts k s = do
	(n, s') <- BS.readInt s
	l <- readInts (k - 1) $ BS.tail $ BS.cons ' ' s'
	return $ n : l

main = do k <- readLn
          s <- BS.getContents
          print $ readInts k s
