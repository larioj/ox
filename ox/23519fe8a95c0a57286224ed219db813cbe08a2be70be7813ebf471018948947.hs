-- ox export head
head :: [a] -> Maybe a
head [] = Nothing
head (a : rest) = Just a
