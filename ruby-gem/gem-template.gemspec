lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require '{{project_name}}/gem_info'

Gem::Specification.new do |s|
  s.name = '{{project_name}}'
  s.version = {{ project_name | underscore | camelize }}::GemInfo.version_string
  s.date = Date.today rescue '1970-01-01'
  s.executables << '{{project_name}}'
  s.summary = '{{project_name}}'
  s.description = 'Simple Ruby gem template'
  s.license = 'MIT'
  s.authors = '{{author}}'
  s.email = '{{author_email}}'
  s.files = ['LICENSE'] + Dir.glob('lib/**/*.rb')
  s.require_paths = ['lib']
  s.homepage = 'https://github.com/{{ git_server | git_group }}/{{project_name}}'

  s.add_dependency 'rclopts', '~> 0.1.1'
end
