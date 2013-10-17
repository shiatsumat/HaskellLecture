import System.Random
import Control.Monad

toDouble = fromInteger . toInteger

calcPi :: Int -> IO Double
calcPi n = do ps <- replicateM n $ do {x<-getRand; y<-getRand; return(x,y)}
              let m = length $ filter (\(x,y) -> x*x+y*y<=1) ps
              return $ (toDouble m * 4.0 / toDouble n)

getRand :: IO Double
getRand = getStdRandom $ randomR (-1,1)

main = readLn >>= calcPi >>= print
