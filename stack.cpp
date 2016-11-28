#include <iostream>
#include <iomanip>
#include <string>
#include <memory>
#include <unordered_map>
#include <functional>
#include <numeric>  //partial_sum
#include <stack> //stack

using namespace std;

int main()
{
	stack<string> mystack;
	
	mystack.emplace("First sentence");  //emplace, add the new element at the top of the stack
	mystack.emplace("Second sentence"); //push, insert the new element at the top of the stack, above its current top element
	mystack.push("Third sentence");
	mystack.push("Fourth sentence");
	mystack.emplace("Fifth sentence");

	while (!mystack.empty())
	{
		cout << mystack.top() << endl;
		mystack.pop();
	}

	return 0;
}

