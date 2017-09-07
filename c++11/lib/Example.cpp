$cpp_copyright

#include "${project_name}lib/Example.h"

using namespace ${namespace}lib;
using namespace std;

Example::Example(const string& name) : _name(name) { }

Example::~Example() = default;

const string& Example::name() const
{
    return _name;
}
