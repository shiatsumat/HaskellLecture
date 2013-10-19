# 1a Binary Tree

```haskell
data BinaryTree a = Bin a (Tree a) (Tree a) | Tip
```

この二分木について、次の関数を実装せよ。

```haskell
takeBinaryTree :: Int -> BinaryTree a -> BinaryTree a
showBinaryTree :: Show a => BinaryTree a -> String
```

takeBinaryTree n t は t を根から深さ n まで切り取った二分木を表す。

showBinaryTree t は t を文字列に変換する。
たとえば次のようなことである。

```
> putStrLn $ showBinaryTree $ Bin 1 (Bin 2 (Bin 3 Tip Tip) (Bin 4 Tip Tip)) (Bin 5 (Bin 6 Tip Tip) (Bin 7 Tip Tip))
1
+--2
   +--3
   +--4
+--5
   +--6
   +--7
```

## ひながた

```haskell
data BinaryTree a = Bin a (Tree a) (Tree a) | Tip
instance Show a => Show (BinaryTree a) where
  show = showBinaryTree
takeBinaryTree :: Int -> BinaryTree a -> BinaryTree a
{- edit here -}
showBinaryTree :: Show a => BinaryTree a -> String
{- edit here -}
```

# 1b Calkin-Wilf

Calkin-Wilf木という興味深い木がある。

![Calkin-Wilf Tree](/calkinwilf.png)

この木は無限二分木であり、節点は正の既約有理数である。

根は1/1であり、節点 m/n の左の子は m/(m+n) で右の子は (m+n)/n である。

Calkin-Wilf木を幅優先探索することによって得られる有理数列

```
1/1, 1/2, 2/1, 1/3, 3/2, 2/3, 3/1, 1/4, 4/3, 3/5, 5/2, 2/5, 5/3, 3/4, 4/1, ...
```

をCalkin-Wilf列といい、さまざまな驚くべき性質をもっている。すべての正の既約有理数がそれぞれ一度だけ現れる。また、n番目の有理数の分母はn+1番目の有理数の分子と等しい。

以上を踏まえ、Binary Tree で実装したデータと関数ももちいて、次の関数を実装せよ。

```haskell
calkinwilfTree :: BinaryTree Rational
calkinwilfSeq :: [Rational]
calkinwilfGet :: Int -> Rational
calkinwilfWhere :: Rational -> Int
```

calkinwilfTree は、Calkin-Wilf木そのものを表す。

calkinwilfSeq は、Calkin-Wilf列を表す。calkinwilfTreeを幅優先探索することにより実装せよ。

calkinwilfGet n は、Calkin-Wilf列のn番目の数を返す。ただし、Calkin-Wilf木をたどることによって O(log n) で求めよ。

## ひながた

```haskell
import Data.Ratio
{- copy from 'binary tree' -}
calkinwilfTree :: Tree Rational
{- edit here -}
calkinwilfSeq :: [Rational]
{- edit here -}
calkinwilfGet :: Int -> Rational
{- edit here -}
calkinwilfWhere :: Rational -> Int
{- edit here -}
```

## おまけ

次の関数をそれぞれ定数時間で動作させることができる。興味があれば実装を試みよ。

```haskell
calkinwilfParent :: Rational -> Rational
-- Calkin-Wilf木上で、親になる有理数

calkinwilfPrev :: Rational -> Rational
-- Calkin-Wilf列において、一つ前になる有理数

calkinwilfNext :: Rational -> Rational
-- Calkin-Wilf列において、一つ後になる有理数
```

# 1c Stern-Brocot

Stern-Brocot木という興味深い木がある。

![Stern-Brocot Tree](/sternbrocot.png)

この木は無限二分木であり、節点は正の既約有理数である。

この木の作り方を説明するために、各節点が3つの有理数の組からなる版を考える（便宜上、1/0も有理数として認めておく）。

根は (0/1, 1/1, 1/0) である。節点 (a/b, c/d, e/f) の左の子は (a/b, (a+c)/(b+d), c/d)、右の子は (c/d, (c+e)/(d+f), e/f)である。

この木の各節点 (x,y,z) を y に変えたものがStern-Brocot木である。

以上を踏まえ、Binary Tree で実装したデータと関数ももちいて、次の関数を実装せよ。

```haskell
sternbrocotTree :: BinaryTree Rational
```

## ひながた

```haskell
import Data.Ratio
{- copy from 'binary tree' -}
```
