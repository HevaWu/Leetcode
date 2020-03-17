// Given two sentences words1, words2 (each represented as an array of strings), and a list of similar word pairs pairs, determine if two sentences are similar.

// For example, words1 = ["great", "acting", "skills"] and words2 = ["fine", "drama", "talent"] are similar, if the similar word pairs are pairs = [["great", "good"], ["fine", "good"], ["acting","drama"], ["skills","talent"]].

// Note that the similarity relation is transitive. For example, if "great" and "good" are similar, and "fine" and "good" are similar, then "great" and "fine" are similar.

// Similarity is also symmetric. For example, "great" and "fine" being similar is the same as "fine" and "great" being similar.

// Also, a word is always similar with itself. For example, the sentences words1 = ["great"], words2 = ["great"], pairs = [] are similar, even though there are no specified similar word pairs.

// Finally, sentences can only be similar if they have the same number of words. So a sentence like words1 = ["great"] can never be similar to words2 = ["doubleplus","good"].

// Note:

// The length of words1 and words2 will not exceed 1000.
// The length of pairs will not exceed 2000.
// The length of each pairs[i] will be 2.
// The length of each words[i] and pairs[i][j] will be in the range [1, 20].

// Solution 1: DSU(disjoint set union) union find
// union the pairs
// then compare 2 word in words1 & words2
// 
// Time Complexity: O(N \log P + P)O(NlogP+P), where NN is the maximum length of words1 and words2, and PP is the length of pairs. If we used union-by-rank, this complexity improves to O(N * \alpha(P) + P) \approx O(N + P)O(N∗α(P)+P)≈O(N+P), where \alphaα is the Inverse-Ackermann function.
// Space Complexity: O(P)O(P), the size of pairs.
class Solution {
    func areSentencesSimilarTwo(_ words1: [String], _ words2: [String], _ pairs: [[String]]) -> Bool {
        guard !pairs.isEmpty, words1.count == words2.count else { return words1 == words2 }
        
        var uf = UF()
        for pair in pairs {
            uf.unify(pair[0], pair[1])
        }
                        
        for i in 0..<words1.count {
            if uf.find(words1[i]) != uf.find(words2[i]) {
                return false
            }
        }
        return true
    }
}

class UF {
    var parent = [String: String]()
    init() { }
    
    func find(_ x: String) -> String {
        if parent[x, default: x] != x {
            parent[x] = find(parent[x, default: x])
        }
        return parent[x, default: x]
    }
    
    func unify(_ x: String, _ y: String) {
        parent[find(x)] = find(y)
    }
}

// Solution 2: DFS
// Two words are similar if they are the same, or there is a path connecting them from edges represented by pairs.
// We can check whether this path exists by performing a depth-first search from a word and seeing if we reach the other word. The search is performed on the underlying graph specified by the edges in pairs.
// 
// We start by building our graph from the edges in pairs.
// The specific algorithm we go for is an iterative depth-first search. The implementation we go for is a typical "visitor pattern": when searching whether there is a path from w1 = words1[i] to w2 = words2[i], stack will contain all the nodes that are queued up for processing, while seen will be all the nodes that have been queued for processing (whether they have been processed or not).
// 
// Time Complexity: O(NP)O(NP), where NN is the maximum length of words1 and words2, and PP is the length of pairs. Each of NN searches could search the entire graph.
// Space Complexity: O(P)O(P), the size of pairs.