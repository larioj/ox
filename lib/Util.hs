module Util where 

head :: [a] -> Maybe a
head [] = Nothing
head (a : rest) = Just a
