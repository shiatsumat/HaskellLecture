{-# LANGUAGE GADTs, TypeFamilies, DataKinds, ConstraintKinds #-}
{-# LANGUAGE TypeOperators, ScopedTypeVariables #-}
import Control.Monad.Trans.List
import System.Directory
import System.Directory

getSubfolders :: FilePath -> ListT IO FilePath
getSubfolders path = do 
{- edit here -}
getNSubfolders :: FilePath -> Int -> ListT IO FilePath
{- edit here -}
main = do path <- getLine
          n <- readLn
          l <- runListT $ getNSubfolders path n
          print l