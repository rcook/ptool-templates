{{ruby_copyright}}
if RUBY_VERSION < '1.9.0'
  require File.expand_path('../{{project_name}}/foo', __FILE__)
  require File.expand_path('../{{project_name}}/gem_info', __FILE__)
  require File.expand_path('../{{project_name}}/to_do_list', __FILE__)
else
  require_relative '{{project_name}}/foo'
  require_relative '{{project_name}}/gem_info'
  require_relative '{{project_name}}/to_do_list'
end
