# 1 Folding List 解説

## length

```haskell
length :: [a] -> Int
length = foldr (\_ n -> n+1) 0
```

次のようにも書けます。

```haskell
length :: [a] -> Int
length = foldl (\n _ -> n+1) 0
```

## map

```haskell
map :: (a -> b) -> [a] -> [b]
map f = foldr (\a bs -> f a : bs) []
```

これで O(n) です。

次のようにも書けますが、O(n^2) となり効率が悪いです。

「[x1,x2,...,xn]++[y1,y2,...,ym]」の計算量が O(n) であることに注意しましょう。

```haskell
map :: (a -> b) -> [a] -> [b]
map f = foldl (\bs a -> bs ++ [f a]) []
```

一般に、リスト上の多くの再帰関数はfoldrで実装するほうがよいです。foldrのほうがリストの構造に対して素直な方法だからです。

## reverse

```haskell
reverse :: [a] -> [a]
reverse = foldl (\as a -> a : as) []
```

これで O(n) です。foldlで実装するほうが効率のいい稀な例です。

次のようにも書けますが、O(n^2) となり効率が悪いです。

```haskell
reverse = foldr (\a as -> as ++ [a]) []
```

## filter

```haskell
filter :: (a -> Bool) -> [a] -> [a]
filter f = foldr (\a as -> if f a then a:as else as) []
```

これで O(n) です。

次のようにも書けますが、O(n^2) となり効率が悪いです。

```haskell
filter :: (a -> Bool) -> [a] -> [a]
filter f = foldr (\as a -> if f a then as++[a] else as) []
```

## subsequences

```haskell
subsequences :: [a] -> [[a]]
subsequences = foldr (\a ass -> concatMap (\as -> [as,a:as]) ass) [[]]
```

これで計算量は O(n * 2^n) になります。

一方こちらの計算量は悲劇的に遅くなります。

```haskell
subsequences :: [a] -> [[a]]
subsequences = foldl (\a ass -> ass ++ map (++[a]) ass) [[]]
```
