/*
Hercy wants to save money for his first car. He puts money in the Leetcode bank every day.

He starts by putting in $1 on Monday, the first day. Every day from Tuesday to Sunday, he will put in $1 more than the day before. On every subsequent Monday, he will put in $1 more than the previous Monday.
Given n, return the total amount of money he will have in the Leetcode bank at the end of the nth day.



Example 1:

Input: n = 4
Output: 10
Explanation: After the 4th day, the total is 1 + 2 + 3 + 4 = 10.
Example 2:

Input: n = 10
Output: 37
Explanation: After the 10th day, the total is (1 + 2 + 3 + 4 + 5 + 6 + 7) + (2 + 3 + 4) = 37. Notice that on the 2nd Monday, Hercy only puts in $2.
Example 3:

Input: n = 20
Output: 96
Explanation: After the 20th day, the total is (1 + 2 + 3 + 4 + 5 + 6 + 7) + (2 + 3 + 4 + 5 + 6 + 7 + 8) + (3 + 4 + 5 + 6 + 7 + 8) = 96.


Constraints:

1 <= n <= 1000
*/

/*
Solution 1:
Math

We have f = n / 7 full weeks.

The first week we deposit (1 + 7) * 7 / 2 = 28 dollars.

The wth week we deposit (w + w + 6) * 7 / 2 = (w + 3) * 7 dollars, the w + 1th week we deposit 7 dollars more.

So the money we deposit each week is also an arithmetic sequence, whose sum is (28 + 28 + 7 * (f - 1)) * f / 2 = (49 + 7 * f) * f / 2.

The last non-full week has d = n % 7 days. We deposit f + 1 dollars on its Monday, so we deposit (f + 1 + (f + 1 + d - 1)) * d / 2 = (2 * f + d + 1) * d / 2 dollars for this week.

So the final answer is (49 + 7 * f) * f / 2 + (2 * f + d + 1) * d / 2.

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func totalMoney(_ n: Int) -> Int {
        let w = n / 7
        let d = n % 7
        return (49 + 7 * w) * w / 2 + (2 * w + 1 + d) * d / 2
    }
}