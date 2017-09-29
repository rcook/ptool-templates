{%-
    set imported_module_names =
        (["VersionInfo"] | map("child_module_name") | list) +
        (["App", "CommandLine", "Types", "Util"] | map("child_module_name", "App") | list) +
        [module_name, paths_module_name, "Control.Monad", "Network.Wai.Handler.Warp", "Network.Wai.Logger"]
-%}
{{hs_copyright}}
module Main (main) where

{% for m in imported_module_names | sort -%}
import           {{m}}
{% endfor %}
main :: IO ()
main = parseCommand >>= handleCommand
    where
        handleCommand (RunCommand port delay@(Milliseconds ms)) = withStdoutLogger $ \logger -> do
            let settings = setPort port $ setLogger logger defaultSettings
            putStrLn "Hello from {{module_name}}.main"
            putStrLn $ "Port : " ++ show port
            when (ms > 0) $ putStrLn $ "Delay: " ++ show ms ++ " ms"
            sample
            runSettings settings (apiCors app)
            runSettings settings (delayMiddleware delay $ apiCorsMiddleware app)
        handleCommand VersionCommand = putStrLn $ "{{project_name}}-app " ++ fullVersionString version
