# Maybe Monad 解説

## readInts

```haskell
import qualified Data.ByteString.Char8 as BS

readInts :: Int -> BS.ByteString -> Maybe [Int]
readInts 0 _ = return []
readInts k s = do (n,s') <- BS.readInt s
                  ns <- readInts (k-1) (BS.tail s')
                  return (n:ns)
```

再帰するというだけでMaybeモナドの基本的な使い方が分かれば十分です。

## main

```haskell
main = do k <- readLn
          s <- BS.getContents
          print $ readInts k s
```

BS.getContents で入力全体を読み込んでいます。一般に、入力は一気に全部読み込んで文字列として処理していくほうが、少しずつ読み込むよりも効率がいいです。
