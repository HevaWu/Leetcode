/*
Given an undirected graph, return true if and only if it is bipartite.

Recall that a graph is bipartite if we can split its set of nodes into two independent subsets A and B, such that every edge in the graph has one node in A and another node in B.

The graph is given in the following form: graph[i] is a list of indexes j for which the edge between nodes i and j exists. Each node is an integer between 0 and graph.length - 1. There are no self edges or parallel edges: graph[i] does not contain i, and it doesn't contain any element twice.

 

Example 1:


Input: graph = [[1,3],[0,2],[1,3],[0,2]]
Output: true
Explanation: We can divide the vertices into two groups: {0, 2} and {1, 3}.

Example 2:


Input: graph = [[1,2,3],[0,2],[0,1,3],[0,2]]
Output: false
Explanation: We cannot find a way to divide the set of nodes into two independent subsets.
 

Constraints:

1 <= graph.length <= 100
0 <= graph[i].length < 100
0 <= graph[i][j] <= graph.length - 1
graph[i][j] != i
All the values of graph[i] are unique.
The graph is guaranteed to be undirected. 
*/

/*
Solution 1
BFS queue

generate 2 set
use visited to control current checked node

for each node, find if there is a subset it can insert,
if so, insert this node into subset,
and, BFS check its connected node, and put them into correct subset

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func isBipartite(_ graph: [[Int]]) -> Bool {
        let m = graph.count
        let n = graph[0].count
        
        if m == 1 { return true }
        
        var subA = Set<Int>()
        var subB = Set<Int>()
        
        var visited = Array(repeating: false, count: m)
        for i in 0..<m {
            if visited[i] { continue }
            visited[i] = true
            
            var queue: [Int] = [i]
            while !queue.isEmpty {
                let cur = queue.removeFirst()
                if canAdd(cur, subA, graph) {
                    subA.insert(cur)
                } else if canAdd(cur, subB, graph) {
                    subB.insert(cur)
                } else {
                    return false
                }
                
                for ele in graph[cur] where !visited[ele] {
                    queue.append(ele)
                    visited[ele] = true
                }
            }
        }
        return true
    }
    
    // check if a node i can insert into one subsets
    func canAdd(_ node: Int, _ sub: Set<Int>, _ graph: [[Int]]) -> Bool {
        for ele in graph[node] {
            if sub.contains(ele) {
                return false
            }
        }
        return true
    }
}