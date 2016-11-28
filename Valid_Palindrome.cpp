#include <ctype.h> //toupper & isalnum

class Solution {
public:
    bool isPalindrome(string s) {
        for(int i = 0, j = s.size()-1; i < j; i++, j--)
        {
            while(!isalnum(s[i]) && (i<j)) i++;  //check if the character is alphanumeric
            while(!isalnum(s[j]) && (i<j)) j--;
            if(toupper(s[i]) != toupper(s[j])) return false;  //convert lowercase letter to uppercase
        }
        return true;
    }
};