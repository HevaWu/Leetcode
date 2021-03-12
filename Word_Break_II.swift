/*
Given a string s and a dictionary of strings wordDict, add spaces in s to construct a sentence where each word is a valid dictionary word. Return all such possible sentences in any order.

Note that the same word in the dictionary may be reused multiple times in the segmentation.

 

Example 1:

Input: s = "catsanddog", wordDict = ["cat","cats","and","sand","dog"]
Output: ["cats and dog","cat sand dog"]
Example 2:

Input: s = "pineapplepenapple", wordDict = ["apple","pen","applepen","pine","pineapple"]
Output: ["pine apple pen apple","pineapple pen apple","pine applepen apple"]
Explanation: Note that you are allowed to reuse a dictionary word.
Example 3:

Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
Output: []
 

Constraints:

1 <= s.length <= 20
1 <= wordDict.length <= 1000
1 <= wordDict[i].length <= 10
s and wordDict[i] consist of only lowercase English letters.
All the strings of wordDict are unique.
*/

/*
Solution 2:
recursion with memoization

Time Complexity: O(n*m)
Space Complexity: O(n*m)
*/
class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        var memo = [String: [String]]()        
        return check(s, wordDict, &memo)
    }
    
    func check(_ s: String, _ wordDict: [String], 
               _ memo: inout [String: [String]]) -> [String] {
        var res = [String]()
        
        if let val = memo[s]  {
            return val
        }
        
        for word in wordDict {
            if s.hasPrefix(word) {
                if word == s {
                    res.append(word)
                    continue
                }
                
                var list = check(String(s[word.endIndex...]), wordDict, &memo)
                for next in list {
                    res.append(word + " " + next)
                }
            }
        }
        
        memo[s] = res
        return res
    }
}

/*
Solution 1:
DP

n - s.count
Time Complexity: O(2^n)
Space Complexity: O(n)
*/
class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
        let n = s.count
        var s = Array(s)
        var wordDict = Set(wordDict)
        
        var res = [String]()
        var cur = [String]()
        
        check(0, s, n, wordDict, &cur, &res)
        return res
    }
    
    func check(_ start: Int, 
               _ s: [Character], _ n: Int, 
               _ wordDict: Set<String>, 
               _ cur: inout [String], _ res: inout [String]) {
        if start == n {
            res.append(cur.joined(separator: " "))
            return
        }
        
        for end in (start+1)...n {
            let word = String(s[start..<end])
            
            if wordDict.contains(word) {
                cur.append(word)
                check(end, s, n, wordDict, &cur, &res)
                cur.removeLast()
            }
        }
    }
}