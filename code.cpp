#include <iostream>
using namespace std;

// This file is made for testing purpose.


// Problematic function
int function2(int id, char* name, int rollNumber, int age)
{
	cout << "In function 2.\n";
        return 0;
}


// This function should not throw any warning
int function1(int id, char*  name)
{
	cout << "In function 1.\n";
	return 1;
}

int main()
{
	cout << "Hello World.\n";        // prints Hello World

	function1(1, "James Bond");

	function2(2, "Joe", 1234, 25);

	return 0;
}
