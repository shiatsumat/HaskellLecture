# 5 Random 解説

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

getRandで-1以上1以下の実数を得ています。

replicateM n m はモナドmをn回繰り返し、得られたn個の結果をリストとして返すモナドを表します。

## main

```haskell
main = readLn >>= calcPi >>= print
```

一行読んだ結果をcalcPiに渡し、その結果を表示しています。
