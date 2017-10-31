if RUBY_VERSION < '1.9.0'
  require File.expand_path('../{{project_name}}/cli', __FILE__)
  require File.expand_path('../{{project_name}}/gem_info', __FILE__)
else
  require_relative '{{project_name}}/cli'
  require_relative '{{project_name}}/gem_info'
end
