--------------------------------------------------
-- Copyright (C) 2017, All rights reserved.
--------------------------------------------------

module HelloWorldCodegen.CommandLine
    ( Command (..)
    , parseCommand
    ) where

import           Data.Monoid
import           Data.Text (Text)
import           HelloWorld.VersionInfo
import           Options.Applicative
import           Options.Applicative.Text
import           Paths_hello_world

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
    (fullDesc <> progDesc "Run hello-world-app" <> header ("hello-world-app " ++ fullVersionString version))
