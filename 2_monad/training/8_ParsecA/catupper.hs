import Text.Parsec
import Text.Parsec.String
import Text.Parsec.Expr
import Control.Applicative((<$>), (<*>))
number :: Parser Double
number = do nat   <- many1 digit
            point <- option "" $ (:) <$> char '.' <*> many1 digit
            exp   <- option "" $ (:) <$> char 'e' <*> ((++) <$> option "" (string "-") <*>  (many1 digit))
            spaces
            return $ read $ nat++point++exp
{- edit here -}


expression :: Parser Double
expression = spaces >> buildExpressionParser operators terms
{- edit here -}

operators = [
                [Prefix (char '-' >> spaces >> return (* (-1))) , Prefix (char '+' >> spaces >> return (* 1))],
                [Infix  (char '*' >> spaces >> return (*)) AssocLeft, Infix (char '/' >> spaces >> return (/)) AssocLeft],
                [Infix  (char '+' >> spaces >> return (+)) AssocLeft, Infix (char '-' >>  spaces >> return (-)) AssocLeft],
                [Infix ( char '^' >> spaces >> return(**)) AssocRight]
            ]

terms :: Parser Double
terms = number <|> between (char '(') (char ')') expression <|> Main.log

log :: Parser Double
log = do string "log"
         spaces
         char '('
         spaces
         a <- expression
         spaces
         char ','
         spaces
         b <- expression
         spaces
         char ')'
         spaces
         return $ logBase a b

main = do s <- getContents
          parseTest expression s