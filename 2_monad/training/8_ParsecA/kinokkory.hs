import Text.Parsec
import Text.Parsec.String
import Text.Parsec.Expr
import Control.Applicative ((<$>),(<*>))

number :: Parser Double
number = do a <- many1 digit
            b <- option "" $ (:) <$> char '.' <*> many1 digit
            c <- option "" $ (:) <$> char 'e' <*> ((++) <$> option "" (string "-") <*> many1 digit)
            spaces
            return $ read $ a++b++c

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

table = [
    [Prefix (char '+' >> spaces >> return id), Prefix (char '-' >> spaces >> return negate)],
    [Infix (char '*' >> spaces >> return (*)) AssocLeft, Infix (char '/' >> spaces >> return (/)) AssocLeft], 
    [Infix (char '+' >> spaces >> return (+)) AssocLeft, Infix (char '-' >> spaces >> return (-)) AssocLeft],
    [Infix (char '^' >> spaces >> return (**)) AssocRight]]

expression :: Parser Double
expression = spaces >> buildExpressionParser table term

main = do s <- getContents
          parseTest expression s

