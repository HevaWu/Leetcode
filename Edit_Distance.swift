/*
Given two strings word1 and word2, return the minimum number of operations required to convert word1 to word2.

You have the following three operations permitted on a word:

Insert a character
Delete a character
Replace a character
 

Example 1:

Input: word1 = "horse", word2 = "ros"
Output: 3
Explanation: 
horse -> rorse (replace 'h' with 'r')
rorse -> rose (remove 'r')
rose -> ros (remove 'e')
Example 2:

Input: word1 = "intention", word2 = "execution"
Output: 5
Explanation: 
intention -> inention (remove 't')
inention -> enention (replace 'i' with 'e')
enention -> exention (replace 'n' with 'x')
exention -> exection (replace 'n' with 'c')
exection -> execution (insert 'u')
 

Constraints:

0 <= word1.length, word2.length <= 500
word1 and word2 consist of lowercase English letters.
*/

/*
Solution 3:
DP optimize solution 1 by using 1 array

Time Complexity: O(m*n)
Space Complexity: O(n)
*/
class Solution {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        if word1.isEmpty { return word2.count }
        if word2.isEmpty { return word1.count }
        
        var word1 = Array(word1)
        var word2 = Array(word2)
        
        let m = word1.count
        let n = word2.count
        
        var dp = Array(0...n)
        
        for i in 1...m {
            var pre = dp[0]
            
            // update base 0
            dp[0] = i
            for j in 1...n {
                let temp = dp[j]
                if word1[i-1] == word2[j-1] {
                    dp[j] = pre
                } else {
                    dp[j] = min(pre, min(dp[j-1], dp[j])) + 1
                }
                pre = temp
            }
        }
        
        return dp[n]
    }
}

/*
Solution 2:
optimize solution 1 by using 2 array

Time Complexity: O(m*n)
Space Complexity: O(n)
*/
class Solution {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        if word1.isEmpty { return word2.count }
        if word2.isEmpty { return word1.count }
        
        var word1 = Array(word1)
        var word2 = Array(word2)
        
        let m = word1.count
        let n = word2.count
        
        var pre = Array(0...n)
        var cur = pre
        
        for i in 1...m {
            // update base 0
            cur[0] = i
            for j in 1...n {
                if word1[i-1] == word2[j-1] {
                    cur[j] = pre[j-1]
                } else {
                    cur[j] = min(pre[j-1], min(cur[j-1], pre[j])) + 1
                }
            }
            pre = cur
        }
        
        return cur[n]
    }
}

/*
Solution 1:
DP

1. replace word1[i-1] by word2[j-1]
	dp[i][j] = dp[i-1][j-1] + 1
2. if word1[0..<i] + word2[j-1] = word2[0..<j], 
	insert word2[j-1] into word1[0..<i]
	dp[i][j] = dp[i][j-1] + 1
3. if word1[0..<i-1] = word2[0..<j]
	delete word1[i-1]
	dp[i][j] = dp[i-1][j] + 1

Time Complexity: O(m*n)
Space Complexity: O(m*n)
*/
class Solution {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        if word1.isEmpty { return word2.count }
        if word2.isEmpty { return word1.count }
        
        var word1 = Array(word1)
        var word2 = Array(word2)
        
        let m = word1.count
        let n = word2.count
        
        // dp[i][j] -> operations from word1[0...i] to word2[0...j]
        var dp = Array(repeating: Array(repeating: 0, count: n+1), 
                       count: m+1)
        
        // set dp[i][0] base case
        for i in 1...m {
            dp[i][0] = i
        }
        
        // set dp[0][j] base case
        for j in 1...n {
            dp[0][j] = j
        }
        
        for i in 1...m {
            for j in 1...n {
                if word1[i-1] == word2[j-1] {
                    dp[i][j] = dp[i-1][j-1]
                } else {
                    // 1. replace word1[i-1] by word2[j-1]
                    //    dp[i][j] = dp[i-1][j-1] + 1
                    // 2. if word1[0..<i] + word2[j-1] = word2[0..<j], 
                    //    insert word2[j-1] into word1[0..<i]
                    //    dp[i][j] = dp[i][j-1] + 1
                    // 3. if word1[0..<i-1] = word2[0..<j]
                    //    delete word1[i-1]
                    //    dp[i][j] = dp[i-1][j] + 1
                    dp[i][j] = min(dp[i-1][j-1], 
                                   min(dp[i][j-1], dp[i-1][j])) + 1
                }
            }
        }
        
        return dp[m][n]
    }
}