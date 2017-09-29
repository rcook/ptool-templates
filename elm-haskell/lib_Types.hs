{{hs_copyright}}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}

module {{module_name}}.Types
    ( User (..)
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
