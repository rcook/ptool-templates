$hs_copyright
module ${hs_module_name}Spec (spec) where

import           $hs_module_name
import           Test.Hspec

spec :: Spec
spec = do
    describe "sample" $$
        it "runs" $$ sample
