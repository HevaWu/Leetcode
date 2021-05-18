/*
Two strings X and Y are similar if we can swap two letters (in different positions) of X, so that it equals Y. Also two strings X and Y are similar if they are equal.

For example, "tars" and "rats" are similar (swapping at positions 0 and 2), and "rats" and "arts" are similar, but "star" is not similar to "tars", "rats", or "arts".

Together, these form two connected groups by similarity: {"tars", "rats", "arts"} and {"star"}.  Notice that "tars" and "arts" are in the same group even though they are not similar.  Formally, each group is such that a word is in the group if and only if it is similar to at least one other word in the group.

We are given a list strs of strings where every string in strs is an anagram of every other string in strs. How many groups are there?



Example 1:

Input: strs = ["tars","rats","arts","star"]
Output: 2
Example 2:

Input: strs = ["omv","ovm"]
Output: 1


Constraints:

1 <= strs.length <= 300
1 <= strs[i].length <= 300
strs[i] consists of lowercase letters only.
All words in strs have the same length and are anagrams of each other.
*/

/*
Solution 1:
union find

union two string if they are similar to each other

Time Complexity: O(n*n * k)
- k is strs[i].count

Space Complexity: O(n)
*/
class Solution {
    func numSimilarGroups(_ strs: [String]) -> Int {
        let n = strs.count
        var uf = UF(n)

        for i in 1..<n {
            for j in 0..<i {
                if isSimilar(strs[i], strs[j]) {
                    uf.union(i, j)
                }
            }
        }

        var groups = Set<Int>()
        for i in 0..<n {
            groups.insert(uf.find(i))
        }
        return groups.count
    }

    func isSimilar(_ str1: String, _ str2: String) -> Bool {
        var diff: (first: Character, second: Character)? = nil
        for i in str1.indices {
            if str1[i] == str2[i] { continue }
            if let preDiff = diff {
                if preDiff != (str2[i], str1[i]) { return false }
            } else {
                diff = (str1[i], str2[i])
            }
        }
        return true
    }
}

class UF {
    var parent: [Int]
    init(_ n: Int) {
        parent = Array(0..<n)
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func union(_ x: Int, _ y: Int) {
        parent[find(x)] = find(y)
    }
}