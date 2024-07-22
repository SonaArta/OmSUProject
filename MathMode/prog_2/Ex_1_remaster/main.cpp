#include "tasks.hxx"
#include "shooting_method.hxx"
#include "all.hxx"

int main()
{
    int number;

    std::cout << "Enter number tasks : ";
    std::cin >> number;

    TASKS::run(number);

    std::cout << std::endl;

    std::cout << "Complited" << std::endl;

    return 0;
}




