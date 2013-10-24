## 1. Functor

### 解答
> import Data.Function
>
> data X a =
>     A (Int -> X a)
>   | B a [Either Int a]
>   | C ((a -> a -> Int) -> Int)
> 
> instance Functor X where
>   fmap f (A g)    = A $ fmap f . g 
>   fmap f (B x xs) = B (f x) (map (fmap f) xs) 
>   fmap f (C g)    = C $ \h -> g (h `on` f)  

### 解説

基本的に型を合わせるだけ. 型レベルで理解できてれば実用できます. 
on 関数は次のような使用例が典型的です:

> import Data.List
> xs = sortBy (compare `on` snd) [("Saburo",3), ("Taro",1), ("Jiro",2)]
> -- [("Taro",1),("Jiro",2),("Saburo",3)]

## 2. Maybe Monad

### 解答
> import qualified Data.ByteString.Char8 as BS
>
> readInts :: Int -> BS.ByteString -> Maybe [Int]
> readInts 0 _ = return []
> readInts k s = do (n,s') <- BS.readInt s
>                   ns <- readInts (k-1) (BS.tail s')
>                   return (n:ns)

### 解説

Maybe モナドはかなり基本的なので押さえておきましょう.
readInt は次のような挙動をする関数です:

> Prelude BS> BS.readInt $ BS.pack "400px"
> Just (400,"px")
> Prelude BS> BS.readInt $ BS.pack "x86"
> Nothing

## 3. List Monad

### 解答
> import Data.List
> import Control.Monad

> dice :: [Int] -> Int -> Int -> [Int]
> dice _ _ 0 = return 0
> dice as g n = sort $ nub $ do
>     x <- dice as g (n-1)
>     a <- as
>     if x==g || x+a>=g then return g else
>         if x+a<0 then return 0 else return (x+a)

> main = do g <- readLn
>           n <- readLn
>           k <- readLn
>           as <- replicateM k readLn
>           print $ dice as g n

replicateM n f は n 回 f を実行して結果をリストにまとめる関数です.

> Prelude Control.Monad> replicateM 3 getLine
> hoge
> fuga
> piyo
> ["hoge","fuga","piyo"]
