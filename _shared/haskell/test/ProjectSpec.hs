{{hs_copyright}}
module {{module_name}}Spec (spec) where

{% for m in [module_name, "Test.Hspec"] | sort -%}
import           {{m}}
{% endfor %}
spec :: Spec
spec = do
    describe "sample" $
        it "runs" $ sample
