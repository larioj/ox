module Ox23519fe8a95c0a57286224ed219db813cbe08a2be70be7813ebf471018948947 where 

-- ox export head
head :: [a] -> Maybe a
head [] = Nothing
head (a : rest) = Just a
