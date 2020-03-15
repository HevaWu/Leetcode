// In a directed graph, we start at some node and every turn, walk along a directed edge of the graph.  If we reach a node that is terminal (that is, it has no outgoing directed edges), we stop.

// Now, say our starting node is eventually safe if and only if we must eventually walk to a terminal node.  More specifically, there exists a natural number K so that for any choice of where to walk, we must have stopped at a terminal node in less than K steps.

// Which nodes are eventually safe?  Return them as an array in sorted order.

// The directed graph has N nodes with labels 0, 1, ..., N-1, where N is the length of graph.  The graph is given in the following form: graph[i] is a list of labels j such that (i, j) is a directed edge of the graph.

// Example:
// Input: graph = [[1,2],[2,3],[5],[0],[5],[],[]]
// Output: [2,4,5,6]
// Here is a diagram of the above graph.

// Illustration of graph

// Note:

// graph will have length at most 10000.
// The number of edges in the graph will not exceed 32000.
// Each graph[i] will be a sorted list of different integers, chosen within the range [0, graph.length - 1].

// Soluton 1: DFS
// The crux of the problem is whether you can reach a cycle from the node you start in. If you can, then there is a way to avoid stopping indefinitely; and if you can't, then after some finite number of steps you'll stop.
// Thinking about this property more, a node is eventually safe if all it's outgoing edges are to nodes that are eventually safe.
// This gives us the following idea: we start with nodes that have no outgoing edges - those are eventually safe. Now, we can update any nodes which only point to eventually safe nodes - those are also eventually safe. Then, we can update again, and so on.
// 
// We can improve this approach, by noticing that we don't need to clear the colors between each search.
// When we visit a node, the only possibilities are that we've marked the entire subtree black (which must be eventually safe), or it has a cycle and we have only marked the members of that cycle gray. So indeed, the invariant that gray nodes are always part of a cycle, and black nodes are always eventually safe is maintained.
// In order to exit our search quickly when we find a cycle (and not paint other nodes erroneously), we'll say the result of visiting a node is true if it is eventually safe, otherwise false. This allows information that we've reached a cycle to propagate up the call stack so that we can terminate our search early.
// 
// Time Complexity: O(N + E)O(N+E), where NN is the number of nodes in the given graph, and EE is the total number of edges.
// Space Complexity: O(N)O(N) in additional space complexity.
class Solution {
    func eventualSafeNodes(_ graph: [[Int]]) -> [Int] {
        let n = graph.count
        
        // white 0, gray 1, black 2
        var color = Array(repeating: 0, count: n)
        
        var list = [Int]()
        for i in 0..<n {
            if dfs(i, &color, graph) {
                list.append(i)
            }
        }
        return list
    }
    
    func dfs(_ index: Int, _ color: inout [Int], _ graph: [[Int]]) -> Bool {
        if color[index] > 0 {
            return color[index] == 2
        }
        
        // mark this node as visited
        color[index] = 1
        for next in graph[index] {
            if color[next] == 2 {
                continue
            }
            
            // dfs check circles
            if color[next] == 1 || !dfs(next, &color, graph) {
                return false
            }
        }
        color[index] = 2
        return true
    }
}
