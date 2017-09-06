$cpp_copyright

#include "${project_name}lib/Example.h"
#include <iostream>

using namespace ${project_name}lib;
using namespace std;

int main()
{
    Example e("name");
    cout << e.name() << endl;
}
