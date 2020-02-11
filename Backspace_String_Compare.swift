// Given two strings S and T, return if they are equal when both are typed into empty text editors. # means a backspace character.

// Example 1:

// Input: S = "ab#c", T = "ad#c"
// Output: true
// Explanation: Both S and T become "ac".
// Example 2:

// Input: S = "ab##", T = "c#d#"
// Output: true
// Explanation: Both S and T become "".
// Example 3:

// Input: S = "a##c", T = "#a#c"
// Output: true
// Explanation: Both S and T become "c".
// Example 4:

// Input: S = "a#c", T = "b"
// Output: false
// Explanation: S becomes "c" while T becomes "b".
// Note:

// 1 <= S.length <= 200
// 1 <= T.length <= 200
// S and T only contain lowercase letters and '#' characters.
// Follow up:

// Can you solve it in O(N) time and O(1) space?

// Solution: Directly update S & T
// Use Array to help checking, when char is not # append it into arr, if it is #, removeLast
// 
// Time Complexity: O(M + N), where M, NM,N are the lengths of S and T respectively.
// Space Complexity: O(M + N).
class Solution {
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        return result(of: S) == result(of: T)
    }
    
    func result(of str: String) -> String {
        var arr = [Character]()
        for s in str {
            if s == "#" {
                guard !arr.isEmpty else { continue }
                arr.removeLast()
            } else {
                arr.append(s)
            }
        }
        return String(arr)
    }
}

// Solution 2:
// Iterate through the string in reverse. If we see a backspace character, the next non-backspace character is skipped. If a character isn't skipped, it is part of the final answer.
// 
// Time Complexity: O(M + N), where M, NM,N are the lengths of S and T respectively.
// Space Complexity: O(1).
class Solution {
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        var S = Array(S)
        var T = Array(T)
        
        var indexS = 0
        var indexT = 0
        
        var backS = S.count - 1
        var backT = T.count - 1
        
        while backS >= 0 || backT >= 0 {
            while backS >= 0 {
                if S[backS] == "#" {
                    indexS += 1
                    backS -= 1
                } else if indexS > 0 {
                    indexS -= 1
                    backS -= 1
                } else {
                    break
                }
            }
            
            while backT >= 0 {
                if T[backT] == "#" {
                    indexT += 1
                    backT -= 1
                } else if indexT > 0 {
                    indexT -= 1
                    backT -= 1
                } else {
                    break
                }
            }
            
            if backS >= 0, backT >= 0, S[backS] != T[backT] { return false }
            if (backS >= 0) != (backT >= 0) { return false }
            backS -= 1
            backT -= 1
        }
        
        return true
    }
}