machine' :: Int -> [String] -> [String]
machine' n ("sum":xs) = ("the sum is " ++ show n) : machine' n xs
machine' n ("end":xs) = ["end"]
machine' n (x:xs) = machine' (n + read x) xs

machine :: String -> String
machine s = unlines $ machine' 0 $ lines s

main = interact machine
