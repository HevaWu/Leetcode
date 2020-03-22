// Given a list of words, each word consists of English lowercase letters.

// Let's say word1 is a predecessor of word2 if and only if we can add exactly one letter anywhere in word1 to make it equal to word2.  For example, "abc" is a predecessor of "abac".

// A word chain is a sequence of words [word_1, word_2, ..., word_k] with k >= 1, where word_1 is a predecessor of word_2, word_2 is a predecessor of word_3, and so on.

// Return the longest possible length of a word chain with words chosen from the given list of words.

 

// Example 1:

// Input: ["a","b","ba","bca","bda","bdca"]
// Output: 4
// Explanation: one of the longest word chain is "a","ba","bda","bdca".
 

// Note:

// 1 <= words.length <= 1000
// 1 <= words[i].length <= 16
// words[i] only consists of English lowercase letters.

// hint
// For each word in order of length, for each word2 which is word with one character removed, length[word2] = max(length[word2], length[word] + 1).

// Solution 1: DP
// Sort the words by word's length. (also can apply bucket sort)
// For each word, loop on all possible previous word with 1 letter missing.
// If we have seen this previous word, update the longest chain for the current word.
// Finally return the longest word chain.
// 
// Time complexity: O(nlogn + n*word.len)
// Space complexity: O(n)
class Solution {
    func longestStrChain(_ words: [String]) -> Int {
        var words = words.sorted(by: { first, second -> Bool in
            return first.count < second.count
        })
        
        var len = 0
        var dp = [String: Int]()
        
        for word in words {
            var temp = 0
            for i in word.indices {
                var str = word
                str.remove(at: i)
                temp = max(temp, dp[str, default: 0] + 1)
            }
            dp[word] = temp
            len = max(len, temp)
        }
        return len
    }
}

class Solution {
    func longestStrChain(_ words: [String]) -> Int {
        var words = words.sorted(by: { first, second -> Bool in
            return first.count < second.count
        })
        
        var dp = [String: Int]()
        var maxLen = 0
        for word in words {
            for i in word.indices {
                var temp = word
                temp.remove(at: i)
                if dp[temp] != nil {
                    dp[word] = max(dp[word, default: 1], dp[temp]! + 1)   
                }
            }
            if dp[word] == nil { dp[word] = 1 }
            maxLen = max(maxLen, dp[word]!)
        }
        return maxLen
    }
}