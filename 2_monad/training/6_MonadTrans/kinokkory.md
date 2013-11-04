# 6 Monad Trans 解説

## getSubfolders

```haskell
getSubfolders :: FilePath -> ListT IO FilePath
getSubfolders path = ListT $ getDirectoryContents path >>= return . map ((path++"/")++) . filter (\p -> p/=".."&&p/=".") >>= filterM doesDirectoryExist
```

ListT というデータ構築子をつかうことが重要です。

## getNSubfolders

```haskell
getNSubfolders :: FilePath -> Int -> ListT IO FilePath
getNSubfolders path 0 = return path
getNSubfolders path n = do p <- getNSubfolders path (n-1)
                           q <- getSubfolders p
                           lift (putStrLn $ "I found it "++show n++" levels down!")
                           return q
```

あとは getSubfolders をもちいてリストモナドと同様に行えます。
lift で IO を持ち上げられることが重要です。

## main

```haskell
main = do path <- getLine
          n <- readLn
          l <- runListT $ getNSubfolders path n
          print l
```

ここで runListT をもちいています。
