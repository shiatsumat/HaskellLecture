import Data.Ratio

data BinaryTree a = Bin (BinaryTree a) a (BinaryTree a) | Tip

instance Show a => Show (BinaryTree a) where
  show = showBinaryTree

takeBinaryTree :: Int -> BinaryTree a -> BinaryTree a
{- edit here -}
takeBinaryTree 1 (Bin _ a _) = Bin Tip a Tip
takeBinaryTree _ Tip = Tip
takeBinaryTree n (Bin left a right) = Bin (takeBinaryTree (n - 1) left) a (takeBinaryTree (n - 1) right)
{- pyaaaaaaa -}

showBinaryTree :: Show a => BinaryTree a -> String
{- edit here -}
showBinaryTree Tip = ""
showBinaryTree (Bin left a right) = let (ll, lc, lr) = splitSBT  ([],[],(lines $ showBinaryTree left))
                                        (rl, rc, rr) = splitSBT  ([],[],(lines $ showBinaryTree right))
                                      in unlines $ (map (\x->"   "++x) rl) ++ (map (\x->"+--"++x) rc) ++ (map (\x->"|  "++x) rr) ++ [show a] ++ (map (\x->"|  "++x) ll) ++ (map (\x->"+--"++x) lc) ++ (map (\x->"   "++x) lr)

splitSBT::([String], [String], [String])->([String], [String], [String])
splitSBT a@(_, _, []) = a
splitSBT res@(lefts, n, (a:as)) | f /= "+" && f /= "|" && f /= " " && n /= []= res
                                | otherwise = splitSBT (lefts ++ n, [a], as)
                               where f = if n == [] || n == [""] then "" else take 1 $ n!!0
{- pyaaaaaaa -}

calkinwilfTree :: BinaryTree Rational
calkinwilfTree = calkinwilfTree' (1 % 1)

calkinwilfTree' :: Rational -> BinaryTree Rational
calkinwilfTree' x = Bin (calkinwilfTree' $ n % (n + m)) x (calkinwilfTree' $ (n + m) % m)
                    where n = numerator x
                          m = denominator x

{- edit here -}

calkinwilfSeq :: [Rational]
{- edit here -}
calkinwilfSeq = concat $ bfs calkinwilfTree

bfs::BinaryTree a -> [[a]]
bfs Tip = []
bfs (Bin left a right) = [[a]] ++ (zipWith (++) (bfs left) (bfs right))

calkinwilfGet :: Int -> Rational
{- edit here -}
calkinwilfGet n = getTree (drop 1 $ bin n) calkinwilfTree

bin :: Int -> String
bin 0 = "0"
bin 1 = "1"
bin n | odd n  = bin (div n 2) ++ "1"
      | even n = bin (div n 2) ++ "0"

getTree :: String -> BinaryTree a -> a
getTree "" (Bin _ a _) = a
getTree ('0':ns) (Bin left a right) = getTree ns left
getTree ('1':ns) (Bin left a right) = getTree ns right


--main = print $ takeBinaryTree 5 calkinwilfTree
--main = print $ take 100 $ calkinwilfSeq
main = print $ calkinwilfGet 100