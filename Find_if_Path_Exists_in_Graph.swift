/*
There is a bi-directional graph with n vertices, where each vertex is labeled from 0 to n - 1 (inclusive). The edges in the graph are represented as a 2D integer array edges, where each edges[i] = [ui, vi] denotes a bi-directional edge between vertex ui and vertex vi. Every vertex pair is connected by at most one edge, and no vertex has an edge to itself.

You want to determine if there is a valid path that exists from vertex source to vertex destination.

Given edges and the integers n, source, and destination, return true if there is a valid path from source to destination, or false otherwise.



Example 1:


Input: n = 3, edges = [[0,1],[1,2],[2,0]], source = 0, destination = 2
Output: true
Explanation: There are two paths from vertex 0 to vertex 2:
- 0 → 1 → 2
- 0 → 2
Example 2:


Input: n = 6, edges = [[0,1],[0,2],[3,5],[5,4],[4,3]], source = 0, destination = 5
Output: false
Explanation: There is no path from vertex 0 to vertex 5.


Constraints:

1 <= n <= 2 * 105
0 <= edges.length <= 2 * 105
edges[i].length == 2
0 <= ui, vi <= n - 1
ui != vi
0 <= source, destination <= n - 1
There are no duplicate edges.
There are no self edges.
*/

/*
Solution 1:
DFS

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func validPath(_ n: Int, _ edges: [[Int]], _ source: Int, _ destination: Int) -> Bool {
        if source == destination { return true }

        var graph = Array(
            repeating: [Int](),
            count: n
        )
        for e in edges {
            graph[e[0]].append(e[1])
            graph[e[1]].append(e[0])
        }

        // dfs check all connected
        var visited = Array(repeating: false, count: n)
        var stack = [source]
        visited[source] = true
        while !stack.isEmpty {
            let cur = stack.removeLast()
            for next in graph[cur] {
                if next == destination { return true }
                if !visited[next] {
                    stack.append(next)
                    visited[next] = true
                }
            }
        }
        return false
    }
}

/*
Solution 2:
BFS

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func validPath(_ n: Int, _ edges: [[Int]], _ source: Int, _ destination: Int) -> Bool {
        if source == destination { return true }
        var graph = Array(repeating: [Int](), count: n)
        for e in edges {
            graph[e[0]].append(e[1])
            graph[e[1]].append(e[0])
        }

        var visited = Array(repeating: false, count: n)
        var queue = [source]
        visited[source] = true
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            for next in graph[cur] {
                if !visited[next] {
                    if next == destination {
                        return true
                    }
                    visited[next] = true
                    queue.append(next)
                }
            }
        }
        return false
    }
}
