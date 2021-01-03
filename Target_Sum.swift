/*
You are given a list of non-negative integers, a1, a2, ..., an, and a target, S. Now you have 2 symbols + and -. For each integer, you should choose one from + and - as its new symbol.

Find out how many ways to assign symbols to make sum of integers equal to target S.

Example 1:

Input: nums is [1, 1, 1, 1, 1], S is 3. 
Output: 5
Explanation: 

-1+1+1+1+1 = 3
+1-1+1+1+1 = 3
+1+1-1+1+1 = 3
+1+1+1-1+1 = 3
+1+1+1+1-1 = 3

There are 5 ways to assign symbols to make the sum of nums be target 3.
 

Constraints:

The length of the given array is positive and will not exceed 20.
The sum of elements in the given array will not exceed 1000.
Your output answer is guaranteed to be fitted in a 32-bit integer.
*/

/*
Solution 3:
improvement of Solution 2

instead of 2D dp array, use 1D dp array
because we only use the last element of dp

Time Complexity:
O(l * n)
- l is 2001, the range of possible sum, entire nums array traversed 2001 times
- n is size of nums array

Space Complexity:
O(l)
*/

class Solution {
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        let n = nums.count
        
        // dp[j] the count of element sum as j
        var dp = Array(repeating: 0, count: 2001)
        
        dp[nums[0]+1000] = 1
        dp[-nums[0]+1000] += 1
        
        for i in 1..<n {
            var next = Array(repeating: 0, count: 2001)
            for s in -1000...1000 {
                if dp[s + 1000] > 0 {
                    next[s + nums[i] + 1000] += dp[s + 1000]
                    next[s - nums[i] + 1000] += dp[s + 1000]
                }
            }
            dp = next
        }
        
        return S > 1000 ? 0 : dp[S+1000]
    }
}

/*
Solution 2:
DP

dp[i][j]
- the count of first i nums element sum as j

return dp[n-1][S+1000]

Time Complexity:
O(l * n)
- l is 2001, the range of possible sum, entire nums array traversed 2001 times
- n is size of nums array

Space Complexity:
O(l * n)
*/
class Solution {
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        let n = nums.count
        
        // dp[i][j] means the count of first i nums element sum as j
        // sum of elements is in range of [-1000, 1000], 
        // for keeping index as positive, 
        // we mark it range to [0, 2000], 
        // so the final result will be dp[n-1][S+1000]
        var dp = Array(repeating: Array(repeating: 0, count: 2001),
                       count: n)
        
        dp[0][nums[0]+1000] = 1
        dp[0][-nums[0]+1000] += 1
        
        for i in 1..<n {
            for s in -1000...1000 {
                if dp[i-1][s + 1000] > 0 {
                    dp[i][s + nums[i] + 1000] += dp[i-1][s + 1000]
                    dp[i][s - nums[i] + 1000] += dp[i-1][s + 1000]
                }
            }
        }
        
        return S > 1000 ? 0 : dp[n-1][S+1000]
    }
}


/*
Solution 1:
DFS, recursively check if current num == S

use cal(index:cur) to help memo where we compare now

Time Complexity: O(2^n)
*/
class Solution {
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        let n = nums.count
        var count = 0
        
        func cal(index: Int, cur: Int) {
            if index == n {
                if cur == S {
                    count += 1
                }
                return 
            }
            cal(index: index+1, cur: cur+nums[index])
            cal(index: index+1, cur: cur-nums[index])
        }
        
        cal(index: 0, cur: 0)
        return count
    }
}