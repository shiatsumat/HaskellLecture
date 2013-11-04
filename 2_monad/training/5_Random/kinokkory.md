# Random ‰ðà

## calcPi

```haskell
import System.Random
import Control.Monad

calcPi :: Int -> IO Double
calcPi n = do ps <- replicateM n $ do {x<-getRand; y<-getRand; return(x,y)}
              let m = length $ filter (\(x,y) -> x*x+y*y<=1) ps
              return $ (fromIntegral m * 4.0 / fromIntegral n)

getRand :: IO Double
getRand = getStdRandom $ randomR (-1,1)
```

## main

```haskell
main = readLn >>= calcPi >>= print
```
