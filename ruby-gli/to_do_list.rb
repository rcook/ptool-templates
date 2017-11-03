{{ruby_copyright}}
require 'hacer'

module {{ project_name | underscore | camelize }}
  class ToDoItem
    attr_reader :impl

    def initialize(impl)
      @impl = impl
    end

    def id
      @impl.todo_id
    end

    def text
      @impl.text
    end
  end

  class ToDoList
    def initialize(path)
      @impl = Hacer::Todolist.new(path)
    end

    def add_item(text)
      ToDoItem.new(@impl.create(text))
    end

    def items
      @impl.list.map { |x| ToDoItem.new(x) }
    end

    def mark_done(item)
      @impl.complete(item.impl)
    end
  end
end
