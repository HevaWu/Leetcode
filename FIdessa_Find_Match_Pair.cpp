#include <iostream>
#include <string>
#include <stack>

using namespace std;

int findMatchingPair(const string& input) {
    stack<char> s;
    if(input.length() == 0)
        return -1;
    if(input[0] >= 'a' && input[0] <= 'z' )
        return -1;
   // int i = 0;
    int index = -1;
    for(int i = 0; i < input.length(); i++){
    	if(input[i] >= 'A' && input[i] <= 'Z') {
            s.push(input[i]);
        } else {
            if(s.empty()) {
                return index;
            }
            char c = s.top();
            if(input[i] - 32 != c) {
                return index;
            } else {
                index = i;
                s.pop();
            }
        }
    }
    /*
    while(i < input.length()) {
        if(input[i] >= 'A' && input[i] <= 'Z') {
            s.push(input[i]);
        } else {
            if(s.empty()) {
                return index;
            }
            char c = s.top();
            if(input[i] - 32 != c) {
                return index;
            } else {
                index = i;
                s.pop();
            }
        }
        i++;
    }
    */
    return index;
}

int main(){
	string s = "AaBbcCD";
	int a = findMatchingPair(s);
	cout << a << endl;
}
