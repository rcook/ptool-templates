{%- set app_module_names = ["App", "CommandLine", "VersionInfo"] | to_app_module_names -%}
{%- set other_module_names = [paths_module_name, module_name, "Network.Wai.Handler.Warp"] -%}
{{hs_copyright}}
module Main (main) where

{% for m in (app_module_names + other_module_names | sort) -%}
import           {{m}}
{% endfor %}
main :: IO ()
main = parseCommand >>= handleCommand
    where
        handleCommand (RunCommand port) = do
            putStrLn "Hello from {{module_name}}.main"
            putStrLn $ "Listening on port " ++ show port
            sample
            run port app
        handleCommand VersionCommand = putStrLn $ "{{project_name}}-app " ++ fullVersionString version
