import Text.Parsec
import Text.Parsec.String
import Control.Applicative ((<$>), (<*>), pure)

type Name = String
type Text = String
data Attribute = Attribute Name Text
  deriving (Show,Read)
data Contents =
    Element Name [Attribute] [Contents]
  | Text Text
  deriving (Show,Read)
data XmlDecl = XmlDecl [Attribute]
  deriving (Show,Read)

comment :: Parser Text
comment = do try $ string "<!--"
             s <- many (do c <- anyChar; notFollowedBy $ string "-->"; return c)
             string "-->"
             return s
     <?> "comment"

white, white' :: Parser String
white = white' <|> return ""
white' = many1 (space <|> (comment>>return ' ')) >> return " "
    <?> "white"

name :: Parser Name
name = do c <- letter
          cs <- many alphaNum
          return (c:cs)
   <?> "name"

escape :: Parser Char
escape = do char '\\'
            c <- anyChar
            case c of
               '\'' -> return '\''
               '\"' -> return '\"'
               '\\' -> return '\\'

quotedText :: Parser Text
quotedText = do char '\''
                s <- many (escape <|> noneOf "\'")
                char '\''
                return s
         <|> do char '\"'
                s <- many (escape <|> noneOf "\"")
                char '\"'
                return s
         <?> "quotedText"

attribute :: Parser Attribute
attribute = do n <- name
               white
               char '='
               white
               s <- quotedText
               white
               return $ Attribute n s
        <?> "attribute"

text :: Parser Contents
text = Text <$> concat <$> many1 (white' <|> pure <$> noneOf "<>")
    <?> "text"

emptyElement :: Parser Contents
emptyElement = do char '<'
                  white
                  n <- name
                  white
                  as <- many attribute
                  white
                  string "/>"
                  return $ Element n as []

element :: Parser Contents
element = try emptyElement
      <|> do char '<'
             white
             n <- name
             white
             as <- many attribute
             char '>'
             cs <- many contents
             string "</"
             white
             n' <- name
             white
             char '>'
             if n/=n' then fail "opening tag and closing tag don't match" else return $ Element n as cs
      <?> "element"

contents :: Parser Contents
contents = text
       <|> do notFollowedBy $ string "</"
              element
       <?> "contents"

xmldecl :: Parser XmlDecl
xmldecl = do string "<?xml"
             white
             as <- many attribute
             string "?>"
             return $ XmlDecl as

xml :: Parser Contents
xml = optional (white >> xmldecl) >> white >> element
    <?> "xml"

main = do s <- getContents
          parseTest xml s

