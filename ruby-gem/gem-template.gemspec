lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'gem-template/gem_info'

Gem::Specification.new do |s|
  s.name = 'gem-template'
  s.version = GemTemplate::GemInfo.version_string
  s.date = Date.today rescue '1970-01-01'
  s.executables << 'gem-template'
  s.summary = 'gem-template'
  s.description = 'Simple Ruby gem template'
  s.license = 'MIT'
  s.authors = 'Richard Cook'
  s.email = 'rcook@rcook.org'
  s.files = ['LICENSE'] + Dir.glob('lib/**/*.rb')
  s.require_paths = ['lib']
  s.homepage = 'https://github.com/rcook/gem-template/'

  s.add_dependency 'rclopts', '~> 0.1.1'
end

