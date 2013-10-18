import System.Random
calcPi :: Int -> IO Double
calcPi n = calcPi' n >>= (return . (* 4) . (/ (realToFrac n)) . realToFrac)
         where
           calcPi' :: Int -> IO Int
           calcPi' 0 = return 0
           calcPi' i = do x <- getStdRandom random :: IO Double
                          y <- getStdRandom random :: IO Double
                          (calcPi' $ i - 1) >>= (return . ((if x * x + y * y <= 1.0 then 1 else 0) +))
main = do n <- readLn
          print =<< calcPi n
