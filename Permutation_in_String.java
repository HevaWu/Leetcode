/*
Given two strings s1 and s2, return true if s2 contains a permutation of s1, or false otherwise.

In other words, return true if one of s1's permutations is the substring of s2.



Example 1:

Input: s1 = "ab", s2 = "eidbaooo"
Output: true
Explanation: s2 contains one permutation of s1 ("ba").
Example 2:

Input: s1 = "ab", s2 = "eidboaoo"
Output: false


Constraints:

1 <= s1.length, s2.length <= 104
s1 and s2 consist of lowercase English letters.
*/

/*
Solution 2:
Optimize solution 1
when track s2, keep window
then check if window is same as freq

Time Complexity: O(n1 + n2)
Space Complexity: O(26)
*/
class Solution {
    public boolean checkInclusion(String s1, String s2) {
        int[] freq1 = new int[26];
        int size = s1.length();
        for(int i = 0; i < size; i++) {
            freq1[s1.charAt(i)-'a'] += 1;
        }

        int[] freq2 = new int[26];
        for(int i = 0; i < s2.length(); i++) {
            freq2[s2.charAt(i)-'a'] += 1;
            int start = i-size;
            if (start >= 0) {
                freq2[s2.charAt(start)-'a'] -= 1;
            }

            int j = 0;
            while (j < 26 && freq1[j] == freq2[j]) {
                j += 1;
            }
            if(j == 26) {
                return true;
            }
        }
        return false;
    }
}
