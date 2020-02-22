// A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).

// Write a function to determine if a number is strobogrammatic. The number is represented as a string.

// Example 1:

// Input:  "69"
// Output: true
// Example 2:

// Input:  "88"
// Output: true
// Example 3:

// Input:  "962"
// Output: false

// Solution 1: 2 pointer
// 
// Time complexity: O(n) <- go through all of character
// Space complexity: O(1)
class Solution {
    func isStrobogrammatic(_ num: String) -> Bool {
        guard !num.isEmpty else { return true }
        var num = Array(num)
        var left = 0
        var right = num.count - 1
        var dic: [Character: Character] = ["0": "0", "1": "1", "6": "9", "8": "8", "9": "6"]
        while left <= right {
            if let value = dic[num[left]], value == num[right] {
                left += 1
                right -= 1
            } else {
                return false
            }
        }
        return true
    }
}

class Solution {
    func isStrobogrammatic(_ num: String) -> Bool {
        guard !num.isEmpty else { return true }
        
        var left = num.startIndex
        var right = num.index(before: num.endIndex)
        
        var rotate: [Character: Character] = ["6": "9", "9": "6"]
        var same: [Character: Character] = ["0": "0", "1": "1", "8": "8"]
        while left < right {
            if (same.keys.contains(num[left]) && same[num[left]] == num[right])
            || (rotate.keys.contains(num[left]) && rotate[num[left]] == num[right]) {
                left = num.index(after: left)
                right = num.index(before: right)
                continue
            } else {
                return false
            }
        }

        // check if odd count
        guard left == right else { return true }
        if num[left] == "0" || num[left] == "1" || num[left] == "8" {
            return true
        }
        return false
    }
}