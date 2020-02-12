// To some string S, we will perform some replacement operations that replace groups of letters with new ones (not necessarily the same size).

// Each replacement operation has 3 parameters: a starting index i, a source word x and a target word y.  The rule is that if x starts at position i in the original string S, then we will replace that occurrence of x with y.  If not, we do nothing.

// For example, if we have S = "abcd" and we have some replacement operation i = 2, x = "cd", y = "ffff", then because "cd" starts at position 2 in the original string S, we will replace it with "ffff".

// Using another example on S = "abcd", if we have both the replacement operation i = 0, x = "ab", y = "eee", as well as another replacement operation i = 2, x = "ec", y = "ffff", this second operation does nothing because in the original string S[2] = 'c', which doesn't match x[0] = 'e'.

// All these operations occur simultaneously.  It's guaranteed that there won't be any overlap in replacement: for example, S = "abc", indexes = [0, 1], sources = ["ab","bc"] is not a valid test case.

// Example 1:

// Input: S = "abcd", indexes = [0,2], sources = ["a","cd"], targets = ["eee","ffff"]
// Output: "eeebffff"
// Explanation: "a" starts at index 0 in S, so it's replaced by "eee".
// "cd" starts at index 2 in S, so it's replaced by "ffff".
// Example 2:

// Input: S = "abcd", indexes = [0,2], sources = ["ab","ec"], targets = ["eee","ffff"]
// Output: "eeecd"
// Explanation: "ab" starts at index 0 in S, so it's replaced by "eee".
// "ec" doesn't starts at index 2 in the original S, so we do nothing.
// Notes:

// 0 <= indexes.length = sources.length = targets.length <= 100
// 0 < indexes[i] < S.length <= 1000
// All characters in given inputs are lowercase letters.

// Solution 1: Direct search
// Use a matchArr to help memorizing if this string are matched and should be replaced.
// matchArr[sindex] = replaceIndex
//
// Time Complexity: O(NQ), where NN is the length of S, and we have QQ replacement operations. (Our complexity could be faster with a more accurate implementation, but it isn't necessary.)
// Space Complexity: O(N), if we consider targets[i].length <= 100 as a constant bound.
class Solution {
    func findReplaceString(_ S: String, _ indexes: [Int], _ sources: [String], _ targets: [String]) -> String {
        var matchArr = Array(repeating: -1, count: S.count)
        var S = Array(S)
        for (i, ivalue) in indexes.enumerated() {
            if Array(S[ivalue...(ivalue + sources[i].count - 1)]) == Array(sources[i]) {
                // replacable
                matchArr[ivalue] = i
            }
        }

        var finalS = String()
        var index = 0
        while index < matchArr.count {
            if matchArr[index] >= 0 {
                finalS.append(targets[matchArr[index]])
                index += sources[matchArr[index]].count
            } else {
                finalS.append(S[index])
                index += 1
            }
        }
        return finalS
    }
}