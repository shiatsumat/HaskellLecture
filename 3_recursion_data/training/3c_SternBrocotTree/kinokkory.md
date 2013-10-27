# 3c Stern-Brocot Tree 解説

## sternbrocotTree

```haskell
sternbrocotTree :: BinaryTree Rational
sternbrocotTree = go (0,1) (1,1) (1,0)
    where go (a,b) (c,d) (e,f) =
              Bin (go (a,b) (a+c,b+d) (c,d)) (c%d) (go (c,d) (c+e,d+f) (e,f))
```

単に再帰するだけです。ただ、1%0とできないので、有理数をタプルで表現するという工夫をしています。

## simplest

```haskell
simplest :: (Double,Double) -> Rational
simplest (a,b) = simplest' sternbrocotTree (a,b)
    where simplest' (Bin l x r) (a,b)
            | a'<=x&&x<=b' = x
            | b'<x = simplest' l (a,b)
            | x<a' = simplest' r (a,b)
            where a' = toRational a
                  b' = toRational b
```

範囲に属する有理数のうち、Stern-Brocot木上でいちばん浅い位置にあるものが条件を満たすということは明らかでしょう。

同じ深さの二数が範囲に属している場合、その二数の共通の親あるいは祖先もまた範囲に属しているので、単純にStern-Brocot木を根からたどっていけば大丈夫です。

ちなみに同様の機能をもつ関数として、Data.Ratioでは

```haskell
approxRational :: RealFrac a => a -> a -> Rational
```

が定義されています。興味があればHoogleなどで実装を見てみましょう。

## rationals

```haskell
rationals :: Integer -> [Rational]
rationals k = rationals' sternbrocotTree k
    where rationals' (Bin l x r) k
            | denominator x + numerator x > k = []
            | otherwise = rationals' l k ++ [x] ++ rationals' r k
```

任意の節点について、その子は必ず分母と分子の和が大きくなっているので、深さ優先探索をすればいいです。
