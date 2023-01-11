/*
Given an undirected tree consisting of n vertices numbered from 0 to n-1, which has some apples in their vertices. You spend 1 second to walk over one edge of the tree. Return the minimum time in seconds you have to spend to collect all apples in the tree, starting at vertex 0 and coming back to this vertex.

The edges of the undirected tree are given in the array edges, where edges[i] = [ai, bi] means that exists an edge connecting the vertices ai and bi. Additionally, there is a boolean array hasApple, where hasApple[i] = true means that vertex i has an apple; otherwise, it does not have any apple.



Example 1:


Input: n = 7, edges = [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], hasApple = [false,false,true,false,true,true,false]
Output: 8
Explanation: The figure above represents the given tree where red vertices have an apple. One optimal path to collect all apples is shown by the green arrows.
Example 2:


Input: n = 7, edges = [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], hasApple = [false,false,true,false,false,true,false]
Output: 6
Explanation: The figure above represents the given tree where red vertices have an apple. One optimal path to collect all apples is shown by the green arrows.
Example 3:

Input: n = 7, edges = [[0,1],[0,2],[1,4],[1,5],[2,3],[2,6]], hasApple = [false,false,false,false,false,false,false]
Output: 0


Constraints:

1 <= n <= 105
edges.length == n - 1
edges[i].length == 2
0 <= ai < bi <= n - 1
fromi < toi
hasApple.length == n
*/

/*
Solution 1:
DFS

build graph, to record all connected nodes
start from 0, find all connected path has apples

Time Complexity: O(E)
- E edges.count
Space Complexity: O(n)
*/
class Solution {
    func minTime(_ n: Int, _ edges: [[Int]], _ hasApple: [Bool]) -> Int {
        // record the connected node for each node
        var graph = Array(
            repeating: [Int](),
            count: n
        )
        for edge in edges {
            graph[edge[0]].append(edge[1])
            graph[edge[1]].append(edge[0])
        }
        return dfs(0, -1, graph, hasApple)
    }

    // return min tim to collect all Apples in Tree (node)
    func dfs(_ node: Int, _ parent: Int, _ graph: [[Int]], _ hasApple: [Bool]) -> Int {
        var totalTime = 0
        var childTime = 0
        for child in graph[node] {
            if child == parent { continue }
            childTime = dfs(child, node, graph, hasApple)
            // childTime > 0 means subtree of child has apples
            if childTime > 0 || hasApple[child] {
                totalTime += childTime + 2
            }
        }
        return totalTime
    }
}
