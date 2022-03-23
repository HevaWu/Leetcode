/*
On a broken calculator that has a number showing on its display, we can perform two operations:

Double: Multiply the number on the display by 2, or;
Decrement: Subtract 1 from the number on the display.
Initially, the calculator is displaying the number X.

Return the minimum number of operations needed to display the number Y.



Example 1:

Input: X = 2, Y = 3
Output: 2
Explanation: Use double operation and then decrement operation {2 -> 4 -> 3}.
Example 2:

Input: X = 5, Y = 8
Output: 2
Explanation: Use decrement and then double {5 -> 4 -> 8}.
Example 3:

Input: X = 3, Y = 10
Output: 3
Explanation:  Use double, decrement and double {3 -> 6 -> 5 -> 10}.
Example 4:

Input: X = 1024, Y = 1
Output: 1023
Explanation: Use decrement operations 1023 times.


Note:

1 <= X <= 10^9
1 <= Y <= 10^9
*/

/*
Solution 2
backwards

divide Y
OR add 1 to Y

- If say Y is even, then if we perform 2 additions and one division, we could instead perform one division and one addition for less operations [(Y+2) / 2 vs Y/2 + 1].
- If say Y is odd, then if we perform 3 additions and one division, we could instead perform 1 addition, 1 division, and 1 addition for less operations [(Y+3) / 2 vs (Y+1) / 2 + 1].

While Y is larger than X, add 1 if it is odd, else divide by 2. After, we need to do X - Y additions to reach X.

Time Complexity: O(log Y)
Space Complexity: O(1)
*/
class Solution {
    public int brokenCalc(int startValue, int target) {
        int res = 0;
        while (target > startValue) {
            res += 1;
            if (target % 2 == 1) {
                target += 1;
            } else {
                target /= 2;
            }
        }
        return res + startValue - target;
    }
}