/*
You are given a string s consisting only of characters 'a' and 'b'​​​​.

You can delete any number of characters in s to make s balanced. s is balanced if there is no pair of indices (i,j) such that i < j and s[i] = 'b' and s[j]= 'a'.

Return the minimum number of deletions needed to make s balanced.



Example 1:

Input: s = "aababbab"
Output: 2
Explanation: You can either:
Delete the characters at 0-indexed positions 2 and 6 ("aababbab" -> "aaabbb"), or
Delete the characters at 0-indexed positions 3 and 6 ("aababbab" -> "aabbbb").
Example 2:

Input: s = "bbaaaaabb"
Output: 2
Explanation: The only solution is to delete the first two characters.


Constraints:

1 <= s.length <= 105
s[i] is 'a' or 'b'​​.
*/

/*
Solution 1:
keep track the record of removing b and not removing b,
then calculate the min operation to make the deletion

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func minimumDeletions(_ s: String) -> Int {
        let n = s.count
        var dp = Array(repeating: 0, count: n+1)
        var b = 0
        var s = Array(s)
        for i in 1...n {
            let v = s[i-1]
            if v == Character("b") {
                dp[i] = dp[i-1]
                b += 1
            } else {
                dp[i] = min(dp[i-1]+1, b)
            }
        }
        return dp[n]
    }
}
