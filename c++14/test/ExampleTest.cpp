$cpp_copyright
#include "${project_name}lib/Example.h"
#include <catch.hpp>

using namespace ${project_namespace}lib;

TEST_CASE("Example", "[example]")
{
    REQUIRE(Example("hello").name() == "hello");
}
