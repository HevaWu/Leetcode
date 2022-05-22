/*
Given a string, your task is to count how many palindromic substrings in this string.

The substrings with different start indexes or end indexes are counted as different substrings even they consist of same characters.

Example 1:

Input: "abc"
Output: 3
Explanation: Three palindromic strings: "a", "b", "c".


Example 2:

Input: "aaa"
Output: 6
Explanation: Six palindromic strings: "a", "a", "a", "aa", "aa", "aaa".


Note:

The input string length won't exceed 1000.

*/

/*
Solution 3:
expand from center

- choose all possible center
  - single character in string is the center for possible odd-length palindromes
  - pair character in string is center for possible even-length palindromes
- for each center, expand as long as we get palindromes

Time Complexity: O(n^2)
Space Complexity: O(1)
*/
class Solution {
    int num = 0;

    public int countSubstrings(String s) {
        int n = s.length();
        for(int i = 0; i < n; i++) {
            check(i, i, n, s);
            check(i, i+1, n, s);
        }
        return this.num;
    }

    public void check(int l, int r, int n, String s) {
        if (l >= 0 && r < n && s.charAt(l) == s.charAt(r)) {
            this.num += 1;
            check(l-1, r+1, n, s);
        }
    }
}