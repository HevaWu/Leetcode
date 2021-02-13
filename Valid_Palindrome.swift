/*
Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

Note: For the purpose of this problem, we define empty string as valid palindrome.

Example 1:

Input: "A man, a plan, a canal: Panama"
Output: true
Example 2:

Input: "race a car"
Output: false
 

Constraints:

s consists only of printable ASCII characters.
*/

/*
Solution 2
optimize solution 1
only go one loop of string 

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func isPalindrome(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        
        var s = Array(s)
                
        var left = 0
        var right = s.count-1
        while left < right {
            while !s[left].isNumber && !s[left].isLetter && left < right {
                left += 1
            }
            
            while !s[right].isNumber && !s[right].isLetter && left < right {
                right -= 1
            }
            
            if s[left].lowercased() != s[right].lowercased() { return false }
            left += 1
            right -= 1
        }
        return true
    }
}

/*
Solution 1
process s, filter nonNumber & nonLetter char, then convert them lowercased

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func isPalindrome(_ s: String) -> Bool {
        guard !s.isEmpty else { return true }
        
        var s: [Character] = s
        .filter { $0.isNumber || $0.isLetter }
        .compactMap { $0.lowercased().first }
                
        var left = 0
        var right = s.count-1
        while left < right {
            if s[left] != s[right] { return false }
            left += 1
            right -= 1
        }
        return true
    }
}