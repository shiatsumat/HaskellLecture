# 1a Binary Tree

```haskell
data BinaryTree a = Bin (BinaryTree a) a (BinaryTree a) | Tip
```

この二分木について、次の関数を実装せよ。

```haskell
takeBinaryTree :: Int -> BinaryTree a -> BinaryTree a
showBinaryTree :: Show a => BinaryTree a -> String
```

takeBinaryTree n t は t を根から深さ n まで切り取った二分木を表す。根の深さを1とする。

showBinaryTree t は t を文字列に変換する。
たとえば次のようなことである。

```
> putStrLn $ showBinaryTree $ Bin (Bin (Bin Tip 3 Tip) 2 (Bin (Bin (Bin Tip 6 Tip) 5 (Bin Tip 7 Tip)) 4 (Bin (Bin (Bin Tip 10 Tip) 9 (Bin Tip 11 Tip)) 8 Tip))) 1 (Bin (Bin Tip 13 (Bin Tip 14 Tip)) 12 (Bin Tip 15 Tip))
   +--15
+--12
|  |  +--14
|  +--13
1
|     +--8
|     |  |  +--11
|     |  +--9
|     |     +--10
|  +--4
|  |  |  +--7
|  |  +--5
|  |     +--6
+--2
   +--3
```

## ひながた

```haskell
data BinaryTree a = Bin (BinaryTree a) a (BinaryTree a) | Tip

instance Show a => Show (BinaryTree a) where
  show = showBinaryTree

takeBinaryTree :: Int -> BinaryTree a -> BinaryTree a
{- edit here -}

showBinaryTree :: Show a => BinaryTree a -> String
{- edit here -}

main = print $ takeBinaryTree 4 $ Bin (Bin (Bin Tip 3 Tip) 2 (Bin (Bin (Bin Tip 6 Tip) 5 (Bin Tip 7 Tip)) 4 (Bin (Bin (Bin Tip 10 Tip) 9 (Bin Tip 11 Tip)) 8 Tip))) 1 (Bin (Bin Tip 13 (Bin Tip 14 Tip)) 12 (Bin Tip 15 Tip))
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
```

calkinwilfTree は、Calkin-Wilf木そのものである。

calkinwilfSeq は、Calkin-Wilf列である。calkinwilfTreeを幅優先探索することにより実装せよ。

calkinwilfGet n は、Calkin-Wilf列のn番目の数を返す。1番目が1/1である。Calkin-Wilf木をたどることによって O(log n) で求めよ。

実装にあたっては、Data.Ratioをインポートし、必要ならば次の関数をもちいよ。

```haskell
(%) :: Integral a => a -> a -> Ratio a
-- 有理数をつくる
numerator :: Integral a => Ratio a -> a
-- 分子を求める
denominator :: Integral a => Ratio a -> a
-- 分母を求める
```

なお、RationalはRatio Integerの型シノニムである。

## ひながた

```haskell
import Data.Ratio

{- copy from 'binary tree' -}

calkinwilfTree :: BinaryTree Rational
{- edit here -}

calkinwilfSeq :: [Rational]
{- edit here -}

calkinwilfGet :: Int -> Rational
{- edit here -}

main = print $ takeBinaryTree 5 calkinwilfTree
-- main = print $ take 100 $ calkinwilfSeq
-- main = print $ calkinwilfGet 100
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

Stern-Brocot木というこれまた興味深い木がある。

![Stern-Brocot Tree](/sternbrocot.png)

この木は無限二分木であり、節点は正の既約有理数である。

この木の作り方を説明するために、まず各節点が3つの正の既約有理数の組からなる木を作る（ここでのみ、1/0も有理数として認める）。根は (0/1, 1/1, 1/0) とし、節点 (a/b, c/d, e/f) の左の子は (a/b, (a+c)/(b+d), c/d)、右の子は (c/d, (c+e)/(d+f), e/f) とする。こうして出来上がった無限二分木の各節点 (x,y,z) を y に変えたものが、Stern-Brocot木である。

この木はさまざまな驚くべき性質をもっている。すべての正の既約有理数がそれぞれ一度だけ現れる。また、図の最下部のように、左から順に節点を並べると、きれいに昇順に並ぶ。

以上を踏まえ、Binary Tree で実装したデータと関数ももちいて、次の関数を実装せよ。

```haskell
sternbrocotTree :: BinaryTree Rational
simplest :: (Double,Double) -> Rational
rationals :: Integer -> [Rational]
```

sternbrocotTree はStern-Brocot木そのものである。

silplest (x,y) は x以上y以下の有理数のうち、分母と分子の和が最小のものを求める。ちなみに、このとき分母も分子もそれぞれ最小となる。sternbrocotTreeをうまくつかって実装せよ。

rationals k は分母と分子の和がk以下の正の既約有理数を昇順に列挙する。sternbrocotTreeをうまくつかって実装せよ。

実装にあたっては、Data.Ratioをインポートし、必要ならば次の関数をもちいよ。

```haskell
(%) :: Integral a => a -> a -> Ratio a
-- 有理数をつくる
numerator :: Integral a => Ratio a -> a
-- 分子を求める
denominator :: Integral a => Ratio a -> a
-- 分母を求める
```

なお、RationalはRatio Integerの型シノニムである。また、1 % 0という式はエラーになるので、工夫して実装せよ。

## ひながた

```haskell
import Data.Ratio

{- copy from 'binary tree' -}

sternbrocotTree :: BinaryTree Rational
{- edit here -}

simplest :: (Double,Double) -> Rational
{- edit here -}

rationals :: Integer -> [Rational]
{- edit here -}

main = print $ takeBinaryTree 5 sternbrocotTree
-- main = print $ simplest (3.14,3.15)
-- main = print $ rationals 20
```
