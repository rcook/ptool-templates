{{hs_copyright}}
{-# LANGUAGE DeriveGeneric #-}

module {{module_name}}App.Types
    ( User (..)
    ) where

import           Data.Aeson
import           Data.Time.Calendar
import           GHC.Generics

data User = User
    { name :: String
    , age :: Int
    , email :: String
    , registrationDate :: Day
    } deriving (Eq, Show, Generic)

instance ToJSON User
