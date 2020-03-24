// Your car starts at position 0 and speed +1 on an infinite number line.  (Your car can go into negative positions.)

// Your car drives automatically according to a sequence of instructions A (accelerate) and R (reverse).

// When you get an instruction "A", your car does the following: position += speed, speed *= 2.

// When you get an instruction "R", your car does the following: if your speed is positive then speed = -1 , otherwise speed = 1.  (Your position stays the same.)

// For example, after commands "AAR", your car goes to positions 0->1->3->3, and your speed goes to 1->2->4->-1.

// Now for some target position, say the length of the shortest sequence of instructions to get there.

// Example 1:
// Input: 
// target = 3
// Output: 2
// Explanation: 
// The shortest instruction sequence is "AA".
// Your position goes from 0->1->3.
// Example 2:
// Input: 
// target = 6
// Output: 5
// Explanation: 
// The shortest instruction sequence is "AAARA".
// Your position goes from 0->1->3->7->7->6.
 

// Note:

// 1 <= target <= 10000.

// Solution 1: DP
// Now say we have some target 2**(k-1) <= t < 2**k and we want to know the cost to go there, if we know all the other costs dp[u] (for u < t).
// If t == 2**k - 1, the cost is just k: we use the command A^k, and clearly we can't do better.
// Otherwise, we might drive without crossing the target for a position change of 2^{k-1} - 2**j, by the command A^{k-1} R A^{j} R, for a total cost of k - 1 + j + 2.
// Finally, we might drive 2^k - 1 which crosses the target, by the command A^k R, for a total cost of k + 1k+1.
// 
// Time Complexity: O(T \log T)O(TlogT). Each node i does \log ilogi work.
// Space Complexity: O(T)O(T).
class Solution {
    func racecar(_ target: Int) -> Int {
        var dp = Array(repeating: Int.max, count: target + 3)
        dp[0] = 0
        dp[1] = 1
        dp[2] = 4
        
        guard target > 2 else { return dp[target] }
        
        for t in 3...target {
            var k = 64 - t.leadingZeroBitCount
            if t == (1<<k)-1 {
                dp[t] = k
                continue
            }
            
            // ex: dp[4]
            // j = 0 -> dp[1]+4 -> A
            for j in 0..<k-1 {
                dp[t] = min(dp[t], dp[t - (1<<(k-1)) + (1<<j)] + k-1 + j + 2)
            }
            
            // ex: 
            // dp[4]: dp[(1<<k) - 1 - t] + k + 1) = dp[2]+4
            // dp[2] + AARR -> AARRAARR
            dp[t] = min(dp[t], dp[(1<<k) - 1 - t] + k + 1)
        }
        return dp[target]
    }
}