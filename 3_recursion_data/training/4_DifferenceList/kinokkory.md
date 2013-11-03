## Difference List 解説

## flatten

```haskell
flatten :: BinaryTree a -> [a]
flatten t = flatten' t []
flatten' :: BinaryTree a -> ([a] -> [a])
flatten' Tip = id
flatten' (Bin l x r) = flatten' l . ([x]++) . flatten' r
```

このソースコードは非常にシンプルですが、どういうプロセスで書いたものなのかを詳しく書いていきます。

タイトルの Difference List というのは、日本語だと差分リストといって、リストをリストの差分として表現するデータ型のことです。型としては、

```haskell
type DiffList a = [a] -> [a]
```

となっていて、リストと差分リストは以下のように相互変換できます。

```haskell
list2difflist :: [a] -> DiffList a
list2difflist l = (l++)

difflist2list :: DiffList a -> [a]
difflist2list d = d []
```

リストと差分リストでは、結合における効率が変わります。

```haskell
(++) :: [a] -> [a] -> [a]
[] ++ b = b
(a:as) ++ b = a : (as++b)

(++*) :: DiffList a -> DiffList a -> DiffList a
a ++* b = a . b
```

実験してみましょう。

```haskell
aas = replicate 100000 [0]

go 1 = foldr (++) [] aas
go 2 = foldl (++) [] aas
go 3 = difflist2list $ foldr (++*) id $ map list2difflist aas
go 4 = difflist2list $ foldl (++*) id $ map list2difflist aas

main = do n <- readLn
          print $ length $ go n
```

こうしてみると、go 1 と go 3 と go 4 は効率がいいですが、go 2 は大変時間がかかります。(++) は右結合で一番効率がいいけれども、(++*) は右結合でも左結合でも効率は変わらないのです。(++*) は (.) と等しく、かつ f . (g . h) と (f . g) . h はまったく同じであるので、当然のことです。

もうお分かりでしょうが、解答のソースコードは、++*を利用したものです。次のように書き直すこともできます。

```haskell
type DiffList a = [a] -> [a]

list2difflist :: [a] -> DiffList a
list2difflist l = (l++)

difflist2list :: DiffList a -> [a]
difflist2list d = d []

(++*) :: DiffList a -> DiffList a -> DiffList a
a ++* b = a . b

flatten :: BinaryTree a -> [a]
flatten = difflist2list . flatten'
flatten' :: BinaryTree a -> DiffList a
flatten' Tip = list2difflist []
flatten' (Bin l x r) = flatten' l ++* list2difflist [x] ++* flatten' r
```
