/*
Given a pattern and a string s, find if s follows the same pattern.

Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word in s.



Example 1:

Input: pattern = "abba", s = "dog cat cat dog"
Output: true
Example 2:

Input: pattern = "abba", s = "dog cat cat fish"
Output: false
Example 3:

Input: pattern = "aaaa", s = "dog cat cat dog"
Output: false


Constraints:

1 <= pattern.length <= 300
pattern contains only lower-case English letters.
1 <= s.length <= 3000
s contains only lowercase English letters and spaces ' '.
s does not contain any leading or trailing spaces.
All the words in s are separated by a single space.
*/
bool wordPattern(string pattern, string str) {
    int *a = new int[26]();
    unordered_map<string, int> m;

    int patternIdx = 0, startIndex = 0;

    if (str.length() && str[str.length() - 1] != ' ') {
        str += ' ';
    }  //find if the end of the string str is ' '

    for (int i = 0; i < str.length(); ++i) {
        if (patternIdx == pattern.length()) {
            return false;
        }

        if (str[i] == ' ') {
            string sub = str.substr(startIndex, i - startIndex);
            startIndex = ++i;  //need to change the position

            int aIdx = pattern[patternIdx] - 97;
            if (m.find(sub) == m.end()) { //find if there has been a bijection between pattern and str
                if (!a[aIdx]) {
                    m[sub] = pattern[patternIdx];
                    a[aIdx] = 1;
                } else {
                    return false;
                }
            } else if (m[sub] != pattern[patternIdx]){
                return false;
            }
            patternIdx++;
        }
    }
    return patternIdx == pattern.length();
}




class Solution {
public:
    bool wordPattern(string pattern, string str) {
        vector<int> apattern(26,0);
        unordered_map<string, int> sMap;
        int spos = 0;
        int aIdx1 = 0;

        if(str.length() && str[str.length()-1] != ' ')
            str += ' ';

        for(int i = 0; i < str.length(); ++i)
        {
            if(aIdx1 == pattern.length())
                return false;

            if(str[i] == ' ')
            {
                string nstr = str.substr(spos, i - spos);
                spos = ++i;

                int aIdx = pattern[aIdx1] - 97;
                if(sMap.find(nstr) == sMap.end())
                {
                    if(!apattern[aIdx])
                    {
                        sMap[nstr] = pattern[aIdx1];
                        apattern[aIdx] = 1;
                    }
                    else
                        return false;
                }
                else if(sMap[nstr] != pattern[aIdx1])
                    return false;

                aIdx1++;
            }
        }
        return (aIdx1 == pattern.length());
    }
};