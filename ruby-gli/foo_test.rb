{{ruby_copyright}}
if RUBY_VERSION < '1.9.0'
  require File.expand_path('../test_helper', __FILE__)
else
  require_relative 'test_helper'
end

module {{ project_name | underscore | camelize }}Test
  class FooTest < Test::Unit::TestCase
    def test_value
      assert_equal 'abc', Testapp::Foo.new('abc').value
    end
  end
end
