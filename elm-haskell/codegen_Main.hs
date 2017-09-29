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
import           HelloWorldCodegen.CommandLine
import           HelloWorld.API
import           HelloWorld.Types
import           HelloWorld.VersionInfo
import           Paths_hello_world
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
                w "import HelloWorld.Decode exposing (decodeDate)"
                w ""
                forM_ sourceLines $ \l -> w l >> w ""
        handleCommand VersionCommand = putStrLn $ "hello-world-codegen " ++ fullVersionString version
