data X a =
    A (Int -> (Int,a))
  | B [(a, Maybe a)]
  | C ((a -> Int) -> Int)

instance Functor X where
    fmap f (A g) = A $ \n -> let (m,x) = g n in (m, f x)
    fmap f (B xs) = B $ map (\(y,z) -> (f y, fmap f z)) xs
    fmap f (C g) = C $ \h -> g (h.f)

x :: X Int
x = C (const 123)

main = print "OK"
