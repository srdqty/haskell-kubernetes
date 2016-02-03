-- Copyright (c) 2016-present, SoundCloud Ltd.
-- All rights reserved.
--
-- This source code is distributed under the terms of a BSD license,
-- found in the LICENSE file.

{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TemplateHaskell            #-}

module Kubernetes.Model.V1.Container
    ( Container (..)
    , name
    , image
    , command
    , args
    , workingDir
    , ports
    , env
    , resources
    , volumeMounts
    , livenessProbe
    , readinessProbe
    , lifecycle
    , terminationMessagePath
    , imagePullPolicy
    , securityContext
    , stdin
    , stdinOnce
    , tty
    ) where

import           Control.Lens.TH (makeLenses)
import           Data.Aeson.TH (deriveJSON, defaultOptions, fieldLabelModifier)
import           Data.Text (Text)
import           GHC.Generics (Generic)
import           Prelude hiding (drop, error, max, min)
import qualified Prelude as P
import           Test.QuickCheck (Arbitrary, arbitrary)
import           Test.QuickCheck.Instances ()
import           Kubernetes.Model.V1.ContainerPort (ContainerPort)
import           Kubernetes.Model.V1.EnvVar (EnvVar)
import           Kubernetes.Model.V1.Lifecycle (Lifecycle)
import           Kubernetes.Model.V1.Probe (Probe)
import           Kubernetes.Model.V1.ResourceRequirements (ResourceRequirements)
import           Kubernetes.Model.V1.SecurityContext (SecurityContext)
import           Kubernetes.Model.V1.VolumeMount (VolumeMount)

-- | A single application container that you want to run within a pod.
data Container = Container
    { _name :: Text
    , _image :: Maybe Text
    , _command :: Maybe [Text]
    , _args :: Maybe [Text]
    , _workingDir :: Maybe Text
    , _ports :: Maybe [ContainerPort]
    , _env :: Maybe [EnvVar]
    , _resources :: Maybe ResourceRequirements
    , _volumeMounts :: Maybe [VolumeMount]
    , _livenessProbe :: Maybe Probe
    , _readinessProbe :: Maybe Probe
    , _lifecycle :: Maybe Lifecycle
    , _terminationMessagePath :: Maybe Text
    , _imagePullPolicy :: Maybe Text
    , _securityContext :: Maybe SecurityContext
    , _stdin :: Maybe Bool
    , _stdinOnce :: Maybe Bool
    , _tty :: Maybe Bool
    } deriving (Show, Eq, Generic)

makeLenses ''Container

$(deriveJSON defaultOptions{fieldLabelModifier = P.drop 1} ''Container)

instance Arbitrary Container where
    arbitrary = Container <$> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary <*> arbitrary