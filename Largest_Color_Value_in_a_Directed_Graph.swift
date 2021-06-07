/*
There is a directed graph of n colored nodes and m edges. The nodes are numbered from 0 to n - 1.

You are given a string colors where colors[i] is a lowercase English letter representing the color of the ith node in this graph (0-indexed). You are also given a 2D array edges where edges[j] = [aj, bj] indicates that there is a directed edge from node aj to node bj.

A valid path in the graph is a sequence of nodes x1 -> x2 -> x3 -> ... -> xk such that there is a directed edge from xi to xi+1 for every 1 <= i < k. The color value of the path is the number of nodes that are colored the most frequently occurring color along that path.

Return the largest color value of any valid path in the given graph, or -1 if the graph contains a cycle.



Example 1:



Input: colors = "abaca", edges = [[0,1],[0,2],[2,3],[3,4]]
Output: 3
Explanation: The path 0 -> 2 -> 3 -> 4 contains 3 nodes that are colored "a" (red in the above image).
Example 2:



Input: colors = "a", edges = [[0,0]]
Output: -1
Explanation: There is a cycle from 0 to 0.


Constraints:

n == colors.length
m == edges.length
1 <= n <= 105
0 <= m <= 105
colors consists of lowercase English letters.
0 <= aj, bj < n

*/

/*
Solution 1:
topological sort

Intuition: We can use BFS Topological Sort to visit the nodes. When visiting the next node, we can forward the color information to the next node. Also Topo-sort can help detect circle.

Algorithm:

Just do normal topo sort. One modification is that, for each node, we need to store a int cnt[26] array where cnt[i] is the maximum count of color i in all paths to the current node.

Time Complexity: O(V+E)
Space Complexity: O(V+E)
*/
class Solution {
    func largestPathValue(_ colors: String, _ edges: [[Int]]) -> Int {
        let ascii_a = Character("a").asciiValue!

        let n = colors.count
        var colors = Array(colors)

        var graph = [Int: [Int]]()
        var indegree = Array(repeating: 0, count: n)
        for edge in edges {
            graph[edge[0], default: [Int]()].append(edge[1])
            indegree[edge[1]] += 1
        }

        // count[i][j], means max count of jth color with start from ith node
        var count = Array(
            repeating: Array(repeating: 0, count: 26),
            count: n
        )
        var queue = [Int]()
        for i in 0..<n {
            if indegree[i] == 0 {
                count[i][Int(colors[i].asciiValue!-ascii_a)] = 1
                queue.append(i)
            }
        }

        var visited = Set<Int>()
        var largest = 0

        while !queue.isEmpty {
            let cur = queue.removeFirst()
            let val = maxElement(count[cur])
            largest = max(largest, val)

            visited.insert(cur)

            guard let list = graph[cur] else { continue }
            for next in list {
                for i in 0..<26 {
                    count[next][i] = max(
                        count[next][i],
                        count[cur][i] + (i == Int(colors[next].asciiValue!-ascii_a) ? 1 : 0)
                    )
                }

                indegree[next] -= 1
                if indegree[next] == 0 {
                    queue.append(next)
                }
            }
        }

        return visited.count == n ? largest : -1
    }

    func maxElement(_ arr: [Int]) -> Int {
        var res = arr[0]
        for i in 0..<arr.count {
            res = max(res, arr[i])
        }
        return res
    }
}