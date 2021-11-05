/*
You have n coins and you want to build a staircase with these coins. The staircase consists of k rows where the ith row has exactly i coins. The last row of the staircase may be incomplete.

Given the integer n, return the number of complete rows of the staircase you will build.



Example 1:


Input: n = 5
Output: 2
Explanation: Because the 3rd row is incomplete, we return 2.
Example 2:


Input: n = 8
Output: 3
Explanation: Because the 4th row is incomplete, we return 3.


Constraints:

1 <= n <= 231 - 1
*/

/*
Solution 2:
math
k = \left[\sqrt{2N + \frac{1}{4}} - \frac{1}{2}\right]

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    public int arrangeCoins(int n) {
        // use (long)n to avoid n larger than int 32 bit
        return (int)Math.floor(Math.sqrt(2 * (long)n + 0.25) - 0.5);
    }
}