{{ruby_copyright}}
module {{ project_name | underscore | camelize }}
  class Foo
    attr_reader :value

    def initialize(value)
      @value = value
    end
  end
end
