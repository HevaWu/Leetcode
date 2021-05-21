/*
Strings s1 and s2 are k-similar (for some non-negative integer k) if we can swap the positions of two letters in s1 exactly k times so that the resulting string equals s2.

Given two anagrams s1 and s2, return the smallest k for which s1 and s2 are k-similar.



Example 1:

Input: s1 = "ab", s2 = "ba"
Output: 1
Example 2:

Input: s1 = "abc", s2 = "bca"
Output: 2
Example 3:

Input: s1 = "abac", s2 = "baca"
Output: 2
Example 4:

Input: s1 = "aabc", s2 = "abca"
Output: 2


Constraints:

1 <= s1.length <= 20
s2.length == s1.length
s1 and s2 contain only lowercase letters from the set {'a', 'b', 'c', 'd', 'e', 'f'}.
s2 is an anagram of s1.
*/

/*
Solution 1:
BFS

find minimum swaps to make s1==s2

push same swap count string in queue, then check each of them, if next swap can make cur==s2

swap only pair at each step,
use BFS to guarantee shortest path

Time Complexity: O(diff)
Space Complexity: O(diff)
*/
class Solution {
    func kSimilarity(_ s1: String, _ s2: String) -> Int {
        if s1 == s2 { return 0 }

        let n = s1.count

        var s1 = Array(s1)
        var s2 = Array(s2)

        var visited = Set<[Character]>()
        var queue = [[Character]]()
        queue.append(s1)
        visited.insert(s1)

        var res = 0

        while !queue.isEmpty {
            res += 1

            // check current same swap count
            for k in 0..<queue.count {
                let cur = queue.removeFirst()

                var i = 0
                while cur[i] == s2[i] { i += 1 }

                var j = i+1
                while j < n {
                    if cur[j] == s2[j] || cur[j] != s2[i] {
                        j += 1
                        continue
                    }

                    var temp = cur
                    temp.swapAt(i, j)

                    if temp == s2 { return res }

                    if visited.insert(temp).inserted {
                        queue.append(temp)
                    }
                    j += 1
                }
            }

            // print(queue)
        }

        return res
    }
}