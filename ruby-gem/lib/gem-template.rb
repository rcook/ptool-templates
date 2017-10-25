if RUBY_VERSION < '1.9.0'
  require File.expand_path('../gem-template/cli', __FILE__)
  require File.expand_path('../gem-template/gem_info', __FILE__)
else
  require_relative 'gem-template/cli'
  require_relative 'gem-template/gem_info'
end

