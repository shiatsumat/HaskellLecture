import Control.Monad.Trans.RWS
import Control.Applicative
import Control.Monad

step :: RWS String [String] ([String],Int) Int
{- edit here -}
step = do (commands, num) <- get
          let (command:remainder) = commands
          return 0
          case command of
               "name"  -> do {name <- ask; tell ["My name is " ++ name ++ "!"]; put (remainder, num); return 1}
               "sum"   -> do {tell [show num]; put(remainder, 0); return 1}
               "quit"  -> do {tell ["Goodbye!"]; return 0}
               "error" -> do {tell ["qwasedrftgyhujikolp"];put (remainder, num); return (-1)}
               command -> do {tell ["I added " ++ (show command) ++ "."]; put (remainder, num + (read command)); return 1}
{- pyaaaaaaa -}

robot :: RWS String [String] ([String],Int) ()
{- edit here -}
robot = do n <- step
           case n of
                1  -> robot
                0  -> return ()
                -1 -> tell $ ["oops, sorry."]
{- pyaaaaaaa -}

main = do name <- getLine
          putStrLn $ "Robot "++name++" started!"
          s <- getContents
          let (_,_,output) = runRWS robot name (lines s,0)
          putStr $ unlines output