/*
Given a string s, partition s such that every substring of the partition is a palindrome. Return all possible palindrome partitioning of s.

A palindrome string is a string that reads the same backward as forward.

 

Example 1:

Input: s = "aab"
Output: [["a","a","b"],["aa","b"]]
Example 2:

Input: s = "a"
Output: [["a"]]
 

Constraints:

1 <= s.length <= 16
s contains only lowercase English letters.
*/

/*
Solution 1:
backTrack
1. use cur to memo current finded palindrome
2. search remaining by (index,i), if this sub is palindrome, append it into cur
3. for find (index, i+1), remove cur.last component first

In the backtracking algorithm, we recursively traverse over the string in depth-first search fashion. For each recursive call, the beginning index of the string is given as start.
- Iteratively generate all possible substrings beginning at start index. The end index increments from start till the end of the string.
- For each of the substring generated, check if it is a palindrome.
- If the substring is a palindrome, the substring is a potential candidate. Add substring to the currentList and perform a depth-first search on the remaining substring. If current substring ends at index end, end+1 becomes the start index for the next recursive call.
- Backtrack if start index is greater than or equal to the string length and add the currentList to the result.

Time Complexity:
O(n* 2^n)
where nN is the length of string s. This is the worst-case time complexity when all the possible substrings are palindrome.

Space Complexity:
O(n)
*/
class Solution {
    func partition(_ s: String) -> [[String]] {
        if s.count == 1 { return [[s]] }
        
        var res = [[String]]()
        var s = Array(s)
        
        // check if (i, j) is palindrome in s
        let isPalindrome: (Int, Int) -> Bool = { i, j in
            var i = i
            var j = j
            while i < j {
                if s[i] != s[j] {
                    return false
                }
                i += 1
                j -= 1
            }
            return true         
        }
        
        var cur = [String]()
        func backTrack(_ index: Int) {
            if cur.count > 0, index >= s.count {
                res.append(cur)
            }
            
            for i in index..<s.count {
                if isPalindrome(index, i) {
                    cur.append(String(s[index...i]))
                    backTrack(i+1)
                    cur.remove(at: cur.count-1)
                }
            }
        }
        
        backTrack(0)
        return res
    }
}


/*
Solution 2: DP
use cache to store if i,j is palindrome

dp[n] is [[String]]() type object
dp[i+1]:
- if left,i is palindrome, for loop dp[left], append s[left...i] to dp[i+1]

Time Complexity:
O(n* 2^n)

Space Complexity: 
O(n^2)
*/
class Solution {
    func partition(_ s: String) -> [[String]] {
        if s.count == 1 { return [[s]] }
        
        var s = Array(s)
        let n = s.count
        
        // cache if i, j is palindrome
        var cache = Array(repeating: Array(repeating: false, count: n), count: n)
        var dp = Array(repeating: [[String]](), count: n+1)
        for i in 0..<n {
            for left in 0...i {
                if s[left] == s[i], 
                (i-left <= 1 || cache[left+1][i-1] == true) {
                    cache[left][i] = true
                    let sub = String(s[left...i])
                    if dp[left].isEmpty {
                        dp[i+1].append([sub])
                        continue 
                    }
                    for r in dp[left] {
                        var temp = r
                        temp.append(sub)
                        dp[i+1].append(temp)
                    }
                }
            }
        }
        return dp[n]
    }
}
