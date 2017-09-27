{{hs_copyright}}
module {{project_module_name}}Spec (spec) where

{% for module in [project_module_name, "Test.Hspec"] | sort -%}
import           {{module}}
{% endfor %}
spec :: Spec
spec = do
    describe "sample" $
        it "runs" $ sample
