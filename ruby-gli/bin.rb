#!/usr/bin/env ruby
{{ruby_copyright}}
require 'gli'
require '{{project_name}}'

include GLI::App

program_desc 'Sample application'

desc 'To-do list file name'
flag [:f, :file], default_value: File.join(ENV['HOME'],'.{{project_name}}')

pre do |global_options, command, options, args|
  $to_do_list = {{ project_name | underscore | camelize }}::ToDoList.new(global_options[:file])
end

desc 'Add to-do item'
arg :text
command :add do |c|
  c.action do |global_options, options, args|
    help_now! 'Specify exactly one argument' if args.count != 1
    text = args.shift
    $to_do_list.add_item(text)
  end
end

desc 'List to-do items'
command :list do |c|
  c.action do |global_options, options, args|
    help_now! 'Command takes no arguments' if args.count != 0
    $to_do_list.items.each do |item|
      printf("%5d - %s\n", item.id, item.text)
    end
  end
end

desc 'Mark to-do item as done'
command :done do |c|
  c.action do |global_options, options, args|
    help_now! 'Specify exactly one argument' if args.count != 1
    id = args.shift.to_i
    $to_do_list.items.each do |item|
      $to_do_list.mark_done(item) if item.id == id
    end
  end
end

exit run(ARGV)
