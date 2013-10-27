# 2 Unfolding List 解説

## map

```haskell
map :: (a -> b) -> [a] -> [b]
map f = unfoldr (\as -> if null as then Nothing else Just (f (head as), tail as))
```

終了条件を考えればいいだけです。

## replicate

```haskell
replicate :: Int -> a -> [a]
replicate n a = unfoldr (\n -> if n==0 then Nothing else Just (a,n-1)) n
```

終了条件を考えればいいだけです。

## fib

```haskell
fib :: [Int]
fib = unfoldr (\(a,b) -> Just (a,(b,a+b))) (1,1)
```

無限リストをつくるので、第一引数の関数ではずっと Just ... を返すことになります。
