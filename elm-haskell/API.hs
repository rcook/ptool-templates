{%- set app_module_names = ["Types"] | to_app_module_names -%}
{%- set other_module_names = ["Servant.API"] -%}
{{hs_copyright}}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module {{module_name}}App.API (UserAPI) where

{% for m in (app_module_names + other_module_names | sort) -%}
import           {{m}}
{% endfor %}
type UserAPI =
    "users" :> Get '[JSON] [User]
    :<|> "albert" :> Get '[JSON] User
    :<|> "isaac" :> Get '[JSON] User
