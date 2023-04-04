/*
Given a string s, partition the string into one or more substrings such that the characters in each substring are unique. That is, no letter appears in a single substring more than once.

Return the minimum number of substrings in such a partition.

Note that each character should belong to exactly one substring in a partition.



Example 1:

Input: s = "abacaba"
Output: 4
Explanation:
Two possible partitions are ("a","ba","cab","a") and ("ab","a","ca","ba").
It can be shown that 4 is the minimum number of substrings needed.
Example 2:

Input: s = "ssssss"
Output: 6
Explanation:
The only valid partition is ("s","s","s","s","s","s").


Constraints:

1 <= s.length <= 105
s consists of only English lowercase letters.
*/

/*
Solution 1:
Set to check unique char
once find current char is exist before
reset set, increase partition number

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func partitionString(_ s: String) -> Int {
        var s = Array(s)
        var charSet = Set<Character>()
        let n = s.count
        var partition = 0
        for i in 0..<n {
            if charSet.contains(s[i]) {
                partition += 1
                // print(i, charSet)
                charSet = Set<Character>()
            }
            charSet.insert(s[i])
        }
        if !charSet.isEmpty {
            partition += 1
        }
        return partition
    }
}
