data X a =
    A (Int -> X a)
  | B a [Either Int a]
  | C ((a -> Int) -> Int)

instance Functor X where
    fmap f (A g) = A $ \n -> fmap f (g n)
    fmap f (B x xs) = B (f x) (map (fmap f) xs)
    fmap f (C g) = C $ \h -> g (h.f)

main = print "OK"
