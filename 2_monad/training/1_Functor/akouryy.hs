data X a =
    A (Int -> X a)
  | B a [Either Int a]
  | C ((a -> Int) -> Int)
instance Functor X where
  -- fmap id = id
  -- fmap (f . g) = (fmap f) . (fmap g)
  -- fmap :: (a -> b) -> X a -> X b

  -- fmap :: (a -> b) -> A (Int -> X a) -> A (Int -> X b)
  -- fmap id (A p) = A ((fmap id) . p)
  --               = A (id p)
  --               = A p
  -- fmap (f . g) (A p) = A ((fmap (f. g)) . p)
  --                    = A ((fmap f) . (fmap g) . p)
  --                    = fmap f A ((fmap g) . p)
  --                    = fmap f (fmap g (A p))
  --                    = ((fmap f) . (fmap g)) (A p)
  fmap f (A p) = A ((fmap f) . p)

  -- fmap :: (a -> b) -> (B a [Either Int a]) -> (B b [Either Int b])
  -- fmap id (B a p) = B (id a) (fmap id p)
  --                 = B a (id p)
  --                 = B a p
  -- fmap (f . g) (B a p) = B ((f . g) a) (fmap (f . g) p)
  --                      = B (f (g a)) (((fmap f) . (fmap g)) p)
  --                      = B (f (g a)) ((fmap f) ((fmap g) p))
  --                      = B (f (g a)) (fmap f (fmap g p))
  --                      = fmap f (B (g a) (fmap g p))
  --                      = fmap f (fmap g (B a p))
  --                      = ((fmap f) . (fmap g)) (B a p)
  fmap f (B a p) = B (f a) (fmap (fmap f) p)

  -- fmap :: (a -> b) -> C ((a -> Int) -> Int) -> C ((b -> Int) -> Int)
  -- fmap id (C p) = C (\h -> p (h . id))
  --               = C (\h -> p h)
  --               = C p
  -- fmap (f . g) (C p) = C (\h -> p (h . (f . g)))
  --                    = C (\h -> p (h . f . g))
  --                    = C (\h -> p ((h . f) . g)) ... ?????
  --                    = C (\h -> (\i -> p (i . g)) (h . f))
  --                    = fmap f (C (\i -> p (i . g)))
  --                    = fmap f (fmap g (C p))
  --                    = ((fmap f) . (fmap g)) (C p)
  fmap f (C p) = C (\h -> p (h . f))
  -- fmap f (C p) = C ((\h :: b -> Int) -> p (h . f :: a -> Int) :: Int)
main = print "OK"
