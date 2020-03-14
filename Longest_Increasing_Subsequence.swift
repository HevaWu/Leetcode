// Given an unsorted array of integers, find the length of longest increasing subsequence.

// Example:

// Input: [10,9,2,5,3,7,101,18]
// Output: 4 
// Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4. 
// Note:

// There may be more than one LIS combination, it is only necessary for you to return the length.
// Your algorithm should run in O(n2) complexity.
// Follow up: Could you improve it to O(n log n) time complexity?

// Solution 1: force
// pick & not pick
// recursive
// 
// Time complexity : O(2^n) Size of recursion tree will be 2^n
// Space complexity : O(n^2) memomemo array of size n * nn∗n is used.
class Solution {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        return check(nums, Int.min, 0)
    }
    
    func check(_ nums: [Int], _ pre: Int, _ index: Int) -> Int {
        if index == nums.count { return 0 }
        var pick = 0
        if nums[index] > pre {
            pick = 1 + check(nums, nums[index], index + 1)
        }
        var notPick = check(nums, pre, index + 1)
        return max(pick, notPick)
    }
}

// Solution 2: DP
// This method relies on the fact that the longest increasing subsequence possible upto the i^{th}index in a given array is independent of the elements coming later on in the array. Thus, if we know the length of the LIS upto i^{th}index, we can figure out the length of the LIS possible by including the (i+1)^{th}element based on the elements with indices jj such that 0 \leq j \leq (i + 1)0≤j≤(i+1).
// We make use of a dpdp array to store the required data. dp[i]dp[i] represents the length of the longest increasing subsequence possible considering the array elements upto the i^{th}index only ,by necessarily including the i^{th}element. In order to find out dp[i]dp[i], we need to try to append the current element(nums[i]nums[i]) in every possible increasing subsequences upto the (i-1)^{th}index(including the (i-1)^{th}index), such that the new sequence formed by adding the current element is also an increasing subsequence. Thus, we can easily determine dp[i]dp[i] using:
// dp[i] = \text{max}(dp[j]) + 1, \forall 0\leq j < idp[i]=max(dp[j])+1,∀0≤j<i
// At the end, the maximum out of all the dp[i]dp[i]'s to determine the final result.
// LIS_{length}= \text{max}(dp[i]), \forall 0\leq i < n
// 
// Time complexity : O(n^2) Two loops of nn are there.
// Space complexity : O(n)O(n). dpdp array of size nn is used.
class Solution {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        var maxLen = 1
        var dp = Array(repeating: 0, count: nums.count)
        dp[0] = 1
        for i in 1..<nums.count {
            var temp = 0
            var j = 0
            while j < i {
                if nums[i] > nums[j] {
                    temp = max(temp, dp[j])
                }
                j += 1
            }
            dp[i] = temp + 1
            maxLen = max(maxLen, dp[i])
        }
        return maxLen
    }
}

 
// Solution 1: DP + binary search
// In this approach, we scan the array from left to right. We also make use of a dpdp array initialized with all 0's. This dpdp array is meant to store the increasing subsequence formed by including the currently encountered element. While traversing the numsnums array, we keep on filling the dpdp array with the elements encountered so far. For the element corresponding to the j^{th}index (nums[j]nums[j]), we determine its correct position in the dpdp array(say i^{th}index) by making use of Binary Search(which can be used since the dpdp array is storing increasing subsequence) and also insert it at the correct position. An important point to be noted is that for Binary Search, we consider only that portion of the dpdp array in which we have made the updates by inserting some elements at their correct positions(which remains always sorted). Thus, only the elements upto the i^{th}index in the dpdp array can determine the position of the current element in it. Since, the element enters its correct position(ii) in an ascending order in the dpdp array, the subsequence formed so far in it is surely an increasing subsequence. Whenever this position index ii becomes equal to the length of the LIS formed so far(lenlen), it means, we need to update the lenlen as len = len + 1len=len+1.
// Note: dpdp array does not result in longest increasing subsequence, but length of dpdp array will give you length of LIS.
// Consider the example:
// input: [0, 8, 4, 12, 2]
// dp: [0]
// dp: [0, 8]
// dp: [0, 4]
// dp: [0, 4, 12]
// dp: [0 , 2, 12] which is not the longest increasing subsequence, but length of dpdp array results in length of Longest Increasing Subsequence.
// 
// Time complexity: O(nlogn)
// Space complexity: O(n)
class Solution {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        var dp = Array(repeating: 0, count: nums.count)
        var len = 0 
        for i in 0..<nums.count {
            var temp = binarySearch(dp, 0, len, nums[i])
            dp[temp] = nums[i]
            if temp == len {
                len += 1
            }
        }
        return len
    }
    
    func binarySearch(_ arr: [Int], _ start: Int, _ end: Int, _ target: Int) -> Int {
        var start = start
        var end = end
        while start < end {
            var mid = (start + end) / 2
            if arr[mid] == target {
                return mid
            }
            if arr[mid] < target {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return start
    }
}