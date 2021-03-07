/*
Given an input string (s) and a pattern (p), implement wildcard pattern matching with support for '?' and '*' where:

'?' Matches any single character.
'*' Matches any sequence of characters (including the empty sequence).
The matching should cover the entire input string (not partial).

 

Example 1:

Input: s = "aa", p = "a"
Output: false
Explanation: "a" does not match the entire string "aa".
Example 2:

Input: s = "aa", p = "*"
Output: true
Explanation: '*' matches any sequence.
Example 3:

Input: s = "cb", p = "?a"
Output: false
Explanation: '?' matches 'c', but the second letter is 'a', which does not match 'b'.
Example 4:

Input: s = "adceb", p = "*a*b"
Output: true
Explanation: The first '*' matches the empty sequence, while the second '*' matches the substring "dce".
Example 5:

Input: s = "acdcb", p = "a*c?b"
Output: false
 

Constraints:

0 <= s.length, p.length <= 2000
s contains only lowercase English letters.
p contains only lowercase English letters, '?' or '*'.
*/

/*
Solution 1:
iterate s, p
check if 2 string is match

- According to input, we know that when we see "?" it matches a single character - and when we see "*" it matches a sequence of characters.
- Hence, we could just directly apply the matching approach. We could use two pointers to advance each character in the strings. When the character in p is the same as which in s, or when p is "?", we find a matching and we can advance both pointers. Otherwise, if there is a "*" in p, we can advance p continuously. 
- However, we do have 1 problem here - we need to know where is the last star index. This is critical as if we by any chance have a star pointer in p, then we want to increase the pointer to string S to progressively. This in term means, we need to track, additionally, "the matching character in S where we see p has a *"

Time Complexity: O(max(m, n))
Space Complexity: O(1)
*/
class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        if s.isEmpty, p.isEmpty { return true }
        
        var s = Array(s)
        var p = Array(p)
        
        var indexS = 0
        var indexP = 0
        
        let countS = s.count
        let countP = p.count
        
        var temp = -1
        var match = 0
        while indexS < countS {
            if indexP < countP, 
            (p[indexP] == "?" || p[indexP] == s[indexS]) {
                indexP += 1
                indexS += 1
            } else if indexP < countP, p[indexP] == "*" {
                temp = indexP
                match = indexS
                indexP += 1
            } else if temp != -1 {
                indexP = temp+1
                match += 1
                indexS = match
            } else {
                return false
            }
        }
        
        while indexP < countP, p[indexP] == "*" {
            indexP += 1
        }
        
        return indexP == countP
    }
}