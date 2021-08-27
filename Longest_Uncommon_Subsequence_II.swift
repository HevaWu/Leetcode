/*
Given an array of strings strs, return the length of the longest uncommon subsequence between them. If the longest uncommon subsequence does not exist, return -1.

An uncommon subsequence between an array of strings is a string that is a subsequence of one string but not the others.

A subsequence of a string s is a string that can be obtained after deleting any number of characters from s.

For example, "abc" is a subsequence of "aebdc" because you can delete the underlined characters in "aebdc" to get "abc". Other subsequences of "aebdc" include "aebdc", "aeb", and "" (empty string).


Example 1:

Input: strs = ["aba","cdc","eae"]
Output: 3
Example 2:

Input: strs = ["aaa","aaa","aa"]
Output: -1


Constraints:

1 <= strs.length <= 50
1 <= strs[i].length <= 10
strs[i] consists of lowercase English letters.
*/

/*
Solution 1:
sort + longest substring checking

sort by decreasing length
find longest NON duplicates string, and this string is not previous longer string's subsequence.

Time Complexity: O(nlogn + longest string count)
Space Complexity: O(n)
*/
class Solution {
    func findLUSlength(_ strs: [String]) -> Int {
        var strs = strs.sorted(by: { first, second -> Bool in
            return first.count > second.count
        })
        let n = strs.count

        var duplicates = getDuplicated(strs)
        // print(duplicates)

        for i in 0..<n {
            guard !duplicates.contains(strs[i]) else { continue }
            // first string is unique, first longest string will be longest uncommon string
            if i == 0 { return strs[0].count }

            var j = 0
            while j < i {
                if isSubsequence(strs[i], strs[j]) { break }
                j += 1
            }

            // if previous longer string not contains current ith string,
            // return ith string as Longest uncommon string
            if j == i {
                return strs[i].count
            }
        }
        return -1
    }

    // return true if str1 is subsequence of str2
    func isSubsequence(_ str1: String, _ str2: String) -> Bool {
        var str1 = Array(str1)
        var str2 = Array(str2)

        var i = 0
        var j = 0

        while i < str1.count, j < str2.count {
            if str1[i] == str2[j] {
                i += 1
                j += 1
            } else {
                j += 1
            }
        }
        return i == str1.count
    }

    // return set of duplicate strings
    func getDuplicated(_ strs: [String]) -> Set<String> {
        var cur = Set<String>()
        var res = Set<String>()
        for str in strs {
            if cur.contains(str) {
                res.insert(str)
            }
            cur.insert(str)
        }
        return res
    }
}