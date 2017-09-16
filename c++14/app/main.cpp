$cpp_copyright
#include "${project_name}lib/Example.h"
#include <iostream>

using namespace ${cpp_namespace}lib;
using namespace std;

int main()
{
    Example e("name");
    cout << e.name() << endl;
}
