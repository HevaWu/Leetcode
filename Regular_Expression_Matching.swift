/*
Given an input string (s) and a pattern (p), implement regular expression matching with support for '.' and '*' where: 

'.' Matches any single character.​​​​
'*' Matches zero or more of the preceding element.
The matching should cover the entire input string (not partial).

 

Example 1:

Input: s = "aa", p = "a"
Output: false
Explanation: "a" does not match the entire string "aa".
Example 2:

Input: s = "aa", p = "a*"
Output: true
Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".
Example 3:

Input: s = "ab", p = ".*"
Output: true
Explanation: ".*" means "zero or more (*) of any character (.)".
Example 4:

Input: s = "aab", p = "c*a*b"
Output: true
Explanation: c can be repeated 0 times, a can be repeated 1 time. Therefore, it matches "aab".
Example 5:

Input: s = "mississippi", p = "mis*is*p*."
Output: false
 

Constraints:

0 <= s.length <= 20
0 <= p.length <= 30
s contains only lowercase English letters.
p contains only lowercase English letters, '.', and '*'.
It is guaranteed for each appearance of the character '*', there will be a previous valid character to match.
*/

/*
Solution 3:
DP bottom up

Time Complexity: O(countS * countP)
Space Complexity: O(countS * countP)
*/
class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        if s.isEmpty, p.isEmpty { return true }
        
        var s = Array(s)
        var p = Array(p)
        
        var countS = s.count
        var countP = p.count
        
        var dp: [[Bool]] = Array(repeating: Array(repeating: false, count: countP+1), 
                       count: countS+1)
        
        dp[countS][countP] = true
        
        for indexS in stride(from: countS, through: 0, by: -1) {
            for indexP in stride(from: countP-1, through: 0, by: -1) {
                // print(indexS, indexP, countS, countP)
                let isFirstMatch = (indexS < countS 
                                    && (s[indexS] == p[indexP] || p[indexP] == "."))
                // print(isFirstMatch)
                if indexP < countP-1, p[indexP+1] == "*" {
                    dp[indexS][indexP] = dp[indexS][indexP+2] 
                    || (isFirstMatch && dp[indexS+1][indexP])
                } else {
                    dp[indexS][indexP] = isFirstMatch && dp[indexS+1][indexP+1]
                }
            }
        }
        
        return dp[0][0]
    }
}

/*
Solution 2:
DP top down

use extra dp[indexS, indexP] to store already checked result

Time Complexity: O(countS * countP)
Space Complexity: O(countS * countP)
*/
class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        if s.isEmpty, p.isEmpty { return true }
        
        var s = Array(s)
        var p = Array(p)
        
        var countS = s.count
        var countP = p.count
        
        // 0 means not checked 
        // 1 means false
        // 2 means true
        var dp: [[Int]] = Array(repeating: Array(repeating: 0, count: countP+1), 
                       count: countS+1)
        
        func check(_ indexS: Int, _ indexP: Int) -> Bool {
            if dp[indexS][indexP] != 0 {
                return dp[indexS][indexP] == 2
            }
            
            var res = false
            
            if indexP == countP {
                res = (indexS == countS)
            } else {
                var isFirstMatch = (indexS < countS 
                                    && (s[indexS] == p[indexP] || p[indexP] == "."))
                
                if indexP < countP-1, p[indexP+1] == "*" {
                    res = (check(indexS, indexP+2) 
                           || (isFirstMatch && check(indexS+1, indexP)))
                } else {
                    res = (isFirstMatch && check(indexS+1, indexP+1))
                }
            }
            
            dp[indexS][indexP] = (res == true ? 2 : 1)
            return res
        }
        
        return check(0, 0)
    }
}

/*
Solution 1:
recursive

Time Complexity: O((countS + countP) * 2^(countS + countP/2))
Space Complexity: O(countS^2 + countP^2)
*/
class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        if s.isEmpty, p.isEmpty { return true }
        return _isMatch(Array(s), Array(p), 0, 0, s.count, p.count)
    }
    
    func _isMatch(_ s: [Character], 
                  _ p: [Character],
                  _ indexS: Int, _ indexP: Int, 
                  _ countS: Int, _ countP: Int) -> Bool {
        if indexP == countP { return indexS == countS }
        var isFirstMatch = (indexS < countS 
                            && (s[indexS] == p[indexP] || p[indexP] == "."))
        
        if indexP < countP-1, p[indexP+1] == "*" {
            return _isMatch(s, p, 
                            indexS, indexP+2, 
                            countS, countP)
            || (isFirstMatch && _isMatch(s, p, 
                                         indexS+1, indexP, 
                                         countS, countP))
        } else {
            return isFirstMatch && _isMatch(s, p, 
                                            indexS+1, indexP+1, 
                                            countS, countP)
        }
    }
}