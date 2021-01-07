/*
You are climbing a staircase. It takes n steps to reach the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

 

Example 1:

Input: n = 2
Output: 2
Explanation: There are two ways to climb to the top.
1. 1 step + 1 step
2. 2 steps
Example 2:

Input: n = 3
Output: 3
Explanation: There are three ways to climb to the top.
1. 1 step + 1 step + 1 step
2. 1 step + 2 steps
3. 2 steps + 1 step
 

Constraints:

1 <= n <= 45
*/

/*
Solution 1:
recursive

dp[n] = dp[n-1] + dp[n-2]
// equal to clim(n) = fibnacci(n+1)

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func climbStairs(_ n: Int) -> Int {
        if n <= 1 { return 1 }
        // key is n
        // value is steps
        var cache = [Int: Int]()
        cache[0] = 1
        cache[1] = 1
        
        func _count(_ n: Int) -> Int {
            if let val = cache[n] { return val }
            cache[n] = _count(n-1) + _count(n-2)
            return cache[n]!
        }
        return _count(n)
    }
}