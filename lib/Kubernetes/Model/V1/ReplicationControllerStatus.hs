-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a MIT license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.ReplicationControllerStatus
    ( ReplicationControllerStatus (..)
    , replicas
    , observedGeneration
    , mkReplicationControllerStatus
    ) where

import           Control.Lens.TH           (makeLenses)
import           Data.Aeson.TH             (defaultOptions, deriveJSON,
                                            fieldLabelModifier)
import           GHC.Generics              (Generic)
import           Prelude                   hiding (drop, error, max, min)
import qualified Prelude                   as P
import           Test.QuickCheck           (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances ()

-- | ReplicationControllerStatus represents the current status of a replication controller.
data ReplicationControllerStatus = ReplicationControllerStatus
    { _replicas           :: !(Integer)
    , _observedGeneration :: !(Maybe Integer)
    } deriving (Show, Eq, Generic)

makeLenses ''ReplicationControllerStatus

$(deriveJSON defaultOptions{fieldLabelModifier = (\n -> if n == "_type_" then "type" else P.drop 1 n)} ''ReplicationControllerStatus)

instance Arbitrary ReplicationControllerStatus where
    arbitrary = ReplicationControllerStatus <$> arbitrary <*> arbitrary

-- | Use this method to build a ReplicationControllerStatus
mkReplicationControllerStatus :: Integer -> ReplicationControllerStatus
mkReplicationControllerStatus xreplicasx = ReplicationControllerStatus xreplicasx Nothing
