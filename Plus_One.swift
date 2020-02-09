// Given a non-empty array of digits representing a non-negative integer, plus one to the integer.

// The digits are stored such that the most significant digit is at the head of the list, and each element in the array contain a single digit.

// You may assume the integer does not contain any leading zero, except the number 0 itself.

// Example 1:

// Input: [1,2,3]
// Output: [1,2,4]
// Explanation: The array represents the integer 123.
// Example 2:

// Input: [4,3,2,1]
// Output: [4,3,2,2]
// Explanation: The array represents the integer 4321.

// Solution 1: 
// directly check in the digits index
// if find a digit < 9, directly add it, otherwise, set this digit to 0, and go through next digit
// 
// Time complexity: O(n)
// Space comlexity: O(1)
class Solution {
    func plusOne(_ digits: [Int]) -> [Int] {
        var plusOne = digits
        
        for i in (0..<digits.count).reversed() {
            if digits[i] < 9 {
                plusOne[i] = digits[i] + 1
                return plusOne
            }
            plusOne[i] = 0
        }
        
        plusOne.insert(1, at: 0)
        return plusOne
    }
}