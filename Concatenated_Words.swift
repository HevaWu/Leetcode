/*
Given an array of strings words (without duplicates), return all the concatenated words in the given list of words.

A concatenated word is defined as a string that is comprised entirely of at least two shorter words in the given array.



Example 1:

Input: words = ["cat","cats","catsdogcats","dog","dogcatsdog","hippopotamuses","rat","ratcatdogcat"]
Output: ["catsdogcats","dogcatsdog","ratcatdogcat"]
Explanation: "catsdogcats" can be concatenated by "cats", "dog" and "cats";
"dogcatsdog" can be concatenated by "dog", "cats" and "dog";
"ratcatdogcat" can be concatenated by "rat", "cat", "dog" and "cat".
Example 2:

Input: words = ["cat","dog","catdog"]
Output: ["catdog"]


Constraints:

1 <= words.length <= 104
0 <= words[i].length <= 1000
words[i] consists of only lowercase English letters.
0 <= sum(words[i].length) <= 6 * 105
*/

/*
Solution 2:
DP

- sort array by length first < second
- each time, check if current can be concatenated by previous words
- in concatenated check, use dp

Time Complexity: O(mlogm + m*n*n)
- m is words.count
- n is max word.count

Space Complexity: O(m + n)
*/
class Solution {
    func findAllConcatenatedWordsInADict(_ words: [String]) -> [String] {
        var set = Set<String>()
        var res = [String]()

        var words = words.sorted(by: { first, second -> Bool in
            return first.count < second.count
        })

        for word in words {
            if isConcatenated(word, set) {
                res.append(word)
            }
            set.insert(word)
        }

        return res
    }

    func isConcatenated(_ word: String, _ set: Set<String>) -> Bool {
        // empty word is not cancatenated string
        if set.isEmpty { return false }
        var word = Array(word)
        let n = word.count
        var dp = Array(repeating: false, count: n+1)
        dp[0] = true

        for i in 1...n {
            for j in stride(from: i-1, through: 0, by:-1) {
                if dp[j] == false { continue }
                if set.contains(String(word[j..<i])) {
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
Time Limit Exceeded
*/
class Solution {
    func findAllConcatenatedWordsInADict(_ words: [String]) -> [String] {
        var set = Set(words)
        var res = [String]()
        var cache = [String: Bool]()
        return words.filter { isConcatenated($0, set, &cache) }
    }

    func isConcatenated(_ word: String, _ set: Set<String>,
                        _ cache: inout [String: Bool]) -> Bool {
        // empty word is not cancatenated string
        if word.isEmpty { return false }

        if let val = cache[word] { return val }

        for i in 1..<word.count {
            let index = word.index(word.startIndex, offsetBy: i)
            let leftHalf = String(word[..<index])
            let rightHalf = String(word[index...])
            if (
                cache[leftHalf] ?? false
                || set.contains(leftHalf)
                || isConcatenated(leftHalf, set, &cache)
            )
            && (
                cache[rightHalf] ?? false
                || set.contains(rightHalf)
                || isConcatenated(rightHalf, set, &cache)
            ) {
                cache[word] = true
                return true
            }
        }
        cache[word] = false
        return false
    }
}