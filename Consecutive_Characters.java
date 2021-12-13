/*
The power of the string is the maximum length of a non-empty substring that contains only one unique character.

Given a string s, return the power of s.



Example 1:

Input: s = "leetcode"
Output: 2
Explanation: The substring "ee" is of length 2 with the character 'e' only.
Example 2:

Input: s = "abbcccddddeeeeedcba"
Output: 5
Explanation: The substring "eeeee" is of length 5 with the character 'e' only.
Example 3:

Input: s = "triplepillooooow"
Output: 5
Example 4:

Input: s = "hooraaaaaaaaaaay"
Output: 11
Example 5:

Input: s = "tourist"
Output: 1


Constraints:

1 <= s.length <= 500
s consists of only lowercase English letters.
*/

/*
Solution 1:
iterate each character, check if current character is same as previous one or not, if same as previous, update current count
if not, update the max consecutive count, and reset count, pre characters
in the end, return the max(max consecutive count, current count)

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    public int maxPower(String s) {
        char pre = '*';
        int count = 0;
        int maxC = 0;
        for(int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == pre) {
                count += 1;
            } else {
                pre = s.charAt(i);
                maxC = Math.max(maxC, count);
                count = 1;
            }
        }
        return Math.max(maxC, count);
    }
}