// A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).

// Write a function to count the total strobogrammatic numbers that exist in the range of low <= num <= high.

// Example:

// Input: low = "50", high = "100"
// Output: 3 
// Explanation: 69, 88, and 96 are three strobogrammatic numbers.
// Note:
// Because the range might be a large number, the low and high numbers are represented as string.

// Solution 1: string processing
// for each len, find this len Strings
// 
// Time complexity: O(mn) = O(n^2) m is low.count - high.count, n is max(high.count, low.count)
// Space complexity: O(mn)
class Solution {
    var dic: [(Character, Character)] = [("0", "0"), ("1", "1"), ("6", "9"), ("8", "8"), ("9", "6")]
    var low = String()
    var high = String()
    var count = 0
    
    func strobogrammaticInRange(_ low: String, _ high: String) -> Int {
        guard low.count <= high.count, !low.isEmpty else { return 0 }
        self.low = low
        self.high = high
        for len in low.count...high.count {
            var char = Array(repeating: Character("0"), count: len)
            findNum(&char, 0, len-1)
        }
        return count
    }
    
    func findNum(_ char: inout [Character], _ left: Int, _ right: Int) {
        if left > right {
            let str = String(char)
            if (str.count == low.count && str < low) 
            || (str.count == high.count && str > high) {
                // out of range
                return
            } 
            count += 1
            return 
        }
        
        for pair in dic {
            char[left] = pair.0
            char[right] = pair.1
            
            // don't append 0 at first
            if char.count > 1, char[0] == "0" { continue }
            
            // odd number
            if left == right, pair.0 != pair.1 { continue }
            
            findNum(&char, left+1, right-1)
        }
    }
}