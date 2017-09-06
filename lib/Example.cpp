#include "scratchlib/Example.h"

using namespace scratchlib;
using namespace std;

Example::Example(const string& name) : _name(name) { }

Example::~Example() = default;

const string& Example::name() const
{
    return _name;
}
