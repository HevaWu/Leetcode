#include <iostream>
#include <iomanip>
#include <string>
#include <memory>
#include <unordered_map>

using namespace std;

int main()
{
	unordered_map<string, string> stringmap;
	unordered_map<string, string> string1({ { "apple","red" }, { "orange", "orange" },
	{ "lemon" , "yellow" } });
	stringmap = string1;
	cout << "contains: ";
	for (auto& x : string1) cout << " " << x.first << ":" << x.second;

	cout << endl;
	unordered_map<string, string> stringmap1(string1.begin(), string1.end());
	cout << "contains2: ";
	for (auto& x : stringmap1) cout << " " << x.first << ":" << x.second;

	std::unordered_map<std::string, double>
		myrecipe,
		mypantry = { { "milk",2.0 },{ "flour",1.5 } };

	std::pair<std::string, double> myshopping("baking powder", 0.3);

	myrecipe.insert(myshopping);                        // copy insertion
	myrecipe.insert(std::make_pair<std::string, double>("eggs", 6.0)); // move insertion
	myrecipe.insert(mypantry.begin(), mypantry.end());  // range insertion
	myrecipe.insert({ { "sugar",0.8 },{ "salt",0.1 } });    // initializer list insertion
	myrecipe["ti"] = 0.5;

	std::cout << "myrecipe contains:" << std::endl;
	for (auto& x : myrecipe)
		std::cout << x.first << ": " << x.second << std::endl;

	std::cout << std::endl;


	return 0;
}