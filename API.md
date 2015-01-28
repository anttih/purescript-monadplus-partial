# Module Documentation

## Module Control.MonadPlus.Partial

### Values


    mcatMaybes :: forall m a. (MonadPlus m) => m (Maybe a) -> m a


    mfilter :: forall m a. (MonadPlus m) => (a -> Boolean) -> m a -> m a


    mfromList :: forall m a. (MonadPlus m) => [a] -> m a


    mfromMaybe :: forall m a. (MonadPlus m) => Maybe a -> m a


    mlefts :: forall m a b. (MonadPlus m) => m (Either a b) -> m a


    mmapMaybe :: forall m a b. (MonadPlus m) => (a -> Maybe b) -> m a -> m b


    mpartition :: forall m a. (MonadPlus m) => (a -> Boolean) -> m a -> Tuple (m a) (m a)


    mpartitionEithers :: forall m a b. (MonadPlus m) => m (Either a b) -> Tuple (m a) (m b)


    mreturn :: forall m a b. (MonadPlus m) => (a -> Maybe b) -> a -> m b


    mrights :: forall m a b. (MonadPlus m) => m (Either a b) -> m b


    msum :: forall m a. (MonadPlus m) => [m a] -> m a



