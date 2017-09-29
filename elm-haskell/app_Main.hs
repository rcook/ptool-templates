{%-
    set imported_module_names =
        (["App", "CommandLine", "Util"] | map("child_module_name", "App") | list) +
        (["VersionInfo"] | map("child_module_name") | list) +
        [module_name, paths_module_name, "Network.Wai.Handler.Warp", "Network.Wai.Logger"]
-%}
{{hs_copyright}}
module Main (main) where

{% for m in imported_module_names | sort -%}
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