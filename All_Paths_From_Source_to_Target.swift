/*
Given a directed acyclic graph (DAG) of n nodes labeled from 0 to n - 1, find all possible paths from node 0 to node n - 1, and return them in any order.

The graph is given as follows: graph[i] is a list of all nodes you can visit from node i (i.e., there is a directed edge from node i to node graph[i][j]).



Example 1:


Input: graph = [[1,2],[3],[3],[]]
Output: [[0,1,3],[0,2,3]]
Explanation: There are two paths: 0 -> 1 -> 3 and 0 -> 2 -> 3.
Example 2:


Input: graph = [[4,3,1],[3,2,4],[3],[4],[]]
Output: [[0,4],[0,3,4],[0,1,3,4],[0,1,2,3,4],[0,1,4]]
Example 3:

Input: graph = [[1],[]]
Output: [[0,1]]
Example 4:

Input: graph = [[1,2,3],[2],[3],[]]
Output: [[0,1,2,3],[0,2,3],[0,3]]
Example 5:

Input: graph = [[1,3],[2],[3],[]]
Output: [[0,1,2,3],[0,3]]


Constraints:

n == graph.length
2 <= n <= 15
0 <= graph[i][j] < n
graph[i][j] != i (i.e., there will be no self-loops).
The input graph is guaranteed to be a DAG.
*/

/*
Solution 1:
backTrack

recursively checking if there is a path to reach targetNode
Because this is a acyclic graph, so we don't need to worry about cycle

Time Complexity: O(n!)
Space Complexity: O(n)
*/
class Solution {
    func allPathsSourceTarget(_ graph: [[Int]]) -> [[Int]] {
        var paths = [[Int]]()
        let n = graph.count
        var visited = Array(repeating: false, count: n)
        var cur = [0]
        check(0, n, graph, &cur, &visited, &paths)
        return paths
    }

    // update paths, to find paths from index to n-1
    func check(_ index: Int, _ n: Int, _ graph: [[Int]], _ cur: inout [Int],
    _ visited: inout [Bool], _ paths: inout [[Int]]) {
        guard index < n else { return }
        if index == n-1 {
            paths.append(cur)
            return
        }
        for next in graph[index] {
            if !visited[next] {
                visited[next] = true
                cur.append(next)
                check(next, n, graph, &cur, &visited, &paths)
                cur.removeLast()
                visited[next] = false
            }
        }
    }
}
