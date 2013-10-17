import Control.Monad
import Control.Applicative
import Data.IORef

big = 1000000
go1 = f big >>= print
    where f 0 = return 0
          f n = f (n-1) >>= return.(+1)
go2 = do {r <- newIORef 0; replicateM_ big (modifyIORef r (+1)); readIORef r >>= print}
go3 = do {r <- newIORef 0; replicateM_ big (modifyIORef' r (+1)); readIORef r >>= print}
-- go1 and go2 use a lot of memory, but go3 doesn't

main = go3
