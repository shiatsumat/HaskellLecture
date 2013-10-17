machine :: String -> String
machine = machine' 0 . lines
machine' n (s:ss) = case s of
    "end" -> "goodbye\n"
    "sum" -> "the sum is "++show n++"\n"++machine' 0 ss
    _ -> machine' (n+read s) ss

main = interact machine
