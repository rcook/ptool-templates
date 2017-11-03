{{ruby_copyright}}
lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require '{{project_name}}/gem_info'

Gem::Specification.new do |spec|
  spec.name = '{{project_name}}'
  spec.version = {{ project_name | underscore | camelize }}::GemInfo.version_string
  spec.date = Date.today rescue '1970-01-01'
  spec.executables << '{{project_name}}'
  spec.summary = '{{project_name}}'
  spec.description = 'Simple Ruby gem template'
  spec.license = 'MIT'
  spec.authors = '{{author}}'
  spec.email = '{{author_email}}'
  spec.files = ['LICENSE'] + Dir.glob('lib/**/*.rb')
  spec.require_paths = ['lib']
  spec.homepage = 'https://github.com/{{ git_server | git_group }}/{{project_name}}'

  spec.add_runtime_dependency 'gli'
  spec.add_runtime_dependency 'hacer'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'test-unit'
end
