data X a =
    A (Int -> X a)
  | B a [Either Int a]
  | C ((a -> Int) -> Int)

instance Functor X where
    fmap f (A x)   = A $ (fmap f) . x
    fmap f (B x y) = B (f x) $ fmap (fmap f) y
    fmap f (C x)   = C $ \y -> x $ y . f

main = print "OK"
