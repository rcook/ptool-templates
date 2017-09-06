#include "scratchlib/Example.h"
#include <catch.hpp>

using namespace scratchlib;

TEST_CASE("Example", "[example]")
{
    REQUIRE(Example("hello").name() == "hello");
}
