{%-
    set imported_module_names =
        (["API", "Types"] | map("child_module_name") | list) +
        ["Data.Time.Calendar", "Servant"]
-%}
{{hs_copyright}}
module {{module_name}}App.App (app) where

{% for m in imported_module_names | sort -%}
import           {{m}}
{% endfor %}
isaac :: User
isaac = User "Isaac Newton" 372 "isaac@newton.co.uk" (fromGregorian 1683 3 1)

albert :: User
albert = User "Albert Einstein" 136 "ae@mc2.org" (fromGregorian 1905 12 1)

discombobulator :: Widget
discombobulator = Widget "Discombobulator" "Discombobulates according to system settings"

frobber :: Widget
frobber = Widget "Frobber" "Frobs on demand"

apiServer :: Server API
apiServer = return [isaac, albert]
     :<|> return albert
     :<|> return isaac
     :<|> return [discombobulator, frobber]

apiProxy :: Proxy API
apiProxy = Proxy

app :: Application
app = serve apiProxy apiServer

