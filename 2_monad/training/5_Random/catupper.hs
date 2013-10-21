import System.Random
import Control.Monad

calcPi :: Int -> IO Double
{- edit here -}
calcPi n = do inside <- inside'
              return $ (fromIntegral (length inside)) *4.0  / (fromIntegral n)
              where points = sequence $ [sequence [getStdRandom(randomR(-1.0, 1.0)), getStdRandom(randomR(-1.0, 1.0))] | _ <- [1..n]]
                    inside' = incircle points

incircle :: IO [[Double]] -> IO [[Double]]
incircle points' = do points <- points'
                      return [x | x@[a, b]<-points , a*a + b*b <= 1]

{- pyaaaaaaa -}

main = do n <- readLn
          calcPi n >>= print
