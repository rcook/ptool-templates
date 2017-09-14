$cpp_copyright
#pragma once

#include <string>

namespace ${namespace}lib {

class Example final
{
public:
    Example() = delete;
    Example(const Example&) = delete;
    Example& operator=(const Example&) = delete;

public:
    Example(const std::string& name);
    ~Example();
    const std::string& name() const;

private:
    const std::string _name;
};

}
