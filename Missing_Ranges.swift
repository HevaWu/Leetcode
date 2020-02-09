// Given a sorted integer array nums, where the range of elements are in the inclusive range [lower, upper], return its missing ranges.

// Example:

// Input: nums = [0, 1, 3, 50, 75], lower = 0 and upper = 99,
// Output: ["2", "4->49", "51->74", "76->99"]

// Solution 1: 
// By using `buildString` function to help creating the string
// then go through nums to find the missing ranges
// 
// TimeComplexity: O(n) where n is length of nums
// SpaceComplexity: O(1)
class Solution {
    func findMissingRanges(_ nums: [Int], _ lower: Int, _ upper: Int) -> [String] {
        var missing = [String]()
        var lower = lower
        
        for i in nums {
            if let str = buildString(from: lower, to: i-1) {
                missing.append(str)
            }
            lower = i + 1
        }
        if let str = buildString(from: lower, to: upper) {
            missing.append(str)
        }
        return missing
    }
    
    func buildString(from: Int, to: Int) -> String? {
        if from == to {
            return "\(from)"
        } else if from < to {
            return "\(from)->\(to)"
        } else {
            return nil
        }
    }
}
