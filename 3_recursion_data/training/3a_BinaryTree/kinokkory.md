# 3a Binary Tree 解説

## takeBinaryTree

```haskell
takeBinaryTree :: Int -> BinaryTree a -> BinaryTree a
takeBinaryTree 0 _ = Tip
takeBinaryTree n Tip = Tip
takeBinaryTree n (Bin l x r) = Bin (takeBinaryTree (n-1) l) x (takeBinaryTree (n-1) r)
```

おおむねリスト上の関数 take :: Int -> [a] -> [a] と同じです。

## showBinaryTree

```haskell
showBinaryTree :: Show a => BinaryTree a -> String
showBinaryTree t = unlines $ showBinaryTree' 0 t
showBinaryTree' :: Show a => Int -> BinaryTree a -> [String]
showBinaryTree' _ Tip = []
showBinaryTree' i (Bin l x r)
    | i== 0  = sr++[sx]++sl
    | i== 1  = map ("|  "++) sr ++ ["+--"++sx] ++ map ("   "++) sl
    | i== -1 = map ("   "++) sr ++ ["+--"++sx] ++ map ("|  "++) sl
    where sl = showBinaryTree' 1 l
          sr = showBinaryTree' (-1) r
          sx = show x
```

文字列が二次元の構造を持っているので、文字のリストのリスト（文字列のリスト）として扱うのがいいでしょう。行のリストを取るかそれとも列のリストを取るか、という問題がありますが、この問題では行のリストを取る方が書きやすいと思います。
