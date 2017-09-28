{{hs_copyright}}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# OPTIONS_GHC -fno-warn-unused-top-binds #-}

module Main (main) where

{% for m in [module_name, "Data.Time (UTCTime)", "Servant.API"] | sort -%}
import           {{m}}
{% endfor %}
type UserAPI = "users" :> QueryParam "sortby" SortBy :> Get '[JSON] [User]

data SortBy = Age | Name

data User = User
    { name :: String
    , age :: Int
    , email :: String
    , registration_date :: UTCTime
    }

main :: IO ()
main = do
    putStrLn "Hello from {{module_name}}.main"
    sample
