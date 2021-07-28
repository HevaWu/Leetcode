/*
You have d dice and each die has f faces numbered 1, 2, ..., f.

Return the number of possible ways (out of fd total ways) modulo 109 + 7 to roll the dice so the sum of the face-up numbers equals target.



Example 1:

Input: d = 1, f = 6, target = 3
Output: 1
Explanation:
You throw one die with 6 faces.  There is only one way to get a sum of 3.
Example 2:

Input: d = 2, f = 6, target = 7
Output: 6
Explanation:
You throw two dice, each with 6 faces.  There are 6 ways to get a sum of 7:
1+6, 2+5, 3+4, 4+3, 5+2, 6+1.
Example 3:

Input: d = 2, f = 5, target = 10
Output: 1
Explanation:
You throw two dice, each with 5 faces.  There is only one way to get a sum of 10: 5+5.
Example 4:

Input: d = 1, f = 2, target = 3
Output: 0
Explanation:
You throw one die with 2 faces.  There is no way to get a sum of 3.
Example 5:

Input: d = 30, f = 30, target = 500
Output: 222616187
Explanation:
The answer must be returned modulo 10^9 + 7.


Constraints:

1 <= d, f <= 30
1 <= target <= 1000

*/

/*
Solution 1:
DP
dp[remain dices][remain target]

Time Complexity: O(d*target*f)
Sapce Complexity: O(d*target)
*/
class Solution {
    func numRollsToTarget(_ d: Int, _ f: Int, _ target: Int) -> Int {
        guard target >= d, target <= f*d else { return 0 }
        let mod = Int(1e9 + 7)
        var dp: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: target+1),
            count: d+1
        )
        return check(d, target, &dp, f, mod)
    }

    func check(_ d: Int, _ remain: Int,
               _ dp: inout [[Int?]], _ f: Int,
               _ mod: Int) -> Int {
        if remain == 0, d == 0 { return 1 }
        if remain <= 0 { return 0 }
        if d <= 0 { return 0 }

        if let val = dp[d][remain] { return val }
        var val = 0
        for pick in 1...f {
            val = (val + check(d-1, remain-pick, &dp, f, mod)) % mod
        }
        dp[d][remain] = val
        return val
    }
}