/*
Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.

Note that the same word in the dictionary may be reused multiple times in the segmentation.

 

Example 1:

Input: s = "leetcode", wordDict = ["leet","code"]
Output: true
Explanation: Return true because "leetcode" can be segmented as "leet code".
Example 2:

Input: s = "applepenapple", wordDict = ["apple","pen"]
Output: true
Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
Note that you are allowed to reuse a dictionary word.
Example 3:

Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
Output: false
 

Constraints:

1 <= s.length <= 300
1 <= wordDict.length <= 1000
1 <= wordDict[i].length <= 20
s and wordDict[i] consist of only lowercase English letters.
All the strings of wordDict are unique.
*/

/*
Solution 2:
DP

Time Complexity: O(n^3)
Space Complexity: O(n)
*/
class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        let n = s.count
        var s = Array(s)
        var wordDict = Set(wordDict)
        
        var dp = Array(repeating: false, count: n+1)
        dp[0] = true
        
        for i in 1...n {
            for j in 0..<i {
                if dp[j] && wordDict.contains(String(s[j..<i])) {
                    dp[i] = true
                    break
                }
            }
        }
        return dp[n]
    }
}


/*
Solution 1:
BFS with memoization

Time Complexity: O(n^3)
Space Complexity: O(n)
*/
class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        let n = s.count
        var s = Array(s)
        
        var wordDict = Set(wordDict)
        var queue: [Int] = [0]
        var visited = Array(repeating: false, count: n)
        while !queue.isEmpty {
            let start = queue.removeFirst()
            if visited[start] { continue }
            
            visited[start] = true
            for end in (start+1)...n {
                if wordDict.contains(String(s[start..<end])) {
                    queue.append(end)
                    if end == n { 
                        return true
                    }
                }
            }
        }
        return false
    }
}
