{{hs_copyright}}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}

module {{module_name}}.Types
    ( User (..)
    , Widget (..)
    ) where

import           Data.Aeson
import           Data.Time.Calendar
import           Elm
import           GHC.Generics

data User = User
    { name :: String
    , age :: Int
    , email :: String
    , registrationDate :: Day
    } deriving (ElmType, Eq, Show, Generic)

instance ToJSON User

data Widget = Widget
    { name :: String
    , description :: String
    } deriving (ElmType, Eq, Show, Generic)

instance ToJSON Widget

