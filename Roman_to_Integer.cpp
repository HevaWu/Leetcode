/*
Given a roman numeral, convert it to an integer.

Input is guaranteed to be within the range from 1 to 3999.
*/

class Solution {
public:
    int romanToInt(string s) {
        
        unordered_map<char, int> M = { //build an unordered map to map the roman number
            {'I', 1},
            {'V', 5},
            {'X', 10},
            {'L', 50},
            {'C', 100},
            {'D', 500},
            {'M', 1000}
        };
        
        int results = M[s.back()];
        for(int i = s.size()-2; i >= 0; --i){
            if(M[s[i]] < M[s[i+1]]) results -= M[s[i]];
            else results += M[s[i]];
        }
        return results;
    }
};