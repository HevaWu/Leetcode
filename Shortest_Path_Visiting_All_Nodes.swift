/*
You have an undirected, connected graph of n nodes labeled from 0 to n - 1. You are given an array graph where graph[i] is a list of all the nodes connected with node i by an edge.

Return the length of the shortest path that visits every node. You may start and stop at any node, you may revisit nodes multiple times, and you may reuse edges.



Example 1:


Input: graph = [[1,2,3],[0],[0],[0]]
Output: 4
Explanation: One possible path is [1,0,2,0,3]
Example 2:


Input: graph = [[1],[0,2,4],[1,3,4],[2],[1,2]]
Output: 4
Explanation: One possible path is [0,1,4,2,3]


Constraints:

n == graph.length
1 <= n <= 12
0 <= graph[i].length < n
graph[i] does not contain i.
If graph[a] contains b, then graph[b] contains a.
The input graph is always connected.
*/

/*
Solution 1:
BFS+bitmask

Define PathNode:
- bitMask: mask of all the nodes we visited so far: 0 -> not visited, 1 -> visited (Originally this was Set<Integer>of all nodes we visited so far, but since the Solution TLE and N <= 12, it turns out we can use a bitMask and 32 bits total in an Integer can cover all the possibilities. This is a small speed up optimization.)
- index: index of node
- cost: the total cost in the path.

Idea:
- init queue contain n possible paths, means can start at any nodes
- remove element from queue to see if we covered all nodes in our bitmask, if cover all nodes, return cost of the path, using BFS, guarantee path with lowest cost
- get neighbors of current node, for each neighbor, set PathNode to visit bitMask, then add it back to the queue
- for prevent duplicate paths, use Set<PathNode> to store path we've visited before, since only path checking would be fine, use Path(cost:0) would be fine

Time Complexity: O(V+E)
Space Complexity: O(V+E)
*/
class Solution {
    func shortestPathLength(_ graph: [[Int]]) -> Int {
        let n = graph.count

        var queue = [PathNode]()
        var visited = Set<PathNode>()

        for i in 0..<n {
            let temp = 1<<i
            visited.insert(PathNode(bitMask: temp, index: i, cost: 0))
            queue.append(PathNode(bitMask: temp, index: i, cost: 1))
        }

        while !queue.isEmpty {
            let cur = queue.removeFirst()

            if cur.bitMask == (1<<n)-1 {
                return cur.cost-1
            } else {
                for next in graph[cur.index] {
                    var bitMask = cur.bitMask
                    bitMask = bitMask | (1<<next)

                    let node = PathNode(bitMask: bitMask, index: next, cost: 0)
                    if !visited.contains(node) {
                        queue.append(PathNode(bitMask: bitMask, index: next, cost: cur.cost+1))
                        visited.insert(node)
                    }
                }
            }
        }

        return -1
    }
}

struct PathNode: Hashable {
    let bitMask: Int
    let index: Int
    let cost: Int
}