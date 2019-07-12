module Oxc8bf6d5cfb4dca83ac176ce7ef16a0a9d8c7c8ce6b322403648cda1c226fd644 where 

-- ox export tail
tail :: [a] -> Maybe [a]
tail [] = Nothing
tail (a : rest) = Just rest
