{%- set lib_module_names = ["Types"] | to_lib_module_names -%}
{%- set other_module_names = ["Servant.API"] -%}
{{hs_copyright}}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module {{module_name}}.API (UserAPI) where

{% for m in (lib_module_names + other_module_names) | sort -%}
import           {{m}}
{% endfor %}
type UserAPI =
    "users" :> Get '[JSON] [User]
    :<|> "albert" :> Get '[JSON] User
    :<|> "isaac" :> Get '[JSON] User
