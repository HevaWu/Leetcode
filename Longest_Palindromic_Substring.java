/*
Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

Example 1:

Input: "babad"
Output: "bab"
Note: "aba" is also a valid answer.
Example 2:

Input: "cbbd"
Output: "bb"

palindromic 对称的
A palindrome is a string which reads the same in both directions. For example, SS = "aba" is a palindrome, SS = "abc" is not.

Hint 1: How can we reuse a previously computed palindrome to compute a larger palindrome?
Hint 2: If “aba” is a palindrome, is “xabax” and palindrome? Similarly is “xabay” a palindrome?
Hint 3: Complexity based hint:
If we use brute-force and check whether for every start and end position a substring is a palindrome we have O(n^2) start - end pairs and O(n) palindromic checks. Can we reduce the time for palindromic checks to O(1) by reusing some previous computation.
*/

/*
Solution 2:

for avoiding calculate duplicate center,
we start from center, and update center with center=right+1

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public String longestPalindrome(String s) {
        int n = s.length();

        int start = 0;
        int len = 0;
        int center = 0;
        while (center < n) {
            int l = center;
            int r = center;
            while(r+1 < n && s.charAt(l) == s.charAt(r+1)) {
                r += 1;
            }

            center = r+1;

            while (l-1 >= 0 && r+1 < n && s.charAt(l-1) == s.charAt(r+1)) {
                l -= 1;
                r += 1;
            }

            if (r-l+1 > len) {
                len = Math.max(len, r-l+1);
                start = l;
            }
        }
        return s.substring(start, start+len).toString();
    }
}