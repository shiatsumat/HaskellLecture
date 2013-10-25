import Control.Monad.Trans.RWS

step :: RWS String [String] ([String],Int) Int
step = do ((cmd:rem), sum) <- get
          case cmd of
               "name"  -> do {name <- ask;tell ["My name is " ++ name ++ "!"];put (rem, sum);return 1}
               "sum"   -> do {tell ["The sum is " ++ (show sum) ++ "."];put(rem, 0);return 1}
               "quit"  -> do {tell ["Goodbye!"];return 0}
               "error" -> do {tell ["qawsedrftgyhujikolp"];return (-1)}
               cmd     -> do {tell ["I added " ++ cmd ++ "."];put (rem, sum + (read cmd));return 1 }

robot :: RWS String [String] ([String],Int) ()
robot = do ret <- step
           case ret of
                0    -> return ()
                (-1) -> tell ["Oops, sorry."]
                1    -> robot


main = do name <- getLine
          putStrLn $ "Robot "++name++" started!"
          s <- getContents
          let (_,_,output) = runRWS robot name (lines s,0)
          putStr $ unlines $ output
