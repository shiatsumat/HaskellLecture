## 1. Functor

### 解答
> import Data.Function
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
