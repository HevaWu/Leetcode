/*
Implement strStr().

Returns the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.
*/

class Solution {
public:
    int strStr(string haystack, string needle) {
        int m = haystack.length(), n = needle.length();
        if(!n) return 0; //do not forget this situation 
        for(int i = 0; i < m-n+1; i++){
            int j = 0;
            for(; j < n; j++){
                if(haystack[i+j] != needle[j]) break;
            if(j == n-1) return i;
            }
        }
        return -1; //if needle is not part of haystack
    }
};