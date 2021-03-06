{-# LANGUAGE TypeFamilies #-}
module Data.Pass.Named
  ( Named(..)
  ) where

import Data.Binary
import Data.Binary.Put
import Data.Typeable
import Data.Hashable

infixl 0 `hashFunWithSalt`

class Typeable2 k => Named k where
  showsFun :: Int -> k a b -> String -> String

  putFun :: k a b -> Put
  putFun xs = put $ showsFun 0 xs ""

  hashFunWithSalt :: Int -> k a b -> Int
  hashFunWithSalt n xs = n `hashWithSalt` runPut (putFun xs)

  equalFun :: k a b -> k c d -> Bool
  equalFun xs ys = runPut (putFun xs) == runPut (putFun ys)
