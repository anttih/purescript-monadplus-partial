module Control.MonadPlus.Partial where

import Prelude (liftM1, (<<<), not, return, bind, map, (>>=))
import Control.Alt (alt)
import Control.MonadPlus (class MonadPlus)
import Control.Plus (empty)
import Data.Foldable (foldr)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), maybe)
import Data.Tuple (Tuple(Tuple))

mfromMaybe :: forall m a. (MonadPlus m) => Maybe a -> m a
mfromMaybe = maybe empty return

mreturn :: forall m a b. (MonadPlus m) => (a -> Maybe b) -> a -> m b
mreturn f = mfromMaybe <<< f

mcatMaybes :: forall m a. (MonadPlus m) => m (Maybe a) -> m a
mcatMaybes m = m >>= mfromMaybe

msum :: forall m a. (MonadPlus m) => Array (m a) -> m a
msum = foldr alt empty

mfromList :: forall m a. (MonadPlus m) => Array a -> m a
mfromList = msum <<< map return

mfilter :: forall m a. (MonadPlus m) => (a -> Boolean) -> m a -> m a
mfilter f m = do
  x <- m
  if f x then return x else empty

mpartition :: forall m a. (MonadPlus m) => (a -> Boolean) -> m a -> Tuple (m a) (m a)
mpartition f m = Tuple (mfilter f m) (mfilter (not <<< f) m)

mmapMaybe :: forall m a b. (MonadPlus m) => (a -> Maybe b) -> m a -> m b
mmapMaybe f = mcatMaybes <<< liftM1 f

mlefts :: forall m a b. (MonadPlus m) => m (Either a b) -> m a
mlefts = mcatMaybes <<< liftM1 l
  where
  l (Left a)  = Just a
  l (Right _) = Nothing

mrights :: forall m a b. (MonadPlus m) => m (Either a b) -> m b
mrights = mcatMaybes <<< liftM1 r
  where
  r (Left _)  = Nothing
  r (Right a) = Just a

mpartitionEithers :: forall m a b. (MonadPlus m) => m (Either a b) -> Tuple (m a) (m b)
mpartitionEithers a = Tuple (mlefts a) (mrights a)

