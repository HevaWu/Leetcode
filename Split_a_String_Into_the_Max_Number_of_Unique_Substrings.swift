/*
Given a string s, return the maximum number of unique substrings that the given string can be split into.

You can split string s into any list of non-empty substrings, where the concatenation of the substrings forms the original string. However, you must split the substrings such that all of them are unique.

A substring is a contiguous sequence of characters within a string.



Example 1:

Input: s = "ababccc"
Output: 5
Explanation: One way to split maximally is ['a', 'b', 'ab', 'c', 'cc']. Splitting like ['a', 'b', 'a', 'b', 'c', 'cc'] is not valid as you have 'a' and 'b' multiple times.
Example 2:

Input: s = "aba"
Output: 2
Explanation: One way to split maximally is ['a', 'ba'].
Example 3:

Input: s = "aa"
Output: 1
Explanation: It is impossible to split the string any further.


Constraints:

1 <= s.length <= 16

s contains only lower case English letters.
*/

/*
Solution 1:
backtracking

check all possiblities, and compare which split is maximum

Time Complexity: O(n!)
Space Complexity: O(n)
*/
class Solution {
    func maxUniqueSplit(_ s: String) -> Int {
        let n = s.count
        var s = Array(s)

        var visited = Set<String>()
        var split = 0
        check(0, n, s, &split, &visited)
        return split
    }

    func check(_ index: Int, _ n: Int, _ s: [Character],
               _ split: inout Int, _ visited: inout Set<String>) {
        if index == n {
            split = max(split, visited.count)
            return
        }

        for i in index..<n {
            let str = String(s[index...i])
            if !visited.contains(str) {
                visited.insert(str)
                check(i+1, n, s, &split, &visited)
                visited.remove(str)
            }
        }
    }
}