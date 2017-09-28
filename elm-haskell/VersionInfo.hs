{{hs_copyright}}
{-# LANGUAGE TemplateHaskell #-}

module {{module_name}}App.VersionInfo (fullVersionString) where

import           Data.Version
import           Distribution.VcsRevision.Git
import           Language.Haskell.TH.Syntax

gitVersionString :: String
gitVersionString = $(do
    v <- qRunIO getRevision
    lift $ case v of
        Nothing -> []
        Just (commit, True)  -> commit ++ " (locally modified)"
        Just (commit, False) -> commit)

fullVersionString :: Version -> String
fullVersionString version = case gitVersionString of
    [] -> showVersion version
    v -> showVersion version ++ "." ++ v