/*
Given an array of strings strs, group the anagrams together. You can return the
answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a different
word or phrase, typically using all the original letters exactly once.



Example 1:

Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
Example 2:

Input: strs = [""]
Output: [[""]]
Example 3:

Input: strs = ["a"]
Output: [["a"]]


Constraints:

1 <= strs.length <= 104
0 <= strs[i].length <= 100
strs[i] consists of lower-case English letters.
*/

/*
Solution 1:
map
caterize by sorted string

Time Complexity: O(n*slogs)
- n is length of strs
- k is maximum length of a string in strs
Space Complexity: O(ns)
*/
class Solution {
 public:
  vector<vector<string>> groupAnagrams(vector<string>& strs) {
    unordered_map<string, vector<string>> anagram;
    for (int i = 0; i < strs.size(); i++) {
      string key = strs[i];
      sort(key.begin(), key.end());
      anagram[key].push_back(strs[i]);
    }

    vector<vector<string>> group;
    for (unordered_map<string, vector<string>>::iterator it = anagram.begin();
         it != anagram.end(); it++) {
      group.push_back(it->second);
    }
    return group;
  }
};
