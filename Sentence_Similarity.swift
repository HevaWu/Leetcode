// Given two sentences words1, words2 (each represented as an array of strings), and a list of similar word pairs pairs, determine if two sentences are similar.

// For example, "great acting skills" and "fine drama talent" are similar, if the similar word pairs are pairs = [["great", "fine"], ["acting","drama"], ["skills","talent"]].

// Note that the similarity relation is not transitive. For example, if "great" and "fine" are similar, and "fine" and "good" are similar, "great" and "good" are not necessarily similar.

// However, similarity is symmetric. For example, "great" and "fine" being similar is the same as "fine" and "great" being similar.

// Also, a word is always similar with itself. For example, the sentences words1 = ["great"], words2 = ["great"], pairs = [] are similar, even though there are no specified similar word pairs.

// Finally, sentences can only be similar if they have the same number of words. So a sentence like words1 = ["great"] can never be similar to words2 = ["doubleplus","good"].

// Note:

// The length of words1 and words2 will not exceed 1000.
// The length of pairs will not exceed 2000.
// The length of each pairs[i] will be 2.
// The length of each words[i] and pairs[i][j] will be in the range [1, 20].
 
// Solution 1: 
// build map list 
// 
// Time complexity: O(N+P)
// Space complexity: O(P)
class Solution {
    func areSentencesSimilar(_ words1: [String], _ words2: [String], _ pairs: [[String]]) -> Bool {
        guard words1.count == words2.count else { return false }
        if pairs.isEmpty { return words1 == words2 }
        
        let n = words1.count
        var map = [String: Set<String>]()
        
        for pair in pairs {
            map[pair[0], default: Set<String>()].insert(pair[1])
            map[pair[1], default: Set<String>()].insert(pair[0])
        }
        
        for i in 0..<n {
            if words1[i] == words2[i] { continue }
            if let list = map[words1[i]], list.contains(words2[i]) { 
                continue
            } else {
                return false
            }
        }
        return true
    }
}
