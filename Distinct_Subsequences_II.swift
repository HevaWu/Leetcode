/*
Given a string S, count the number of distinct, non-empty subsequences of S .

Since the result may be large, return the answer modulo 10^9 + 7.

 

Example 1:

Input: "abc"
Output: 7
Explanation: The 7 distinct subsequences are "a", "b", "c", "ab", "ac", "bc", and "abc".
Example 2:

Input: "aba"
Output: 6
Explanation: The 6 distinct subsequences are "a", "b", "ab", "ba", "aa" and "aba".
Example 3:

Input: "aaa"
Output: 3
Explanation: The 3 distinct subsequences are "a", "aa" and "aaa".
 

 

Note:

S contains only lowercase letters.
1 <= S.length <= 2000
*/

/*
Solution 1: 
Sum end 
always caculate res that end with same characters.
There will be sum(end) different subsequence.
Each time we append char, we compare and add it to the above subsequences.

ex:
Input: "aba"
Current parsed: "ab"
endswith 'a': ["a"]
endswith 'b': ["ab","b"]
"a" -> "aa"
"ab" -> "aba"
"b" -> "ba"
"" -> "a"
endswith 'a': ["aa","aba","ba","a"]
endswith 'b': ["ab","b"]

Time Complexity:
O(26n) which can optimized to O(n)
*/
class Solution {
    func distinctSubseqII(_ S: String) -> Int {
        guard !S.isEmpty else { return 0 }
        let S = Array(S)
        let mod = Int(1e9 + 7)
        
        var end = Array(repeating: 0, count: 26)
        let a = Int(Character("a").asciiValue!)
        
        var added = 0
        var res = 0
        for c in S {
            let index = Int(c.asciiValue!) - a
            added = (res - end[index] + 1) % mod
            res = (res + added) % mod
            end[index] = (end[index] + added) % mod
        }
        return (res + mod) % mod
    }
}

/*
Solution 2: DP
end char array

idea: 
dp[i] means current subsequence end with i characters
Each time, for new char, compare it with previous char, if it is distinct to it, add it 
if s[j] != s[i], dp[i] += dp[j]
if s[j] == s[i], do nothing to avoid duplicates.

Time complexity: O(n^2)
*/
class Solution {
    func distinctSubseqII(_ S: String) -> Int {
        guard !S.isEmpty else { return 0 }
        let S = Array(S)
        let n = S.count
        let mod = Int(1e9 + 7)
        
        var dp = Array(repeating: 1, count: n)
        
        var res = 0
        for i in 0..<n {
            var j = 0
            while j < i {
                if S[i] != S[j] {
                    dp[i] = (dp[i] + dp[j]) % mod
                }
                j += 1
            }
            res = (res + dp[i]) % mod
        }
        return res
    }
}