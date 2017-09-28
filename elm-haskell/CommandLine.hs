{%- set app_module_names = ["VersionInfo"] | to_app_module_names -%}
{%- set other_module_names = [paths_module_name, "Data.Monoid", "Network.Wai.Handler.Warp", "Options.Applicative"] -%}
{{hs_copyright}}
module {{module_name}}App.CommandLine
    ( Command (..)
    , parseCommand
    ) where

{% for m in (app_module_names + other_module_names | sort) -%}
import           {{m}}
{% endfor %}
data Command =
    RunCommand Port
    | VersionCommand

portP :: Parser Port
portP = option auto
    (long "port"
    <> short 'p'
    <> value 8081
    <> metavar "PORT"
    <> help "Port")

runCommandP :: Parser Command
runCommandP = RunCommand <$> portP

versionCommandP :: Parser Command
versionCommandP = flag' VersionCommand (short 'v' <> long "version" <> help "Show version")

commandP :: Parser Command
commandP = runCommandP <|> versionCommandP

parseCommand :: IO Command
parseCommand = execParser $ info
    (helper <*> commandP)
    (fullDesc <> progDesc "Run {{project_name}}-app" <> header ("{{project_name}}-app " ++ fullVersionString version))
