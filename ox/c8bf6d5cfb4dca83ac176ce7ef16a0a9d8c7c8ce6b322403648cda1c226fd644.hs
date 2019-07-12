-- ox export tail
tail :: [a] -> Maybe [a]
tail [] = Nothing
tail (a : rest) = Just rest
