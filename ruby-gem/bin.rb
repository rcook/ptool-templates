#!/usr/env/bin ruby
{{ruby_copyright}}
require '{{project_name}}'

options, free_args = {{ project_name | underscore | camelize }}::Cli.new(ARGV).run
puts options.inspect
puts free_args.inspect
