import System.Random

calcPi' :: Int -> IO Double
calcPi' 0 = return 0
calcPi' n = do
	a <- getStdRandom $ randomR (-1, 1) :: IO Double
	b <- getStdRandom $ randomR (-1, 1) :: IO Double
	c <- calcPi' (n - 1)
	return $ if a * a + b * b <= 1 then c + 1 else c

calcPi :: Int -> IO Double
calcPi n = do
	a <- calcPi' n
	return $ a / b * 4
	where b = fromIntegral n

main = do n <- readLn
          calcPi n >>= print
