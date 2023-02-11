/*
You are given an integer n, the number of nodes in a directed graph where the nodes are labeled from 0 to n - 1. Each edge is red or blue in this graph, and there could be self-edges and parallel edges.

You are given two arrays redEdges and blueEdges where:

redEdges[i] = [ai, bi] indicates that there is a directed red edge from node ai to node bi in the graph, and
blueEdges[j] = [uj, vj] indicates that there is a directed blue edge from node uj to node vj in the graph.
Return an array answer of length n, where each answer[x] is the length of the shortest path from node 0 to node x such that the edge colors alternate along the path, or -1 if such a path does not exist.



Example 1:

Input: n = 3, redEdges = [[0,1],[1,2]], blueEdges = []
Output: [0,1,-1]
Example 2:

Input: n = 3, redEdges = [[0,1]], blueEdges = [[2,1]]
Output: [0,1,-1]


Constraints:

1 <= n <= 100
0 <= redEdges.length, blueEdges.length <= 400
redEdges[i].length == blueEdges[j].length == 2
0 <= ai, bi, uj, vj < n
*/

/*
Solution 1:
BFS to find the shortest path

NOTE: once finish checking a path, update related graph[i][j] to remove related color edges, to avoid infinite checking

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func shortestAlternatingPaths(_ n: Int, _ redEdges: [[Int]], _ blueEdges: [[Int]]) -> [Int] {
        // graph[i][j] = 1 means i->j red edge
        // graph[i][j] = 2 means i->j blue edge
        // graph[i][j] = 3 means i->j both red and blue edge
        var graph = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )
        for edge in redEdges {
            graph[edge[0]][edge[1]] = 1
        }
        for edge in blueEdges {
            graph[edge[0]][edge[1]] += 2
        }

        var short = Array(repeating: -1, count: n)
        short[0] = 0

        // color is 1 means red
        // color is 2 means blue
        var queue = [(index: Int, color: Int)]()
        var cur = 0
        queue.append((0, 1))
        queue.append((0, 2))

        while !queue.isEmpty {
            cur += 1
            let size = queue.count
            for _ in 0..<size {
                let (index, color) = queue.removeFirst()
                // check if there is any connect alternate color edge
                for next in 0..<n {
                    guard graph[index][next] != 0 else { continue }
                    // print(next, color, graph[index][next])
                    if (color == 1 && graph[index][next] >= 2)
                    || (color == 2 && (graph[index][next] % 2 == 1)) {
                        if short[next] == -1 {
                            short[next] = cur
                        }
                        // to avoid infinite check same color edge
                        graph[index][next] -= (3-color)
                        queue.append((next, 3-color))
                    }
                }
            }
        }

        return short
    }
}
