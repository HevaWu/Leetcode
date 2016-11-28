/*
Given two binary strings, return their sum (also a binary string).

For example,
a = "11"
b = "1"
Return "100".
*/

class Solution {
public:
    string addBinary(string a, string b) {
        string s = ""; //new string for storing the return string
        int c = 0, i = a.size()-1, j = b.size()-1;
        while(c==1 || i>=0 || j>=0)
        {
            c += i>=0 ? a[i--]-'0' : 0; //remember -'0', need to transfer char to int
            c += j>=0 ? b[j--]-'0' : 0;
            s = static_cast<char>(c%2 + '0') + s;
            c /= 2;
        }
        return s;
    }
};