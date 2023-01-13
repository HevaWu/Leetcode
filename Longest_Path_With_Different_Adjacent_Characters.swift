/*
You are given a tree (i.e. a connected, undirected graph that has no cycles) rooted at node 0 consisting of n nodes numbered from 0 to n - 1. The tree is represented by a 0-indexed array parent of size n, where parent[i] is the parent of node i. Since node 0 is the root, parent[0] == -1.

You are also given a string s of length n, where s[i] is the character assigned to node i.

Return the length of the longest path in the tree such that no pair of adjacent nodes on the path have the same character assigned to them.



Example 1:


Input: parent = [-1,0,0,1,1,2], s = "abacbe"
Output: 3
Explanation: The longest path where each two adjacent nodes have different characters in the tree is the path: 0 -> 1 -> 3. The length of this path is 3, so 3 is returned.
It can be proven that there is no longer path that satisfies the conditions.
Example 2:


Input: parent = [-1,0,0,0], s = "aabc"
Output: 3
Explanation: The longest path where each two adjacent nodes have different characters is the path: 2 -> 0 -> 3. The length of this path is 3, so 3 is returned.


Constraints:

n == parent.length == s.length
1 <= n <= 105
0 <= parent[i] <= n - 1 for all i >= 1
parent[0] == -1
parent represents a valid tree.
s consists of only lowercase English letters.
*/

/*
Solution 1:
DFS

build children
children[i] is list of children of node i

DFS search the longest different adjacent path for each node
subpath[i] is the longest adjacent path from node i to its children

"longest" is the result of whole different adjacent path in this tree
could be (node i's children1) -> node i -> node i's children2

Time Complexity: O(n + m ^ 2)
Space Complexity: O(n)
*/
class Solution {
    func longestPath(_ parent: [Int], _ s: String) -> Int {
        let n = parent.count
        var s = Array(s)
        var children = Array(repeating: [Int](), count: n)
        for i in 1..<n {
            children[parent[i]].append(i)
        }
        // print(children)

        // subpath[i] means the longest path for node i to its children
        // init is 1 because it will at least contain itself
        var subpath = Array(repeating: 1, count: n)
        var longest = 1
        check(0, s, children, &subpath, &longest)
        return longest
    }

    func check(_ node: Int, _ s: [Character], _ children: [[Int]],
    _ subpath: inout [Int], _ longest: inout Int) {
        let list = children[node]
        if list.isEmpty { return }

        let m = list.count
        for i in 0..<m {
            check(list[i], s, children, &subpath, &longest)
            // find children subpath's longest path
            guard s[node] != s[list[i]] else { continue }
            subpath[node] = max(subpath[node], subpath[list[i]] + 1)
        }
        longest = max(longest, subpath[node])
        if m == 1 { return }

        // try to find if could joint some children nodes to build longer path
        //      0(a)
        //   /   |     \
        // 2(b)    3(c). 1(a)
        // could joint 2 - 0 - 3
        for i in 0..<(m-1) {
            guard s[list[i]] != s[node] else { continue }
            for j in (i+1)..<m {
                guard s[list[j]] != s[node] else { continue }
                // can joint two children
                // update the longest possible connected path
                longest = max(longest, subpath[list[i]] + subpath[list[j]] + 1)
            }
        }
    }
}
