// Given a 32-bit signed integer, reverse digits of an integer.

// Example 1:

// Input: 123
// Output: 321
// Example 2:

// Input: -123
// Output: -321
// Example 3:

// Input: 120
// Output: 21
// Note:
// Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.

// Solution 1: transfer to string, then process the string
// 
// Time complexity: O(n)
// Space complexity: O(n)
class Solution {
    func reverse(_ x: Int) -> Int {
        var x = String(x)
        var revX = String()
        
        if x.first == "-" {
            revX.append("-")
            x = String(x.dropFirst())
        }
        x = String(x.reversed())
        // drop first 0's
        while x.first == "0" {
            x = String(x.dropFirst())
        }
        revX.append(x)
        let intRevX = Int(revX) ?? 0
        if intRevX > Int32.max || intRevX < Int32.min { return 0 }
        return intRevX
    }
}

// Solution 2: math int digit checking
// for each num, revX = revX*10 + x%10
// 
// Time Complexity: O(\log(x))O(log(x)). There are roughly \log_{10}(x)digits in xx.
// Space Complexity: O(1)O(1).
class Solution {
    func reverse(_ x: Int) -> Int {
        var revX = 0
        var x = x
        while x != 0 {
            revX = revX*10 + x%10
            x = x/10
            if revX > Int32.max || revX < Int32.min { return 0 } 
        }
        return revX
    }
}