{%-
    set imported_module_names =
        (["Types"] | map("child_module_name") | list) +
        ["Servant.API"]
-%}
{{hs_copyright}}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module {{module_name}}.API (API) where

{% for m in imported_module_names | sort -%}
import           {{m}}
{% endfor %}
type API =
    "users" :> Get '[JSON] [User]
    :<|> "albert" :> Get '[JSON] User
    :<|> "isaac" :> Get '[JSON] User
    :<|> "widgets" :> Get '[JSON] [Widget]

