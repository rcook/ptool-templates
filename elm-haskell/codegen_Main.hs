--------------------------------------------------
-- Copyright (C) 2017, All rights reserved.
--------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import           Control.Monad
import           Data.Proxy (Proxy (..))
import qualified Data.Text as Text
import qualified Data.Text.IO as Text
import           Elm (toElmDecoderSource, toElmEncoderSource, toElmTypeSource)
import           {{module_name}}Codegen.CommandLine
import           {{module_name}}.API
import           {{module_name}}.Types
import           {{module_name}}.VersionInfo
import           {{paths_module_name}}
import           Servant.Elm
    ( ElmOptions (..)
    , UrlPrefix (..)
    , defElmImports
    , defElmOptions
    , generateElmForAPIWith
    )
import           System.IO

elmOpts :: ElmOptions
elmOpts = defElmOptions
    { urlPrefix = Dynamic }

main :: IO ()
main = parseCommand >>= handleCommand
    where
        handleCommand (RunCommand outputPath moduleName) = do
            let sourceLines =
                    (defElmImports
                    : toElmTypeSource (Proxy :: Proxy User)
                    : toElmDecoderSource (Proxy :: Proxy User)
                    : toElmEncoderSource (Proxy :: Proxy User)
                    : generateElmForAPIWith elmOpts (Proxy :: Proxy UserAPI))

            withFile outputPath WriteMode $ \h -> do
                let w = Text.hPutStrLn h
                w "-- Generated code"
                w $ Text.concat ["module ", moduleName, " exposing (User, getAlbert, getIsaac, getUsers)"]
                w ""
                w "import Date exposing (Date)"
                w "import {{module_name}}.Decode exposing (decodeDate)"
                w ""
                forM_ sourceLines $ \l -> w l >> w ""
        handleCommand VersionCommand = putStrLn $ "{{project_name}}-codegen " ++ fullVersionString version
