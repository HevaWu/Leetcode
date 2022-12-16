/*
Given an array of integers arr, return true if the number of occurrences of each value in the array is unique, or false otherwise.



Example 1:

Input: arr = [1,2,2,1,1,3]
Output: true
Explanation: The value 1 has 3 occurrences, 2 has 2 and 3 has 1. No two values have the same number of occurrences.
Example 2:

Input: arr = [1,2]
Output: false
Example 3:

Input: arr = [-3,0,1,-3,1,1,1,-3,10,0]
Output: true


Constraints:

1 <= arr.length <= 1000
-1000 <= arr[i] <= 1000
*/

/*
Solution 1:
build occurance map
then check if map.values is unique array

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
public:
    bool uniqueOccurrences(vector<int>& arr) {
        unordered_map<int, int> occur;
        for(int i = 0; i < arr.size(); i++) {
            occur[arr[i]] += 1;
        }

        unordered_set<int> valueSet;
        for(auto &it : occur) {
            if(valueSet.find(it.second) != valueSet.end()) {
                return false;
            }
            valueSet.insert(it.second);
        }
        return true;
    }
};