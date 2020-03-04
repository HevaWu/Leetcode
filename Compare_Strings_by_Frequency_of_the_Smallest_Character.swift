// Let's define a function f(s) over a non-empty string s, which calculates the frequency of the smallest character in s. For example, if s = "dcce" then f(s) = 2 because the smallest character is "c" and its frequency is 2.

// Now, given string arrays queries and words, return an integer array answer, where each answer[i] is the number of words such that f(queries[i]) < f(W), where W is a word in words.

 

// Example 1:

// Input: queries = ["cbd"], words = ["zaaaz"]
// Output: [1]
// Explanation: On the first query we have f("cbd") = 1, f("zaaaz") = 3 so f("cbd") < f("zaaaz").
// Example 2:

// Input: queries = ["bbb","cc"], words = ["a","aa","aaa","aaaa"]
// Output: [1,2]
// Explanation: On the first query only f("bbb") < f("aaaa"). On the second query both f("aaa") and f("aaaa") are both > f("cc").
 

// Constraints:

// 1 <= queries.length <= 2000
// 1 <= words.length <= 2000
// 1 <= queries[i].length, words[i].length <= 10
// queries[i][j], words[i][j] are English lowercase letters.

// Solution 1: binary search
// count the f for each words, and put then into an array
// sort the array
// for each query, binary search to find the number larger than current f(query)
// 
// Time complexity: O(m + mlogm + nlogm) m is words.length, n is query length
// Space complexity: O(m + n)
class Solution {
    func numSmallerByFrequency(_ queries: [String], _ words: [String]) -> [Int] {
        var wfreq = [Int]()
        for word in words {
            wfreq.append(checkFreq(word))
        }
        wfreq.sort()
        
        var smallArr = [Int]()
        var left = 0
        var right = wfreq.count
        var mid = 0
        for query in queries {
            let freq = checkFreq(query)
            
            left = 0
            right = wfreq.count-1
            while left <= right {
                mid = (left+right+1)/2
                if wfreq[mid] <= freq {
                    left = mid+1
                } else {
                    right = mid-1
                }
            }
            // +1 for the count
            smallArr.append(wfreq.count-left)
        }
        return smallArr
    }
    
    // count f(s)
    func checkFreq(_ word: String) -> Int {
        var map = [Character: Int]()
        for w in word {
            map[w, default: 0] += 1
        }
        return map[map.keys.min()!]!
    }
}



class Solution {
    func numSmallerByFrequency(_ queries: [String], _ words: [String]) -> [Int] {
        var fwords = words.reduce(into: [Int: Int]()) { res, word in 
            let freq = checkFreq(word)
            res[freq, default: 0] += 1
        }
        
        return queries.reduce(into: [Int]()) { res, query in
            let freq = checkFreq(query)
            var count = 0
            for i in fwords.keys {
                if i > freq {
                    count += fwords[i]!
                }
            }
            res.append(count)
        }
    }
    
    // count f(s)
    func checkFreq(_ word: String) -> Int {
        var lowestAsciiValue: UInt8 = Character("z").asciiValue! + 1
        var lowestCount = 0
        for w in word {
            if w.asciiValue! < lowestAsciiValue {
                lowestAsciiValue = w.asciiValue!
                lowestCount = 1
            } else if w.asciiValue! == lowestAsciiValue {
                lowestCount += 1
            }
        }
        return lowestCount
    }
}