-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a BSD license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.ConfigMap
    ( ConfigMap (..)
    , kind
    , apiVersion
    , metadata
    , data_
    ) where

import           Control.Lens.TH (makeLenses)
import           Data.Aeson.TH (deriveJSON, defaultOptions, fieldLabelModifier)
import           Data.Text (Text)
import           GHC.Generics (Generic)
import           Prelude hiding (drop, error, max, min)
import qualified Prelude as P
import           Test.QuickCheck (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances ()
import           Kubernetes.Model.V1.Any (Any)
import           Kubernetes.Model.V1.ObjectMeta (ObjectMeta)

-- | ConfigMap holds configuration data for pods to consume.
data ConfigMap = ConfigMap
    { _kind :: Maybe Text
    , _apiVersion :: Maybe Text
    , _metadata :: Maybe ObjectMeta
    , _data_ :: Maybe Any
    } deriving (Show, Eq, Generic)

makeLenses ''ConfigMap

$(deriveJSON defaultOptions{fieldLabelModifier = P.drop 1} ''ConfigMap)

instance Arbitrary ConfigMap where
    arbitrary = ConfigMap <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary