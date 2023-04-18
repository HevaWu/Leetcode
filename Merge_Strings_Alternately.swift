/*
You are given two strings word1 and word2. Merge the strings by adding letters in alternating order, starting with word1. If a string is longer than the other, append the additional letters onto the end of the merged string.

Return the merged string.



Example 1:

Input: word1 = "abc", word2 = "pqr"
Output: "apbqcr"
Explanation: The merged string will be merged as so:
word1:  a   b   c
word2:    p   q   r
merged: a p b q c r
Example 2:

Input: word1 = "ab", word2 = "pqrs"
Output: "apbqrs"
Explanation: Notice that as word2 is longer, "rs" is appended to the end.
word1:  a   b
word2:    p   q   r   s
merged: a p b q   r   s
Example 3:

Input: word1 = "abcd", word2 = "pq"
Output: "apbqcd"
Explanation: Notice that as word1 is longer, "cd" is appended to the end.
word1:  a   b   c   d
word2:    p   q
merged: a p b q c   d


Constraints:

1 <= word1.length, word2.length <= 100
word1 and word2 consist of lowercase English letters.
*/

/*
Solution 1:
iterate add two string

Time Complexity: O(n1+n2)
Space Complexity: O(n1 + n2)
*/
class Solution {
    func mergeAlternately(_ word1: String, _ word2: String) -> String {
        var word1 = Array(word1)
        var word2 = Array(word2)
        var i1 = 0
        var i2 = 0
        var n1 = word1.count
        var n2 = word2.count
        var isFirst = true
        var newStr = ""
        while i1 < n1, i2 < n2 {
            if isFirst {
                newStr.append(word1[i1])
                i1 += 1
            } else {
                newStr.append(word2[i2])
                i2 += 1
            }
            isFirst = !isFirst
        }

        if i1 < n1 {
            newStr.append(contentsOf: word1[i1...])
        }
        if i2 < n2 {
            newStr.append(contentsOf: word2[i2...])
        }
        return newStr
    }
}
