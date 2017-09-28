{%- set app_module_names = ["App", "CommandLine", "Util", "VersionInfo"] | to_app_module_names -%}
{%- set other_module_names = [paths_module_name, module_name, "Network.Wai.Handler.Warp", "Network.Wai.Logger"] -%}
{{hs_copyright}}
module Main (main) where

{% for m in (app_module_names + other_module_names | sort) -%}
import           {{m}}
{% endfor %}
main :: IO ()
main = parseCommand >>= handleCommand
    where
        handleCommand (RunCommand port) = withStdoutLogger $ \logger -> do
            let settings = setPort port $ setLogger logger defaultSettings
            putStrLn "Hello from {{module_name}}.main"
            putStrLn $ "Listening on port " ++ show port
            sample
            runSettings settings (apiCors app)
        handleCommand VersionCommand = putStrLn $ "{{project_name}}-app " ++ fullVersionString version