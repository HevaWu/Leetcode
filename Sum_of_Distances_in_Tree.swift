/*
There is an undirected connected tree with n nodes labeled from 0 to n - 1 and n - 1 edges.

You are given the integer n and the array edges where edges[i] = [ai, bi] indicates that there is an edge between nodes ai and bi in the tree.

Return an array answer of length n where answer[i] is the sum of the distances between the ith node in the tree and all other nodes.



Example 1:


Input: n = 6, edges = [[0,1],[0,2],[2,3],[2,4],[2,5]]
Output: [8,12,6,10,10,10]
Explanation: The tree is shown above.
We can see that dist(0,1) + dist(0,2) + dist(0,3) + dist(0,4) + dist(0,5)
equals 1 + 1 + 2 + 2 + 2 = 8.
Hence, answer[0] = 8, and so on.
Example 2:


Input: n = 1, edges = []
Output: [0]
Example 3:


Input: n = 2, edges = [[1,0]]
Output: [1,1]


Constraints:

1 <= n <= 3 * 104
edges.length == n - 1
edges[i].length == 2
0 <= ai, bi < n
ai != bi
The given input represents a valid tree.
*/

/*
Solution 1:
Root the tree. For each node, consider the subtree S node of that node plus all descendants. Let count[node] be the number of nodes in S node, and stsum[node] ("subtree sum") be the sum of the distances from node to the nodes in S node.

We can calculate count and stsum using a post-order traversal, where on exiting some node, the count and stsum of all descendants of this node is correct, and we now calculate count[node] += count[child] and stsum[node] += stsum[child] + count[child].

This will give us the right answer for the root: ans[root] = stsum[root].

Now, to use the insight explained previously: if we have a node parent and it's child child, then these are neighboring nodes, and so ans[child] = ans[parent] - count[child] + (N - count[child]). This is because there are count[child] nodes that are 1 easier to get to from child than parent, and N-count[child] nodes that are 1 harder to get to from child than parent.

the answer for xx in the entire tree, is the answer of xx on XX "x@X", plus the answer of yy on YY "y@Y", plus the number of nodes in YY "#(Y)". The last part "#(Y)" is specifically because for any node z in Y, dist(x, z) = dist(y, z) + 1.

By similar reasoning, the answer for yy in the entire tree is ans[y] = x@X + y@Y + #(X). Hence, for neighboring nodes xx and yy, ans[x] - ans[y] = #(Y) - #(X).

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    var graph = [Set<Int>]()
    var count = [Int]()
    var res = [Int]()
    var n = 0

    func sumOfDistancesInTree(_ n: Int, _ edges: [[Int]]) -> [Int] {
        self.n = n
        graph = Array(repeating: Set<Int>(), count: n)
        count = Array(repeating: 1, count: n)
        res = Array(repeating: 0, count: n)

        for e in edges {
            graph[e[0]].insert(e[1])
            graph[e[1]].insert(e[0])
        }

        dfs(0, -1)
        dfs2(0, -1)
        return res
    }

    // get subtree sum
    func dfs(_ node: Int, _ parent: Int) {
        for c in graph[node] {
            if c != parent {
                dfs(c, node)
                count[node] += count[c]
                res[node] += res[c] + count[c]
            }
        }
    }

    func dfs2(_ node: Int, _ parent: Int) {
        for c in graph[node] {
            if c != parent {
                res[c] = res[node] - count[c] + n - count[c]
                dfs2(c, node)
            }
        }
    }
 }