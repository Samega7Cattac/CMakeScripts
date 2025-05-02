#include <iostream>

#include <lib/hello_lib.hpp>

int
main()
{
    std::cout << CPPLIB::GetMessage() << std::endl;
    return 0;
}
