# 3b Calkin-Wilf Tree 解説

## calkinwilfTree

```haskell
calkinwilfTree :: BinaryTree Rational
calkinwilfTree = go (1%1)
    where go x = Bin (go (m%(m+n))) x (go ((m+n)%n))
            where m = numerator x
                  n = denominator x
```

単に再帰するだけです。

## calkinwilfSeq

```haskell
calkinwilfSeq :: [Rational]
calkinwilfSeq = map top queue
    where queue = calkinwilfTree : walk queue
          walk (Bin l _ r : q) = l : r : walk q
          top (Bin _ x _) = x
```

queueもwalkも再帰していてパッと見だと訳分からない！となるかもしれないので、補足説明をしておきます。

```haskell
t1 = Bin t2 x1 t3
t2 = Bin t4 x2 t5
t3 = Bin t6 x3 t7
...
```

というデータ構造になっているとします。

```haskell
q1 = t1 : walk q1
walk (Bin l _ r : q) = l : r : walk q
```

と書かれているとして、q1を順に展開していきましょう。

```haskell
q1 = t1 : walk q1
   = t1 : t2 : t3 : walk q2
          |______q2_______|
   = t1 : t2 : t3 : t4 : t5 : walk q3
               |_________q3_________|
   = t1 : t2 : t3 : t4 : t5 : t6 : t7 : walk q4
                    |___________q4____________|
   = ...
```

以下同様に続いていきます。まさにキューのようになっているのが分かると思います。

## calkinwilfSeqAnother

```haskell
calkinwilfSeqAnother :: [Rational]
calkinwilfSeqAnother = concat $ levels calkinwilfTree
    where levels (Bin l x r) = [x] : zipWith (++) (levels l) (levels r)
```

calkinwilfSeqの別解です。

levelsでは木を深さごとに分けたリストのリストを作っています。levelsはきれいに再帰的に書けることがわかります。

あとは、このリストをすべてつなぎあわせれば幅優先走査の完了です！

ちなみに、リストの結合で少し余分に時間を食うので、差分リストを使えばもう少し早くなります。

## calkinwilfGet

```haskell
calkinwilfGet :: Int -> Rational
calkinwilfGet n =  top $ foldr func calkinwilfTree $ digits n
    where digits 1 = []
          digits n = mod n 2 : digits (div n 2)
          func 0 (Bin l _ _) = l
          func 1 (Bin _ _ r) = r
```

digitsでnを二進数の桁に分解して、その情報をつかって、funcで木を根から下っていきます。

## calkinwilfGetPrettier

```haskell
calkinwilfGetPrettier :: Int -> Rational
calkinwilfGetPrettier n = top $ go n
    where go n
            | mod n 2 == 0 = left $ go $ div n 2
            | otherwise    = right $ go $ div n 2
          left (Bin l _ _) = l
          right (Bin _ _ r) = r
          top (Bin _ x _) = x
```

calkinwilfGetの改善版です。元々の版ではリストを再帰的に生成してから畳み込みをする、ということをしていますが、よく考えると途中でリストをつくる必要はなくて、このように書けます。リストを生成しないこちらの書き方のほうが、メモリ効率がよくなります。

一般に、展開 (unfold) して再帰的なデータを作ったあと畳み込み (fold) をする、という操作は、途中のデータを作らなくてよいことが多いです。途中のデータを作らないようにプログラムを書き換えることを融合変換といって、Haskellで融合変換を機械的に行う研究がいろいろなされています。

## calkinwilfParent

```haskell
calkinwilfParent :: Rational -> Rational
calkinwilfParent x
    | x < 1 = m % (n-m)
    | x > 1 = (m-n) % n
    where m = numerator x
          n = denominator x
```

ある節点の左の子は必ず1より小さく、右の子は必ず1より大きいということを利用します。

## calkinwilfPrev

```haskell
calkinwilfPrev :: Rational -> Rational
calkinwilfPrev x = (m' + k * m) % m
    where m = numerator x
          n = denominator x
          div' x y = div (x-1) y
          mod' x y = mod (x-1) y + 1
          k = div' n m
          n' = mod' n m
          m' = m - n'
```

自分がある節点の左の子である限り親をたどっていきます。この回数をkとします。そして右の子になったら、親に行ってその左の子に行きます。そしてまたk回右の子をたどります。そしてたどりついた値が答えになります。kを割り算によって定数時間で求められるのがポイントです。

ただし、k回親をたどると1/1にたどりつく可能性もあります。このときは親を0/1とし、その左の子を0/1とします。その右の子は1/1となります。これで上手くいくのです。

Calkin-Wilf木の根を0/1にしてみます。すると、この木の左端はずっと0/1になります。この木を横に見ていくと、Calkin-Wilf列が最初から横にのびていっていて、下に行けばいくほど長くなっているのがわかります。さらに上にも0/1を無限に伸ばしていってみましょう。この両方向に無限である二分木を横に見ていくと、なんと、どこを取ってもCalkin-Wilf列が無限に伸びていきます。

こうして考えてみると、このコードの意味がよりよくつかめてくるはずです。

## calkinwilfNext

```haskell
calkinwilfNext :: Rational -> Rational
calkinwilfNext x = n % (n' + k * n)
    where m = numerator x
          n = denominator x
          k = div m n
          m' = mod m n
          n' = n - m'
```

calkinwilfPrevと同様、右の子である限り親をたどって(k回とします)、左の子になったら親に行ってその左の子に行って、k回左の子をたどれば、答えが得られます。kは割り算によって定数時間で求めます。
