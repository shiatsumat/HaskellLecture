# 1 Functor 解説

```haskell
import Data.Function

data X a =
    A (Int -> X a)
  | B a [Either Int a]
  | C ((a -> a -> Int) -> Int)

instance Functor X where
    fmap f (A g) = A $ \n -> fmap f (g n)
    fmap f (B x xs) = B (f x) (map (fmap f) xs)
    fmap f (C g) = C $ \h -> g (h`on`f)
```

まず型に注意することが重要です。もちろん型があっていれば必ずファンクタ則を満たすわけではありませんが。

直和・直積・関数型はみな、いい性質を持っているので、自然に書けばファンクタ則を満たします。

実際、ghc拡張では機械的にFunctorをderivingで導出することができますが、そのメカニズムを理解することは重要です。

## A

再帰的なデータ型の場合はfmapも再帰的になるということが重要です。

## B

データ型が入れ子になっている場合はfmapも入れ子になるということが重要です。(mapはリストにおけるfmapで、fmapと書いても構いません。）

## C

関数型が入れ子になっている場合の処理に慣れることが重要です。ファンクタの作成で複雑なのは関数型の扱いだけなので要注意です。

継続モナドは関数が入れ子になったファンクタの好例です。

```haskell
newtype ContT r m a = ContT {runContT :: (a -> m r) -> m r}
```

ContT r m がファンクタかつモナドになっています。

```haskell
instance Functor (ContT r m) where
    fmap f (ContT g) = ContT $ \h -> g (h . f)

instance Monad (ContT r m) where
    return x = ContT $ \f -> f x
    (ContT f) >>= g = ContT $ \h -> f (\a -> runContT (g a) h)
```
