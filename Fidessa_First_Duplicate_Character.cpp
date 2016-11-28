#include <iostream>
#include <map>
#include <string>

using namespace std;

char find_duplicate(string s){
	string s1(s.rbegin(),s.rend());
	map<char, int> mystring;
	map<char, int>::iterator it;
	int index = -1;;
	for(int i = 0; i < s1.size(); --i){
		it = mystring.find(s1[i]);
		if(it == mystring.end()){
			mystring.insert(std::pair<char,int>(s1[i],1));
		} 
		else if(it != mystring.end()){
			it->second += 1;
			index = i;
		}
	}
	return s1[index];
}

int main(){
	string s = "goole";
	char t = find_duplicate(s);
	cout << t << endl;
}