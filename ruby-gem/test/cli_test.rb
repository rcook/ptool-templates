if RUBY_VERSION < '1.9.0'
  require File.expand_path('../test_helper', __FILE__)
else
  require_relative 'test_helper'
end

module GemTemplateTest
  class CliTest < Test::Unit::TestCase
    def test_args
      cli = GemTemplate::Cli.new(['first', 'second', 'third'])
      assert_equal ['first', 'second', 'third'], cli.args
    end

    def test_run
      cli = GemTemplate::Cli.new(['--test', 'TEST', 'free-arg0', 'free-arg1'])

      options = nil
      begin
        options, free_args = cli.run
      rescue Rclopts::RequiredArgOptionParser::RequiredArgOptionParserError => e
        $stderr.puts e.message
        exit 1
      end

      options, free_args = cli.run
      assert_equal 'TEST', options.test
      assert_equal ['free-arg0', 'free-arg1'], free_args
    end
  end
end

