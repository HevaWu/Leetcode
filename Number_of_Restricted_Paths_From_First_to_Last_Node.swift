/*
There is an undirected weighted connected graph. You are given a positive integer n which denotes that the graph has n nodes labeled from 1 to n, and an array edges where each edges[i] = [ui, vi, weighti] denotes that there is an edge between nodes ui and vi with weight equal to weighti.

A path from node start to node end is a sequence of nodes [z0, z1, z2, ..., zk] such that z0 = start and zk = end and there is an edge between zi and zi+1 where 0 <= i <= k-1.

The distance of a path is the sum of the weights on the edges of the path. Let distanceToLastNode(x) denote the shortest distance of a path between node n and node x. A restricted path is a path that also satisfies that distanceToLastNode(zi) > distanceToLastNode(zi+1) where 0 <= i <= k-1.

Return the number of restricted paths from node 1 to node n. Since that number may be too large, return it modulo 109 + 7.



Example 1:


Input: n = 5, edges = [[1,2,3],[1,3,3],[2,3,1],[1,4,2],[5,2,2],[3,5,1],[5,4,10]]
Output: 3
Explanation: Each circle contains the node number in black and its distanceToLastNode value in blue. The three restricted paths are:
1) 1 --> 2 --> 5
2) 1 --> 2 --> 3 --> 5
3) 1 --> 3 --> 5
Example 2:


Input: n = 7, edges = [[1,3,1],[4,1,2],[7,3,4],[2,5,3],[5,6,1],[6,7,2],[7,5,3],[2,6,4]]
Output: 1
Explanation: Each circle contains the node number in black and its distanceToLastNode value in blue. The only restricted path is 1 --> 3 --> 7.


Constraints:

1 <= n <= 2 * 104
n - 1 <= edges.length <= 4 * 104
edges[i].length == 3
1 <= ui, vi <= n
ui != vi
1 <= weighti <= 105
There is at most one edge between any two nodes.
There is at least one path between any two nodes.
*/

/*
Solution 1:
TLE

dijkstra to get distanceToLast ( shortest weight path from node n to other node)
DAG(directed acyclic graph) to find all possible paths from 1 to n

Time Complexity: O(n^2 + E)
Space Complexity: O(VE)
*/
class Solution {
    func countRestrictedPaths(_ n: Int, _ edges: [[Int]]) -> Int {
        var graph = [Int: [(next: Int, weight: Int)]]()
        for e in edges {
            graph[e[1], default: [(next: Int, weight: Int)]()].append((e[0], e[2]))
            graph[e[0], default: [(next: Int, weight: Int)]()].append((e[1], e[2]))
        }

        var distanceToLast = getDistanceToLast(n, graph)

        var cache = Array(repeating: -1, count: n+1)
        return check(n, distanceToLast, graph, &cache)
    }

    // dijkstra
    // n+1 array, where arr[i] means minimum dist from i to n
    func getDistanceToLast(_ n: Int, _ graph: [Int: [(next: Int, weight: Int)]]) -> [Int] {
        var dist = Array(repeating: Int.max, count: n+1)
        dist[n] = 0

        var visited = Set<Int>()

        while true {
            var node = -1
            var tempDist = Int.max
            for i in 1...n {
                if !visited.contains(i), dist[i] < tempDist {
                    node = i
                    tempDist = dist[i]
                }
            }

            if node < 0 {
                break
            }

            visited.insert(node)
            if let list = graph[node] {
                for (next, weight) in list {
                    dist[next] = min(dist[next], dist[node] + weight)
                }
            }
        }
        return dist
    }

    let mod = Int(1e9 + 7)

    // DAG
    func check(_ index: Int,
               _ distanceToLast: [Int],
               _ graph: [Int: [(next: Int, weight: Int)]],
               _ cache: inout [Int]) -> Int {
        if index == 1 { return 1 }
        if cache[index] > 0 { return cache[index] }

        var val = 0
        if let list = graph[index] {
            for (next, weight) in list {
                if distanceToLast[next] > distanceToLast[index] {
                    val = (val + check(next, distanceToLast, graph, &cache)) % mod
                }
            }
        }
        cache[index] = val
        return val
    }
}