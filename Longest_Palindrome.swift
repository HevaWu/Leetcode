/*
Given a string s which consists of lowercase or uppercase letters, return the length of the longest
palindrome
 that can be built with those letters.

Letters are case sensitive, for example, "Aa" is not considered a palindrome.



Example 1:

Input: s = "abccccdd"
Output: 7
Explanation: One longest palindrome that can be built is "dccaccd", whose length is 7.
Example 2:

Input: s = "a"
Output: 1
Explanation: The longest palindrome that can be built is "a", whose length is 1.


Constraints:

1 <= s.length <= 2000
s consists of lowercase and/or uppercase English letters only.
*/

/*
Solution 1:
store character into frequency map
Then map each k,v pair, to check whether can build palindrome from it

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func longestPalindrome(_ s: String) -> Int {
        var freq = [Character: Int]()
        for c in s {
            freq[c, default: 0] += 1
        }

        var hasOdd = false
        var length = 0
        for (k, v) in freq {
            let isOdd = (v % 2 == 1)
            hasOdd = (hasOdd || isOdd)
            length += (isOdd ? (v-1) : v)
        }
        length += (hasOdd ? 1 : 0)
        return length
    }
}
