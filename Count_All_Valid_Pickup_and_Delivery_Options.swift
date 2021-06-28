/*
Given n orders, each order consist in pickup and delivery services.

Count all valid pickup/delivery possible sequences such that delivery(i) is always after of pickup(i).

Since the answer may be too large, return it modulo 10^9 + 7.



Example 1:

Input: n = 1
Output: 1
Explanation: Unique order (P1, D1), Delivery 1 always is after of Pickup 1.
Example 2:

Input: n = 2
Output: 6
Explanation: All possible orders:
(P1,P2,D1,D2), (P1,P2,D2,D1), (P1,D1,P2,D2), (P2,P1,D1,D2), (P2,P1,D2,D1) and (P2,D2,P1,D1).
This is an invalid order (P1,D2,P2,D1) because Pickup 2 is after of Delivery 2.
Example 3:

Input: n = 3
Output: 90


Constraints:

1 <= n <= 500
*/

/*
Solution 2:
optimize solution 1 with use only one variable

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func countOrders(_ n: Int) -> Int {
        if n == 1 { return 1 }

        let mod = Int(1e9 + 7)

        var cur = 1

        for i in 1..<n {
            let preLen = 2*i+1
            cur = (cur * ((preLen * (preLen+1)) / 2)) % mod
        }

        return cur
    }
}

/*
Solution 1:
DP

n=1, [P1, D1]
n=2, we can put P2 with 3 choices, [P2, P1, D1], [P1, P2, D1], [P1, D1, P2]
  for each choice, we can put D2 have 3+2+1 choices, final is 6
n=3, for each of previous 6th length is 4 array, we can put P3 with 5 choices
  for each choice, we can put D3 have 5+4+3+2+1,
  final will be 6*(5+4+3+2+1) = 90
...

previous len is 2n-1
dp[n] = dp[n-1] * ((2n * (2n+1)) / 2)

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func countOrders(_ n: Int) -> Int {
        if n == 1 { return 1 }

        let mod = Int(1e9 + 7)

        // dp[i], possible sequence D[i-1] always after P[i-1]
        var dp = Array(repeating: 0, count: n)
        dp[0] = 1

        for i in 1..<n {
            let preLen = 2*i
            dp[i] = (dp[i-1] * (((preLen+1) * (preLen+2)) / 2)) % mod
        }

        return dp[n-1]
    }
}