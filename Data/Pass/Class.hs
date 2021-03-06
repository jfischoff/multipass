module Data.Pass.Class
  ( Passable(..)
  ) where

import Data.Binary
import Data.Monoid
import Data.Typeable
import Data.Pass.Type
import Data.Pass.Eval
import Data.Pass.Fun
import Data.Pass.Thrist
import Data.Pass.Trans

class Passable t where
  pass :: (Eval k, Typeable b, Binary b, Monoid b) => t k a b -> Pass k a b

instance Passable Fun where
  pass (Fun k) = trans k

instance Passable Thrist where
  pass = Pass id

instance Passable Pass where
  pass = id
