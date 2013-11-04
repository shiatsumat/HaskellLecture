# Monad Trans ‰ðà

## getSubfolders

```haskell
getSubfolders :: FilePath -> ListT IO FilePath
getSubfolders path = ListT $ getDirectoryContents path >>= return . map ((path++"/")++) . filter (\p -> p/=".."&&p/=".") >>= filterM doesDirectoryExist
```

## getNSubfolders

```haskell
getNSubfolders :: FilePath -> Int -> ListT IO FilePath
getNSubfolders path 0 = return path
getNSubfolders path n = do p <- getNSubfolders path (n-1)
                           q <- getSubfolders p
                           lift (putStrLn $ "I found it "++show n++" levels down!")
                           return q
```

## main

```haskell
main = do path <- getLine
          n <- readLn
          l <- runListT $ getNSubfolders path n
          print l
```