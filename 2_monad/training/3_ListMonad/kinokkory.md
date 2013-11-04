# 3 List Monad 解説

## dice

```haskell
import Data.List
import Control.Monad

dice :: [Int] -> Int -> Int -> [Int]
dice _ _ 0 = return 0
dice as g n = sort $ nub $ do
    x <- dice as g (n-1)
    a <- as
    if x==g || x+a>=g then return g else
        if x+a<0 then return 0 else return (x+a)
```

リストモナドの基本的な使い方です。ただ、結果を重複なく昇順に並べるために nub で重複を取り除いたあと sort で昇順に並べています。

ちなみに、降順にしたい場合は sortBy (flip compare) とすればよいです。

## main

```haskell
main = do g <- readLn
          n <- readLn
          k <- readLn
          as <- replicateM k readLn
          print $ dice as g n
```
