{{hs_copyright}}
{-# LANGUAGE OverloadedStrings #-}

module {{module_name}}App.Util (apiCors) where

import           Network.Wai
import           Network.Wai.Middleware.Cors

apiCors :: Middleware
apiCors = cors $ const (Just apiResourcePolicy)
    where apiResourcePolicy = simpleCorsResourcePolicy
                                { corsRequestHeaders = "Authorization" : simpleHeaders
                                }