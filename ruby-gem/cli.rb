{{ruby_copyright}}
require 'rclopts'

module {{ project_name | underscore | camelize }}
  class Cli
    attr_reader :args

    def initialize(args)
      @base_name = File.basename($0, File.extname($0))
      @args = args
    end

    def run
      option_parser = Rclopts::RequiredArgOptionParser.new do |p|
        p.banner = "Usage: #{@base_name} [options]"

        p.on_required('--test VALUE', 'Test') do |o, value|
          o.test = value
        end

        p.on_tail '-h', '--help', 'Show help' do
          puts p
          exit
        end

        p.on_tail '--version', 'Show version' do
          puts {{ project_name | underscore | camelize }}::GemInfo.version_string
          exit
        end
      end

      Rclopts::CliHelper.process_args(option_parser, @args)
    end
  end
end
