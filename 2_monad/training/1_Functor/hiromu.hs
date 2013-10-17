data X a =
    A (Int -> X a)
  | B a [Either Int a]
  | C ((a -> Int) -> Int)

instance Functor (Either a) where
    fmap _ (Left x) = Left x
    fmap f (Right x) = Right (f x)

instance Functor X where
    fmap f (A x) = A (\y -> ((fmap f) (x y)))
    fmap f (B x y) = B (f x) (map (fmap f) y)
    fmap f (C x) = C (\y -> (x (y . f)))

main = print "OK"
