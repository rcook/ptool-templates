{%- set lib_module_names = ["API", "Types"] | to_lib_module_names -%}
{%- set other_module_names = ["Data.Time.Calendar", "Servant"] -%}
{{hs_copyright}}
module {{module_name}}App.App (app) where

{% for m in (lib_module_names + other_module_names) | sort -%}
import           {{m}}
{% endfor %}
isaac :: User
isaac = User "Isaac Newton" 372 "isaac@newton.co.uk" (fromGregorian 1683 3 1)

albert :: User
albert = User "Albert Einstein" 136 "ae@mc2.org" (fromGregorian 1905 12 1)

userAPIServer :: Server UserAPI
userAPIServer = return [isaac, albert]
     :<|> return albert
     :<|> return isaac

userAPIProxy :: Proxy UserAPI
userAPIProxy = Proxy

app :: Application
app = serve userAPIProxy userAPIServer

