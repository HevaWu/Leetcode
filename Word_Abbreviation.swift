// Given an array of n distinct non-empty strings, you need to generate minimal possible abbreviations for every word following rules below.

// Begin with the first character and then the number of characters abbreviated, which followed by the last character.
// If there are any conflict, that is more than one words share the same abbreviation, a longer prefix is used instead of only the first character until making the map from word to abbreviation become unique. In other words, a final abbreviation cannot map to more than one original words.
// If the abbreviation doesn't make the word shorter, then keep it as original.
// Example:
// Input: ["like", "god", "internal", "me", "internet", "interval", "intension", "face", "intrusion"]
// Output: ["l2e","god","internal","me","i6t","interval","inte4n","f2e","intr4n"]
// Note:
// Both n and the length of each word will not exceed 400.
// The length of each word is greater than 1.
// The words consist of lowercase English letters only.
// The return answers should be in the same order as the original array.

// Solution 1: map + commonPrefix
// Two words are only eligible to have the same abbreviation if they have the same first letter, last letter, and length. Let's group each word based on these properties, and then sort out the conflicts.
// In each group G, if a word W has a longest common prefix P with any other word X in G, then our abbreviation must contain a prefix of more than |P| characters. The longest common prefixes must occur with words adjacent to W (in lexicographical order), so we can just sort G and look at the adjacent words.
// 
// Time Complexity: O(C \log C)O(ClogC) where CC is the number of characters across all words in the given array. The complexity is dominated by the sorting step.
// Space Complexity: O(C)O(C).
class Solution {
    func wordsAbbreviation(_ dict: [String]) -> [String] {
        guard !dict.isEmpty else { return [String]() }
        
        // key is the abbrev
        // value is this (word, index)
        var map = [String: [(String, Int)]]()
        
        for i in 0..<dict.count {
            var temp = getAbbrev(dict[i], 0)
            map[temp, default: [(String, Int)]()].append((dict[i], i))
        }
        
        var abbrList = dict
        for list in map.values {
            var tempList = list.sorted(by: { first, second -> Bool in
                return first.0 < second.0
            })
            
            var leftList = Array(repeating: 0, count: tempList.count)
            for i in 1..<tempList.count {
                var prefix = tempList[i-1].0.commonPrefix(with: tempList[i].0).count
                leftList[i] = prefix
                leftList[i-1] = max(leftList[i-1], prefix)
            }
            
            for i in 0..<tempList.count {
                abbrList[tempList[i].1] = getAbbrev(tempList[i].0, leftList[i])
            }
        }
        
        return abbrList
    }
    
    func getAbbrev(_ str: String, _ left: Int) -> String {
        let n = str.count
        if n - left <= 3 { return str }
        return String(str.prefix(left+1) + String(n-left-2) + String(str.last!))
    }
}

// Solution 2: Trie
// let's group words based on length, first letter, and last letter, and discuss when words in a group do not share a longest common prefix.
// Put the words of a group into a trie (prefix tree), and count at each node (representing some prefix P) the number of words with prefix P. If the count is 1, we know the prefix is unique.
// 
// Time Complexity: O(C)O(C) where CC is the number of characters across all words in the given array.
// Space Complexity: O(C)O(C).