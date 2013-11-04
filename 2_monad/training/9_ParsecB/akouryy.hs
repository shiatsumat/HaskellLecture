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

skipSpaces :: Parser ()
skipSpaces = do many $ oneOf [' ', '\t', '\n']
                return ()

name :: Parser Name
name = do c <- oneOf $ ['a'..'z'] ++ ['A'..'Z'] ++ ['_']
          s <- many $ oneOf $ ['a'..'z'] ++ ['A'..'Z'] ++ ['_', '-', '.'] ++ ['0'..'9']
          return $ c : s
quotedText :: Parser Text
quotedText = do char '"' {-"-}
                s <- many $ noneOf ['\\', '"'] {-"-} <|> (char '\\' >> noneOf [])
                char '"' {-"-}
                return s
attribute :: Parser Attribute
attribute = do n <- name
               skipSpaces
               char '='
               skipSpaces
               t <- quotedText
               return $ Attribute n t
text :: Parser Contents
text = do s <- many1 $ noneOf ['<', '>', '&']
          return $ Text s
element :: Parser Contents
element = do n <- try $ do char '<'
                           name
             skipSpaces
             a <- many $ do a <- attribute
                            skipSpaces
                            return a
{-
             (do char '>'
                 c <- many contents
                 string "</"
                 string n
                 char '>'
                 return $ Element n a c)
-}
             (char '>' >> (many contents) >>= (string "</" >>) . (string n >>) . (char '>' >>) . (return . (Element n a)))
              <|> (string "/>" >> (return $ Element n a []))

contents :: Parser Contents
contents = element <|> text

xml :: Parser Contents
xml = contents

main = do s <- getContents
          parseTest xml s
