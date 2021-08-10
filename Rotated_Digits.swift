/*
An integer x is a good if after rotating each digit individually by 180 degrees, we get a valid number that is different from x. Each digit must be rotated - we cannot choose to leave it alone.

A number is valid if each digit remains a digit after rotation. For example:

0, 1, and 8 rotate to themselves,
2 and 5 rotate to each other (in this case they are rotated in a different direction, in other words, 2 or 5 gets mirrored),
6 and 9 rotate to each other, and
the rest of the numbers do not rotate to any other number and become invalid.
Given an integer n, return the number of good integers in the range [1, n].



Example 1:

Input: n = 10
Output: 4
Explanation: There are four good numbers in the range [1, 10] : 2, 5, 6, 9.
Note that 1 and 10 are not good numbers, since they remain unchanged after rotating.
Example 2:

Input: n = 1
Output: 0
Example 3:

Input: n = 2
Output: 1


Constraints:

1 <= n <= 104
*/

/*
Solution 1:
dp[i] = 0, invalid number
dp[i] = 1, valid and same number
dp[i] = 2, valid and different number

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func rotatedDigits(_ n: Int) -> Int {
        // dp[i] can be 0,1,2 means invalid, valid and same, valid and different
        var dp = Array(repeating: 0, count: n+1)
        var count = 0

        // from 0 to n
        for i in 0...n {
            if i < 10 {
                if i == 0 || i == 1 || i == 8 {
                    dp[i] = 1
                } else if i == 2 || i == 5 || i == 6 || i == 9 {
                    dp[i] = 2
                    count += 1
                }
            } else {
                let a = dp[i/10]
                let b = dp[i%10]

                if a == 1, b == 1 {
                    dp[i] = 1
                } else if a >= 1, b >= 1 {
                    dp[i] = 2
                    count += 1
                }
            }
        }

        return count
    }
}