/*
Given an array of strings words, return the smallest string that contains each string in words as a substring. If there are multiple valid strings of the smallest length, return any of them.

You may assume that no string in words is a substring of another string in words.



Example 1:

Input: words = ["alex","loves","leetcode"]
Output: "alexlovesleetcode"
Explanation: All permutations of "alex","loves","leetcode" would also be accepted.
Example 2:

Input: words = ["catg","ctaagt","gcta","ttca","atgcatc"]
Output: "gctaagttcatgcatc"


Constraints:

1 <= words.length <= 12
1 <= words[i].length <= 20
words[i] consists of lowercase English letters.
All the strings of words are unique.
*/

/*
Solution 1:
DP

We have to put the words into a row, where each word may overlap the previous word. This is because no word is contained in any word.

Also, it is sufficient to try to maximize the total overlap of the words.

Say we have put some words down in our row, ending with word A[i]. Now say we put down word A[j] as the next word, where word j hasn't been put down yet. The overlap increases by overlap(A[i], A[j]).

We can use dynamic programming to leverage this recursion. Let dp(mask, i) be the total overlap after putting some words down (represented by a bitmask mask), for which A[i] was the last word put down. Then, the key recursion is dp(mask ^ (1<<j), j) = max(overlap(A[i], A[j]) + dp(mask, i)), where the jth bit is not set in mask, and i ranges over all bits set in mask.

Of course, this only tells us what the maximum overlap is for each set of words. We also need to remember each choice along the way (ie. the specific i that made dp(mask ^ (1<<j), j) achieve a minimum) so that we can reconstruct the answer.

Algorithm

Our algorithm has 3 main components:

Precompute overlap(A[i], A[j]) for all possible i, j.
Calculate dp[mask][i], keeping track of the "parent" i for each j as described above.
Reconstruct the answer using parent information.

Time Complexity: O(N^2 (2^N + W)), where NN is the number of words, and WW is the maximum length of each word.
Space Complexity: O(N (2^N + W)).
*/
class Solution {
    func shortestSuperstring(_ words: [String]) -> String {
        let n = words.count

        var overlay = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        for i in 0..<n {
            for j in 0..<n where i != j {
                overlay[i][j] = getOverlay(words[i], words[j])
            }
        }

        // dp[mask][i] most overlay with mask, end with ith words
        var dp = Array(
            repeating: Array(repeating: 0, count: n),
            count: 1<<n
        )

        // parent[mask][i] parent of i
        var parent = Array(
            repeating: Array(repeating: -1, count: n),
            count: 1<<n
        )

        for mask in 0..<(1<<n) {
            for bit in 0..<n where ((mask >> bit) & 1) > 0 {
                // find dp[mask][bit]
                // previously had a collection of items represented by pmask
                let pmask = mask ^ (1<<bit)
                if pmask == 0 { continue }
                for i in 0..<n where ((pmask >> i) & 1) > 0 {
                    // for each bit i in pmask,
                    // if ended with word i, then added word bit
                    let val = dp[pmask][i] + overlay[i][bit]
                    if val > dp[mask][bit] {
                        dp[mask][bit] = val
                        parent[mask][bit] = i
                    }
                }
            }
        }

        var perm = Array(repeating: 0, count: n)
        var visited = Array(repeating: false, count: n)
        var mask = (1<<n) - 1

        // last element of perm (last word written left to right)
        var p = 0
        for j in 1..<n {
            if dp[(1<<n)-1][j] > dp[(1<<n)-1][p] {
                p = j
            }
        }

        // follow parents down backwards path that remains maximum overlap
        var t = 0
        while p != -1 {
            perm[t] = p
            t += 1

            visited[p] = true
            let p2 = parent[mask][p]
            mask ^= (1<<p)
            p = p2
        }

        // reverse perm[0..<t]
        for i in 0..<t/2 {
            let v = perm[i]
            perm[i] = perm[t-1-i]
            perm[t-1-i] = v
        }

        // fill in remaining words not added yet
        for i in 0..<n where !visited[i] {
            perm[t] = i
            t += 1
        }

        // reconstruct final answer by given perm
        var res = words[perm[0]]
        for i in 1..<n {
            let diff = overlay[perm[i-1]][perm[i]]
            res.append(String(words[perm[i]].dropFirst(diff)))
        }
        return res
    }

    func getOverlay(_ word1: String, _ word2: String) -> Int {
        let n1 = word1.count
        let n2 = word2.count

        let m = min(n1, n2)
        for k in stride(from: m, through: 0, by: -1) {
            if word1.hasSuffix(word2.prefix(k)) {
                return k
            }
        }
        return 0
    }
}