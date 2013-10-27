import Data.Ratio

data BinaryTree a = Bin (BinaryTree a) a (BinaryTree a) | Tip

instance Show a => Show (BinaryTree a) where
  show = showBinaryTree

takeBinaryTree :: Int -> BinaryTree a -> BinaryTree a
takeBinaryTree 0 _ = Tip
takeBinaryTree n Tip = Tip
takeBinaryTree n (Bin l x r) = Bin (takeBinaryTree (n-1) l) x (takeBinaryTree (n-1) r)

showBinaryTree :: Show a => BinaryTree a -> String
showBinaryTree t = unlines $ fst $ showBinaryTree' 0 t
showBinaryTree' :: Show a => Int -> BinaryTree a -> ([String],Int)
showBinaryTree' _ Tip = ([], 0)
showBinaryTree' i (Bin l x r)
    | i== 0  = (sr++[sx]++sl, n)
    | i== 1  = (map ("|  "++) sr ++ ["+--"++sx] ++ map ("   "++) sl, n)
    | i== -1 = (map ("   "++) sr ++ ["+--"++sx] ++ map ("|  "++) sl, n)
    where (sl,nl) = showBinaryTree' 1 l
          (sr,nr) = showBinaryTree' (-1) r
          n = nl + 1 + nr
          sx = show x

calkinwilfTree :: BinaryTree Rational
calkinwilfTree = go (1%1)
    where go x = Bin (go (m%(m+n))) x (go ((m+n)%n))
            where m = numerator x
                  n = denominator x

calkinwilfSeq :: [Rational]
calkinwilfSeq = map top queue
    where queue = calkinwilfTree : walk queue
          walk (Bin l _ r : q) = l : r : walk q
          top (Bin _ x _) = x

calkinwilfSeqAnother :: [Rational]
calkinwilfSeqAnother = concat $ levels calkinwilfTree
    where levels (Bin l x r) = [x] : zipWith (++) (levels l) (levels r)

calkinwilfGet :: Int -> Rational
calkinwilfGet n =  top $ foldr func calkinwilfTree $ digits n
    where digits 1 = []
          digits n = mod n 2 : digits (div n 2)
          func 0 (Bin l _ _) = l
          func 1 (Bin _ _ r) = r
          top (Bin _ x _) = x

calkinwilfGetPrettier :: Int -> Rational
calkinwilfGetPrettier n = top $ go n
    where go n
            | mod n 2 == 0 = left $ go $ div n 2
            | otherwise    = right $ go $ div n 2
          left (Bin l _ _) = l
          right (Bin _ _ r) = r
          top (Bin _ x _) = x

calkinwilfParent :: Rational -> Rational
calkinwilfParent x
    | x < 1 = m % (n-m)
    | x > 1 = (m-n) % n
    where m = numerator x
          n = denominator x

calkinwilfPrev :: Rational -> Rational
calkinwilfPrev x = (m' + k * m) % m
    where m = numerator x
          n = denominator x
          div' x y = div (x-1) y
          mod' x y = mod (x-1) y + 1
          k = div' n m
          n' = mod' n m
          m' = m - n'

calkinwilfNext :: Rational -> Rational
calkinwilfNext x = n % (n' + k * n)
    where m = numerator x
          n = denominator x
          k = div m n
          m' = mod m n
          n' = n - m'

main = print $ takeBinaryTree 5 calkinwilfTree
-- main = print $ take 100 $ calkinwilfSeq
-- main = print $ map calkinwilfGet [1..100]
-- main = print $ take 100 $ iterate calkinwilfNext (1%1)
-- main = print $ reverse $ take 100 $ iterate calkinwilfPrev (7%19)

