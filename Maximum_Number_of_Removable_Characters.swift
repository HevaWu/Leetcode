/*
You are given two strings s and p where p is a subsequence of s. You are also given a distinct 0-indexed integer array removable containing a subset of indices of s (s is also 0-indexed).

You want to choose an integer k (0 <= k <= removable.length) such that, after removing k characters from s using the first k indices in removable, p is still a subsequence of s. More formally, you will mark the character at s[removable[i]] for each 0 <= i < k, then remove all marked characters and check if p is still a subsequence.

Return the maximum k you can choose such that p is still a subsequence of s after the removals.

A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.



Example 1:

Input: s = "abcacb", p = "ab", removable = [3,1,0]
Output: 2
Explanation: After removing the characters at indices 3 and 1, "abcacb" becomes "accb".
"ab" is a subsequence of "accb".
If we remove the characters at indices 3, 1, and 0, "abcacb" becomes "ccb", and "ab" is no longer a subsequence.
Hence, the maximum k is 2.
Example 2:

Input: s = "abcbddddd", p = "abcd", removable = [3,2,1,4,5,6]
Output: 1
Explanation: After removing the character at index 3, "abcbddddd" becomes "abcddddd".
"abcd" is a subsequence of "abcddddd".
Example 3:

Input: s = "abcab", p = "abc", removable = [0,1,2,3,4]
Output: 0
Explanation: If you remove the first index in the array removable, "abc" is no longer a subsequence.


Constraints:

1 <= p.length <= s.length <= 105
0 <= removable.length < s.length
0 <= removable[i] < s.length
p is a subsequence of s.
s and p both consist of lowercase English letters.
The elements in removable are distinct.
*/

/*
Solution 1:
binary search removable part

Time Complexity: O(log nr * ns)
Space Complexity: O(ns + np)
*/
class Solution {
    let dummy = Character("#")

    func maximumRemovals(_ s: String, _ p: String, _ removable: [Int]) -> Int {
        let ns = s.count
        var s = Array(s)

        let np = p.count
        var p = Array(p)

        // use .count as bound, l<=r return r check
        var l = 0
        var r = removable.count
        while l <= r {
            let mid = (r+l)/2

            var temp = s
            for i in 0..<mid {
                temp[removable[i]] = dummy
            }

            if isSub(temp, p, ns, np) {
                l = mid+1
            } else {
                r = mid-1
            }
        }

        return r
    }

    func isSub(_ s: [Character], _ p: [Character],
               _ ns: Int, _ np: Int) -> Bool {
        var i_s = 0
        var i_p = 0

        while i_s < ns, i_p < np {
            let c_s = s[i_s]
            let c_p = p[i_p]
            if c_s != dummy, c_s == c_p {
                i_p += 1
            }
            i_s += 1
        }
        return i_p == np
    }
}

/*
memory limit exceed
*/
class Solution {
    func maximumRemovals(_ s: String, _ p: String, _ removable: [Int]) -> Int {
        let ns = s.count
        var s = Array(s)

        let np = p.count
        var p = Array(p)

        var possible = [Set<Int>]()
        var cur = Set<Int>()
        findPossible(s, p, 0, ns, 0, np, &cur, &possible)

        // print(possible)
        if possible.isEmpty { return 0 }
        let nr = removable.count
        for k in 0..<nr {
            let index = removable[k]
            for t in stride(from: possible.count-1, through: 0, by: -1) {
                if possible[t].contains(index) {
                    possible.remove(at: t)
                }
            }
            if possible.isEmpty {
                return k
            }
        }

        return nr
    }

    func findPossible(_ s: [Character], _ p: [Character],
                      _ i_s: Int, _ ns: Int, _ i_p: Int, _ np: Int,
                      _ cur: inout Set<Int>, _ possible: inout [Set<Int>]) {
        // defer {
        //     print(i_s, i_p, cur)
        // }
        if i_p == np, cur.count == np {
            possible.append(cur)
            return
        }

        guard i_s < ns else { return }
        for i in i_s..<ns {
            if s[i] == p[i_p] {
                cur.insert(i)
                findPossible(s, p, i+1, ns, i_p+1, np, &cur, &possible)
                cur.remove(i)
            }
        }
    }
}