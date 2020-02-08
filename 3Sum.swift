// Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.
// Note:
// The solution set must not contain duplicate triplets.
// Example:
// Given array nums = [-1, 0, 1, 2, -1, -4],
// A solution set is:
// [
//   [-1, 0, 1],
//   [-1, -1, 2]
// ]

// Hint: So, we essentially need to find three numbers x, y, and z such that they add up to the given value. If we fix one of the numbers say x, we are left with the two-sum problem at hand!
//
// Hint: For the two-sum problem, if we fix one of the numbers, say x, we have to scan the entire array to find the next number y which is value - x where value is the input parameter. Can we change our array somehow so that this search becomes faster?
//
// The second train of thought for two-sum is, without changing the array, can we use additional space somehow? Like maybe a hash map to speed up the search?

// Solution: Change 3Sum to 2Sum problems
// first sort the array, by the order of array, find 2sum solution
// about 2Sum, use 2 pointer to solve it.
// Note: DO NOT forget to update leftNode & rightNode after adding it to solution set
//
// Time Complexity: O(n^2)
// Space Complexity: O(n)
class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard !nums.isEmpty else { return [] }
        var sums = [[Int]]()
        
        var nums = nums
        nums.sort()        
        for i in 0..<nums.count {
            if i > 0, nums[i] == nums[i - 1] { continue }
            
            // two sum
            var leftNode = i + 1
            var rightNode = nums.count - 1
            var tempSum = -nums[i]
            while leftNode < rightNode {
                switch nums[leftNode] + nums[rightNode] {
                case tempSum:
                    sums.append([nums[i], nums[leftNode], nums[rightNode]])
                    
                    // update leftNode & rightNode
                    while leftNode < rightNode, nums[leftNode] == nums[leftNode + 1] {
                        leftNode += 1
                    }
                    while leftNode < rightNode, nums[rightNode] == nums[rightNode - 1] {
                        rightNode -= 1
                    }
                    leftNode += 1
                    rightNode -= 1
                case let x where x > tempSum:
                    rightNode -= 1
                case let x where x < tempSum:
                    leftNode += 1
                default:
                    continue    
                }
            }
        }
        
        return sums
    }
}
