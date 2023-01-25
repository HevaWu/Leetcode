/*
You are given a directed graph of n nodes numbered from 0 to n - 1, where each node has at most one outgoing edge.

The graph is represented with a given 0-indexed array edges of size n, indicating that there is a directed edge from node i to node edges[i]. If there is no outgoing edge from i, then edges[i] == -1.

You are also given two integers node1 and node2.

Return the index of the node that can be reached from both node1 and node2, such that the maximum between the distance from node1 to that node, and from node2 to that node is minimized. If there are multiple answers, return the node with the smallest index, and if no possible answer exists, return -1.

Note that edges may contain cycles.



Example 1:


Input: edges = [2,2,3,-1], node1 = 0, node2 = 1
Output: 2
Explanation: The distance from node 0 to node 2 is 1, and the distance from node 1 to node 2 is 1.
The maximum of those two distances is 1. It can be proven that we cannot get a node with a smaller maximum distance than 1, so we return node 2.
Example 2:


Input: edges = [1,2,-1], node1 = 0, node2 = 2
Output: 2
Explanation: The distance from node 0 to node 2 is 2, and the distance from node 2 to itself is 0.
The maximum of those two distances is 2. It can be proven that we cannot get a node with a smaller maximum distance than 2, so we return node 2.


Constraints:

n == edges.length
2 <= n <= 105
-1 <= edges[i] < n
edges[i] != i
0 <= node1, node2 < n
*/

/*
Solution 1:
BFS

convert problem to find the
 the closest node from two given nodes, node1 and node2 so that the maximum between the distances from node1 and node2 to that node is minimized over all the nodes. If there are multiple answers, we need to return the node with the smallest index, and if no possible answer exists, we need to return -1

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func closestMeetingNode(_ edges: [Int], _ node1: Int, _ node2: Int) -> Int {
        if node1 == node2 { return node1 }
        let n = edges.count

        var dist1 = Array(repeating: -1, count: n)
        var dist2 = Array(repeating: -1, count: n)
        bfs(node1, n, &dist1, edges)
        bfs(node2, n, &dist2, edges)
        // print(dist1, dist2)

        var index = -1
        var minDist = n+1
        for i in 0..<n {
            guard dist1[i] != -1 && dist2[i] != -1 else { continue }
            if minDist > max(dist1[i], dist2[i]) {
                minDist = max(dist1[i], dist2[i])
                index = i
            }
        }
        return index
    }

    func bfs(_ node: Int, _ n: Int,
    _ dist: inout [Int], _ edges: [Int]) {
        // BFS to calculate distance from node to all other node
        var queue = [node]
        var d = 0
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            if cur == -1 { continue }
            d += 1
            if dist[cur] != -1 {
                continue
            } else {
                dist[cur] = d
                queue.append(edges[cur])
            }
        }
    }
}
