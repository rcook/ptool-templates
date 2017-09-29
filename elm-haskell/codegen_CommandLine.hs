{%- set lib_module_names = ["VersionInfo"] | to_lib_module_names -%}
{%- set other_module_names = [
        paths_module_name,
        "Data.Monoid",
        "Data.Text (Text)",
        "Options.Applicative",
        "Options.Applicative.Text"
    ] -%}
{{hs_copyright}}
module {{module_name}}Codegen.CommandLine
    ( Command (..)
    , parseCommand
    ) where

{% for m in (lib_module_names + other_module_names) | sort -%}
import           {{m}}
{% endfor %}
data Command =
    RunCommand FilePath Text
    | VersionCommand

outputPathP :: Parser FilePath
outputPathP = argument str (metavar "OUTPUTPATH")

moduleNameP :: Parser Text
moduleNameP = argument text (metavar "MODULENAME")

runCommandP :: Parser Command
runCommandP = RunCommand
    <$> outputPathP
    <*> moduleNameP

versionCommandP :: Parser Command
versionCommandP = flag' VersionCommand (short 'v' <> long "version" <> help "Show version")

commandP :: Parser Command
commandP = runCommandP <|> versionCommandP

parseCommand :: IO Command
parseCommand = execParser $ info
    (helper <*> commandP)
    (fullDesc <> progDesc "Run {{project_name}}-app" <> header ("{{project_name}}-app " ++ fullVersionString version))
