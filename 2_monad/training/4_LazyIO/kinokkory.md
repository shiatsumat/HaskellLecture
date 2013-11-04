# 4 Lazy IO 解説

## machine

```haskell
machine :: String -> String
machine = machine' 0 . lines
machine' n (s:ss) = case s of
    "end" -> "goodbye\n"
    "sum" -> "the sum is "++show n++"\n"++machine' 0 ss
    _ -> machine' (n+read s) ss
```

先に文字列を lines によって行ごとに分割してから、machine' に渡しています。
また、内部の整数を持つために、machine' に引数として n を持たせています。

## main

```haskell
main = interact machine
```
