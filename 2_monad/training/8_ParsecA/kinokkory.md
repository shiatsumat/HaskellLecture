# 8 Parsec A 解説

## インポート

```haskell
import Text.Parsec
import Text.Parsec.String
import Text.Parsec.Expr
import Control.Applicative ((<$>),(<*>))
```

Text.Parsec.String では

```haskell
type Parser = Parsec String ()
```

と定義されているので、それを使うためだけにインポートしています。

Applicativeでは (<|>) も定義されていて、Parsecの (<|>) と衝突するので、必要な分だけインポートしています。

## number

```haskell
number :: Parser Double
number = do a <- many1 digit
            b <- option "" $ (:) <$> char '.' <*> many1 digit
            c <- option "" $ (:) <$> char 'e' <*> ((++) <$> option "" (string "-") <*> many1 digit)
            spaces
            return $ read $ a++b++c
```

number をまともにパースするのは面倒なので Haskell の read を利用しています。optionを少しテクニカルに使っているので分かりにくいですが、別に難しい話ではないです。

空白の処理を後に回すということが非常に重要です。

## term

```haskell
term :: Parser Double
term = number
   <|> between (char '(') (char ')') expression
   <|> do string "log" >> spaces
          char '(' >> spaces
          x <- expression
          char ',' >> spaces
          y <- expression
          char ')' >> spaces
          return $ logBase x y
```

log の処理は意外と簡単です。

空白の処理を後に回すということが非常に重要です。

## expression

```haskell
table = [
    [Prefix (char '+' >> spaces >> return id), Prefix (char '-' >> spaces >> return negate)],
    [Infix (char '*' >> spaces >> return (*)) AssocLeft, Infix (char '/' >> spaces >> return (/)) AssocLeft], 
    [Infix (char '+' >> spaces >> return (+)) AssocLeft, Infix (char '-' >> spaces >> return (-)) AssocLeft],
    [Infix (char '^' >> spaces >> return (**)) AssocRight]]

expression :: Parser Double
expression = spaces >> buildExpressionParser table term
```

buildExpressionParser をきちんと使えば問題ありません。

空白の処理を後に回すということが非常に重要です。頭の空白はexpressionで初めて飛ばします。

## main

```haskell
main = do s <- getContents
          parseTest expression s
```

parseTest はパーサーをデバッグ用に動かすための便利な関数です。
