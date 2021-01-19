// Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

// Example 1:

// Input: "babad"
// Output: "bab"
// Note: "aba" is also a valid answer.
// Example 2:

// Input: "cbbd"
// Output: "bb"

// palindromic 对称的
// A palindrome is a string which reads the same in both directions. For example, SS = "aba" is a palindrome, SS = "abc" is not.

// Hint 1: How can we reuse a previously computed palindrome to compute a larger palindrome?
// Hint 2: If “aba” is a palindrome, is “xabax” and palindrome? Similarly is “xabay” a palindrome?
// Hint 3: Complexity based hint:
// If we use brute-force and check whether for every start and end position a substring is a palindrome we have O(n^2) start - end pairs and O(n) palindromic checks. Can we reduce the time for palindromic checks to O(1) by reusing some previous computation.

/*
Solution 2: 

for avoiding calculate duplicate center,
we start from center, and update center with center=right+1

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func longestPalindrome(_ s: String) -> String {
        var start = 0
        
        var s = Array(s)
        let n = s.count
        
        var len = 1
        var center = 0
        while center < n {
            var left = center
            var right = center
            while right + 1 < n, s[right+1] == s[left] {
                right += 1
            }
            
            // quick sksip update the center here
            center = right + 1
            
            while left > 0, right+1 < n, s[left-1] == s[right+1] {
                right += 1
                left -= 1
            }
            
            if len < right-left+1 {
                len = right - left + 1
                start = left
            }
        }
        
        return String(s[start..<(start+len)])
    }
}

// Solution 1: expand from center
// We observe that a palindrome mirrors around its center. Therefore, a palindrome can be expanded from its center, and there are only 2n−1 such centers.
// You might be asking why there are 2n−1 but not nn centers? The reason is the center of a palindrome can be in between two letters. Such palindromes have even number of letters (such as "abba") and its center are between the two 'b's.
// 
// Time complexity : O(n^2) Since expanding a palindrome around its center could take O(n)O(n) time, the overall complexity is O(n^2)
// Space complexity : O(1)O(1).
class Solution {
    func longestPalindrome(_ s: String) -> String {
        guard s.count > 0 else { return String() }
        var start = 0
        var end = 0
        
        var s = Array(s)
        for i in 0..<s.count {
            let len1 = findFromCenter(s, i, i)
            let len2 = findFromCenter(s, i, i+1)
            let len = max(len1, len2)
            if len>end-start {
                start = i-(len-1)/2
                end = i+len/2
            }
        }
        return String(s[start...end])
    }
    
    func findFromCenter(_ s: [Character], _ first: Int, _ second: Int) -> Int {
        var first = first
        var second = second
        while first >= 0, second < s.count, s[first]==s[second] {
            first -= 1
            second += 1
        }
        return second - first - 1
    }
}