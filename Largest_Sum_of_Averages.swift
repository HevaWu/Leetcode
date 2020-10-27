// We partition a row of numbers A into at most K adjacent (non-empty) groups, then our score is the sum of the average of each group. What is the largest score we can achieve?

// Note that our partition must use every number in A, and that scores are not necessarily integers.

// Example:
// Input: 
// A = [9,1,2,3,9]
// K = 3
// Output: 20
// Explanation: 
// The best choice is to partition A into [9], [1, 2, 3], [9]. The answer is 9 + (1 + 2 + 3) / 3 + 9 = 20.
// We could have also partitioned A into [9, 1], [2], [3, 9], for example.
// That partition would lead to a score of 5 + 2 + 6 = 13, which is worse.
 

// Note:

// 1 <= A.length <= 100.
// 1 <= A[i] <= 10000.
// 1 <= K <= A.length.
// Answers within 10^-6 of the correct answer will be accepted as correct.

// Solution 1: DP
// Time complexity: O(KN^2)
class Solution {
    var A: [Double] = []
    var dp = [[Double]]()
    
    func largestSumOfAverages(_ A: [Int], _ K: Int) -> Double {
        self.A = A.map{ Double($0) }
        let n = A.count
        dp = Array(repeating: Array(repeating: 0, count: n+1), count: n+1)
        
        var cur: Double = 0
        for i in 0..<n {
            cur += self.A[i]
            dp[i+1][1] = cur / Double(i+1)
        }
        return search(n, K)
    }
    
    func search(_ n: Int, _ k: Int) -> Double {
        if dp[n][k] > 0 { return dp[n][k] }
        if n < k { return 0 }
        var cur: Double = 0
        var i = n-1
        while i > 0 {
            cur += A[i]
            dp[n][k] = max(dp[n][k], search(i, k-1) + cur / Double(n-i))
            i -= 1
        }
        return dp[n][k]
    }
}
