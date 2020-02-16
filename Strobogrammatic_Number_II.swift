// A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).

// Find all strobogrammatic numbers that are of length = n.

// Example:

// Input:  n = 2
// Output: ["11","69","88","96"]

// Solution 1: recursive
// for odd number, 0,1,8
// for even number, need to add 00
// 
// Time complexity: O(logn)
// Space complexity: O(logn)
class Solution {
    func findStrobogrammatic(_ n: Int) -> [String] {
        return findPair(n, n)
    }
    
    private func findPair(_ n: Int, _ m: Int) -> [String] {
        guard n > 0 else { return [""] }
        guard n > 1 else { return ["0", "1", "8"] }
        
        var temp = findPair(n-2, m)
        var pair = [String]()
        for t in temp {
            if n != m {
                pair.append("0" + t + "0")
            }
            pair.append("1" + t + "1")
            pair.append("6" + t + "9")
            pair.append("9" + t + "6")
            pair.append("8" + t + "8")
        }
        return pair
    }
}