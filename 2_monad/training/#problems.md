# 1 Functor

次のデータ型を手でFunctorのインスタンスにせよ。

```haskell
data X a =
    A (Int -> X a)
  | B a [Either Int a]
  | C ((a -> a -> Int) -> Int)
```
## ひながた

```haskell
data X a =
    A (Int -> X a)
  | B a [Either Int a]
  | C ((a -> a -> Int) -> Int)
{- edit here -}
main = print "OK"
```

# 2 Maybe Monad

次の関数をMaybeモナドをもちいて実装せよ。

```haskell
readInts :: Int -> ByteString -> Maybe [Int]
```

readInts k s は、文字列sに空白区切りで書かれている整数をk個読み込み、それらのリストをJust付きで返す。
k個未満しか数が得られない場合、Nothingを返す。

実装にあたっては、Data.ByteString.Char8 をインポートし、必要ならば次の関数をもちいよ。

```haskell
readInt :: ByteString -> Maybe (Int,ByteString)
```

## ひながた

```haskell
import qualified Data.ByteString.Char8 as BS
readInts :: Int -> BS.ByteString -> Maybe [Int]
{- edit here -}
main = do k <- readLn
          s <- BS.getContents
          print $ readInts k s
```

# 3 List Monad

次の関数をListモナドをもちいて実装せよ。

```haskell
dice :: [Int] -> Int -> Int -> [Int]
```

dice [a1,...,ak] g n は、すごろくで、a1,...,akのk個の目が書かれたさいころを、n回振ったあとにいる可能性のあるマスを、重複なく昇順に列挙するリストを返す。さいころの目は負である可能性もある。

最初コマは0のマスにいる。xのマスにいるときにaの目が出れば、x+aのマスに移動する。ただしx+aが0未満ならば0に移動する。

また、x+aがg以上ならばすごろくをゴールしたので、gに移動し、その後はさいころの目にかかわらずgに留まり続ける。

## ひながた

```haskell
import Data.List
import Control.Monad

dice :: [Int] -> Int -> Int -> [Int]
{- edit here -}
main = do g <- readLn
          n <- readLn
          k <- readLn
          as <- replicateM k readLn
          print $ dice as g n
```

# 4 Lazy IO

次の関数を遅延評価IOをもちいて実装せよ。

```haskell
machine :: String -> String
```

main = interact machine というふうにして使う。

この機械は内部に数字xを持っている。初期値は0である。

数字n を一行入力されると、何も表示せずxにnを足す。

sum と一行入力されると、"the sum is x" (xにxの値が入る) と一行表示し、xを0にリセットする。

end と一行入力されると、"goodbye" と一行表示し終了する。

## ひながた

```haskell
machine :: String -> String
{- edit here -}
main = interact machine
```

# 5 Random

次の関数を乱数とIOをもちいて実装せよ。

```haskell
calcPi :: Int -> IO Double
```

calcPi n は、-1<=x<=1,-1<=y<=1の範囲で平面上の点(x,y)をn個ランダムに取り、それらの点の中で単位円に入っているものの個数を数えることで、円周率の近似値を求める。

## ひながた

```haskell
import System.Random
calcPi :: Int -> IO Double
{- edit here -}
main = do n <- readLn
          print <$> calcPi n
```

# 6 Monad Trans

次の関数を実装せよ。

```haskell
getSubFolder :: FilePath -> ListT (IO FilePath)
getNSubFolder :: FilePath -> Int -> ListT (IO FilePath)
```

getSubFolder pathはpathで指定されたフォルダにあるサブフォルダ名を列挙する。
getNSubFolder n pathはpathで指定されたフォルダからn回サブフォルダをたどった先にあるフォルダを列挙する。getNSubFolder 1はgetSubFolderに等しい。

実装にあたっては、System.Directoryをインポートし、必要ならば次の関数をもちいよ。

```haskell
getDirectoryContents :: FilePath -> IO [FilePath]
-- フォルダ内のサブフォルダとファイルを列挙する。
-- 最後に".."(親フォルダ)と"."(フォルダ自身)を付け加えるので注意する。

doesDirectoryExist :: FilePath -> IO Bool
-- パスがフォルダがどうか判定する。
```

なお、FilePathはStringの型シノニムである。

## ひながた

```haskell
import Control.Monad.Trans.List
import System.Directory
getSubfolders :: FilePath -> ListT IO FilePath
{- edit here -}
getNSubfolders :: FilePath -> Int -> ListT IO FilePath
{- edit here -}
main = do path <- getLine
          n <- readLn :: IO Int
          l <- runListT $ getNSubfolders path n
          print l
```

# 7 RWS

## ひながた

# 8 Parsec A

## ひながた


# 9 Parsec B

## ひながた

# 10 Parsec C

## ひながた

