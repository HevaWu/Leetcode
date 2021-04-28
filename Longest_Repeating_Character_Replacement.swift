/*
You are given a string s and an integer k. You can choose any character of the string and change it to any other uppercase English character. You can perform this operation at most k times.

Return the length of the longest substring containing the same letter you can get after performing the above operations.



Example 1:

Input: s = "ABAB", k = 2
Output: 4
Explanation: Replace the two 'A's with two 'B's or vice versa.
Example 2:

Input: s = "AABABBA", k = 1
Output: 4
Explanation: Replace the one 'A' in the middle with 'B' and form "AABBBBA".
The substring "BBBB" has the longest repeating letters, which is 4.


Constraints:

1 <= s.length <= 105
s consists of only uppercase English letters.
0 <= k <= s.length
*/

/*
Solution 1:
sliding window

The initial step is to extend the window to its limit, that is, the longest we can get to with maximum number of modifications. Until then the variable left will remain at 0.

Then as right increase, the whole substring from 0 to end will violate the rule, so we need to update left accordingly (slide the window). We move left to the right until the whole string satisfy the constraint again. Then each time we reach such situation, we update our max length.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        var s = Array(s)
        let n = s.count
        var map = [Character: Int]()

        var left = 0
        var longest = 0
        var maxCount = 0
        for right in 0..<n {
            map[s[right], default: 0] += 1
            maxCount = max(maxCount, map[s[right]]!)
            while right - left + 1 - maxCount > k {
                map[s[left], default: 0] -= 1
                left += 1
            }
            longest = max(longest, right - left + 1)
        }

        return longest
    }
}