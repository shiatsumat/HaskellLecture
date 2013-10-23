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
main = print 0
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
-- 文字列から整数をひとつ読み込み、その整数と残りの文字列とのペアをJust付きで返す
-- 整数の読み込みに失敗した場合はNothing

tail :: ByteString -> ByteString
-- 文字列から一文字目を除いたものを返す
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

実装にあたって、必要ならば次の関数をもちいよ。

```haskell
nub :: Eq a => [a] -> [a]
-- 重複を取り除く

sort :: Ord a => [a] -> [a]
-- 昇順にソートする
```

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

* 数字*n* を一行入力されると、何も表示せずxにnを足す。
* "sum" と一行入力されると、"the sum is *x*" と一行表示し、xを0にリセットする。
* "end" と一行入力されると、"goodbye" と一行表示し終了する。

実装にあたって、必要ならば次の関数をもちいよ。

```haskell
lines :: String -> [String]
-- 文字列を行ごとに分割する
```

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

実装にあたっては、System.Randomをインポートし、必要ならば次の (いずれかの) 関数をもちいよ。

```haskell
fromIntegral :: (Integral a, Num b) => a -> b

realToFrac :: (Real a, Fractional b) => a -> b
```

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

getSubFolder pathはpathで指定されたフォルダにあるサブフォルダ名を列挙する。しかしただ列挙するだけでは寂しいので標準出力に searching *path* と一行出力する。

getNSubFolder n pathはpathで指定されたフォルダからn回サブフォルダをたどった先にあるフォルダを列挙する。getNSubFolder 1はgetSubFolderに等しい。しかしただ列挙するだけでは寂しいので、フォルダを見つけるごとに標準出力に I found it *n* levels down! と一行出力する。

実装にあたっては、Control.Monad.Trans.ListとSystem.Directoryをインポートし、必要ならば次の関数をもちいよ。

```haskell
lift :: (MonadTrans t, Monad m) => m a -> t m a
-- モナドを持ち上げる

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
          n <- readLn
          l <- runListT $ getNSubfolders path n
          print l
```

# 7 RWS

RWSモナドをもちいて次の二つの関数を実装せよ。

```haskell
step :: RWS String String (String,Int) Int
```

stepはロボットの一段階を表す。入力文字列を一行だけ消費し、一行だけ出力する。

RWS String String (String,Int) Int のうち、

* ReaderのStringはロボットの名前を表す。
* WriterのStringはロボットの出力を表す。
* Stateの(String,Int)は入力文字列と内部の整数を表す。
* 返り値のIntは次のコードを表す。1は未終了、0は正常終了、-1はエラーによる終了を表す。

入力文字列が

* "name" だったら "My name is *name*!" と出力しコード1を返す。
* "sum" だったら "The sum is *n*." と内部の整数を出力し、内部の整数を0にリセットし、コード1を返す。
* "quit" だったら "Goodbye!" と出力しコード0で終了する。
* "error" だったら "qawsedrftgyhujikolp" と出力しコード-1で終了する。
* 数字 "*m*" だったら "I added *m*." と出力し、内部の整数にmを足し、コード1を返す。

```haskell
robot :: RWS String String (String,Int) ()
```

robotはロボットを表す。

robotはstepがコード0か-1を返すまでstepを繰り返しつづける。stepがコード-1を返したら Oops, sorry. と出力する。

実装にあたっては、Control.Monad.Trans.RWSをインポートし、必要ならば次の関数をもちいよ。

```haskell
ask :: MonadReader r m => m r
-- 環境の取得

tell :: MonadWriter w m => w -> m ()
-- ログへの追加

get :: MonadState s m => m s
-- 状態の取得

put :: MonadState s m => s -> m ()
-- 状態の設定
```

## ひながた

```haskell
import Control.Monad.Trans.RWS
step :: RWS String String (String,Int) Int
{- edit here -}
robot :: RWS String String (String,Int) ()
{- edit here -}
main = do name <- getLine
          putStrLn $ "Robot "++name++" started!"
          s <- getContents
          let (_,_,output) = runRWS robot name (s,0)
          putStr output
```

# 8 Parsec A

数式のパーサーを書け。

* 1234.56 や 1.23456e3 のような浮動小数を扱える。実装ではreadなどを利用してよい。
* 中置演算子として +, -, *, /, ^ (加・減・乗・除・冪乗) がある。
* 前置演算子として +, - がある。
* 前置演算子の+と-が優先度が最高で、*と/が優先度が二番目で左結合、中置演算子の+と-が優先度が三番目で左結合、^が優先度が四番目で右結合である。
* 二引数関数として log がある。log(3,9)というような形で使える (この場合の値は2である)。
* () で式をまとめられる。

以上の条件を満たすように、次の関数を実装せよ。

```haskell
number :: Parser Double
expression :: Parser Double
```

実装にあたっては、 Text.ParsecとText.Parsec.StringとText.Parsec.Exprをインポートし、必要ならば次の関数をもちいよ。

```haskell
(<|>) :: (ParsecT s u m a) -> (ParsecT s u m a) -> (ParsecT s u m a)
(<?>) :: (ParsecT s u m a) -> String -> (ParsecT s u m a)

try :: ParsecT s u m a -> ParsecT s u m a
notFollowedBy :: (Stream s m t, Show a) => ParsecT s u m a -> ParsecT s u m ()

many, many1 :: Stream s m t => ParsecT s u m a -> ParsecT s u m [a]
between :: Stream s m t => ParsecT s u m open -> ParsecT s u m close -> ParsecT s u m a -> ParsecT s u m a
option :: Stream s m t => a -> ParsecT s u m a -> ParsecT s u m a

char :: Stream s m Char => Char -> ParsecT s u m Char
string :: Stream s m Char => String -> ParsecT s u m String
oneOf, noneOf :: Stream s m Char => [Char] -> ParsecT s u m Char
letter, digit, alphaNum, space, anyChar :: Stream s m Char => ParsecT s u m Char

buildExpressionParser :: Stream s m t => OperatorTable s u m a -> ParsecT s u m a -> ParsecT s u m a
```

なお、データ型の定義は以下のとおりである。

```haskell
data Assoc = AssocNone
           | AssocLeft
           | AssocRight
-- AssocNoneが無結合、AssocLeftが左結合、AssocRightが右結合

data Operator s u m a = Infix (ParsecT s u m (a -> a -> a)) Assoc
                      | Prefix (ParsecT s u m (a -> a))
                      | Postfix (ParsecT s u m (a -> a))
-- Infixが中置演算子、Prefixが前置演算子、Postfixが後置演算子

type OperatorTable s u m a = [[Operator s u m a]]
-- 優先度が高い順に演算子が入っている
```

## ひながた

```haskell
import Text.Parsec
import Text.Parsec.String
import Text.Parsec.Expr

number :: Parser Double
{- edit here -}

expression :: Parser Double
{- edit here -}

main = do s <- getContents
          parseTest expression s
```

# 9 Parsec B

XMLのパーサーを書け。

```haskell
type Name = String
type Text = String
data Attribute = Attribute Name Text
  deriving (Show,Read)
data Contents =
    Element Name [Attribute] [Contents]
  | Text Text
  deriving (Show,Read)
```

以上のデータ型をもちいて、次の関数を実装せよ。

```haskell
name :: Parser Name
quotedText :: Parser Text
attribute :: Parser Attribute
text :: Parser Contents
element :: Parser Contents
contents :: Parser Contents
xml :: Parser Contents
```

* name は要素や属性の名前である。
* quotedText は属性の内容となる引用符に囲まれた文字列である。
* attribute は属性である。
* text は要素の中身となる文字列である。
* element は要素である。
* contents は要素の中身となる要素あるいは文字列である。
* xml は XML自体である。

字句処理やXML宣言やDTDなどの細かい部分は無視してもよい。

実装にあたっては、 Text.ParsecとText.Parsec.Stringをインポートし、必要ならば次の関数をもちいよ。

```haskell
(<|>) :: (ParsecT s u m a) -> (ParsecT s u m a) -> (ParsecT s u m a)
(<?>) :: (ParsecT s u m a) -> String -> (ParsecT s u m a)

try :: ParsecT s u m a -> ParsecT s u m a
notFollowedBy :: (Stream s m t, Show a) => ParsecT s u m a -> ParsecT s u m ()

many, many1 :: Stream s m t => ParsecT s u m a -> ParsecT s u m [a]
between :: Stream s m t => ParsecT s u m open -> ParsecT s u m close -> ParsecT s u m a -> ParsecT s u m a
option :: Stream s m t => a -> ParsecT s u m a -> ParsecT s u m a

char :: Stream s m Char => Char -> ParsecT s u m Char
string :: Stream s m Char => String -> ParsecT s u m String
oneOf, noneOf :: Stream s m Char => [Char] -> ParsecT s u m Char
letter, digit, alphaNum, space, anyChar :: Stream s m Char => ParsecT s u m Char
```

## ひながた

```haskell
import Text.Parsec
import Text.Parsec.String

type Name = String
type Text = String
data Attribute = Attribute Name Text
  deriving (Show,Read)
data Contents =
    Element Name [Attribute] [Contents]
  | Text Text
  deriving (Show,Read)

name :: Parser Name
{- edit here -}
quotedText :: Parser Text
{- edit here -}
attribute :: Parser Attribute
{- edit here -}
text :: Parser Contents
{- edit here -}
element :: Parser Contents
{- edit here -}
contents :: Parser Contents
{- edit here -}
xml :: Parser Contents
{- edit here -}
main = do s <- getContents
          parseTest xml s
```
