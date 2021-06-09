/*
You are given a 0-indexed integer array nums and an integer k.

You are initially standing at index 0. In one move, you can jump at most k steps forward without going outside the boundaries of the array. That is, you can jump from index i to any index in the range [i + 1, min(n - 1, i + k)] inclusive.

You want to reach the last index of the array (index n - 1). Your score is the sum of all nums[j] for each index j you visited in the array.

Return the maximum score you can get.



Example 1:

Input: nums = [1,-1,-2,4,-7,3], k = 2
Output: 7
Explanation: You can choose your jumps forming the subsequence [1,-1,4,3] (underlined above). The sum is 7.
Example 2:

Input: nums = [10,-5,-2,4,0,3], k = 3
Output: 17
Explanation: You can choose your jumps forming the subsequence [10,4,3] (underlined above). The sum is 17.
Example 3:

Input: nums = [1,-5,-20,4,-1,3,-6,-3], k = 2
Output: 0


Constraints:

 1 <= nums.length, k <= 105
-104 <= nums[i] <= 104
*/

/*
Solution 2:
greedy

start from end, for each index, we store its best answer
A maxium from i+1 to i+k can be found in O(1) time using a monoqueue when we start from the end.

also, update input nums array to record each ith maxResult from [n-1 ... i]
we will always maintain k element in the deque
also, for element less than previous res, we remove it from deque

Time Complexity: O(n)
Space Complexity: O(k)
*/
class Solution {
    func maxResult(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        if n == 1 { return nums[0] }
        var nums = nums

        var res = Int.min
        var deque = [Int]()
        for i in stride(from: n-1, through: 0, by: -1) {
            res = nums[i] + (deque.isEmpty ? 0 : nums[deque.first!])

            while !deque.isEmpty, res > nums[deque.last!] {
                deque.removeLast()
            }
            deque.append(i)

            if deque.first! >= i+k {
                deque.removeFirst()
            }

            // update nums to store best results
            nums[i] = res
        }
        return res
    }

}

/*
Solution 1:
TLE

DP
dp[i] = max(dp[i], nums[i]+dp[j])

Time Complexity: O(nk)
Space Complexity: O(n)
*/
class Solution {
    func maxResult(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        if n == 1 { return nums[0] }

        // dp[i], maxResult can get at ith point
        // init all as Int.min
        var dp = Array(repeating: Int.min, count: n)
        dp[0] = nums[0]
        for i in 1..<n {
            for j in stride(from: i-1, through: max(0, i-k), by:-1) {
                dp[i] = max(dp[i], nums[i]+dp[j])
            }
        }
        // print(dp)
        return dp[n-1]
    }
}