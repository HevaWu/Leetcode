// Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

// Example:

// Input: [-2,1,-3,4,-1,2,1,-5,4],
// Output: 6
// Explanation: [4,-1,2,1] has the largest sum = 6.
// Follow up:

// If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.

// Solution 1: greedy
// by using a dp array for help checking previous continuous number sum
// 
// Time complexity: O(n)
// Space complexity: O(1)
class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        var dp = Array(repeating: 0, count: nums.count)
        dp[0] = nums[0]
        var sum = dp[0]
        for i in 1..<nums.count {
            dp[i] = nums[i] + max(0, dp[i-1])
            sum = max(sum, dp[i])
        }
        return sum
    }
}

// Solution 2: Divide and conquer
// If n == 1 : return this single element.
// left_sum = maxSubArray for the left subarray, i.e. for the first n/2 numbers (middle element at index (left + right) / 2 always belongs to the left subarray).
// right_sum = maxSubArray for the right subarray, i.e. for the last n/2 numbers.
// cross_sum = maximum sum of the subarray containing elements from both left and right subarrays and hence crossing the middle element at index (left + right) / 2.
// Merge the subproblems solutions, i.e. return max(left_sum, right_sum, cross_sum).
// 
// Time complexity : \mathcal{O}(N \log N)O(NlogN). Let's compute the solution with the help of master theorem T(N) = aT\left(\frac{b}{N}\right) + \Theta(N^d) The equation represents dividing the problem up into aa subproblems of size \frac{N}{b} in \Theta(N^d) time. Here one divides the problem in two subproblemes a = 2, the size of each subproblem (to compute left and right subtree) is a half of initial problem b = 2, and all this happens in a \mathcal{O}(N)O(N) time d = 1. That means that \log_b(a) = dand hence we're dealing with case 2 that means \mathcal{O}(N^{\log_b(a)} \log N) = \mathcal{O}(N \log N)time complexity.
// Space complexity : \mathcal{O}(\log N)O(logN) to keep the recursion stack.
class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        return merge(nums, 0, nums.count-1)
    }
    
    func merge(_ nums: [Int], _ left: Int, _ right: Int) -> Int {
        if left == right {
            return nums[left]
        }
        
        let mid = (left+right)/2
        let leftSum = merge(nums, left, mid)
        let rightSum = merge(nums, mid+1, right)
        let crossSum = cross(nums, left, right, mid)
        return max(max(leftSum, rightSum), crossSum)
    }
    
    func cross(_ nums: [Int], _ left: Int, _ right: Int, _ mid: Int) -> Int {
        if left == right {
            return nums[left]
        }
        
        var leftSum = Int.min
        var currSum = 0
        for i in (left...mid).reversed() {
            currSum += nums[i]
            leftSum = max(leftSum, currSum)
        }
        
        var rightSum = Int.min
        currSum = 0
        for i in (mid+1)...right {
            currSum += nums[i]
            rightSum = max(rightSum, currSum)
        }
        
        return leftSum+rightSum
    }
}