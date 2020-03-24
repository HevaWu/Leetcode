// In this problem, a rooted tree is a directed graph such that, there is exactly one node (the root) for which all other nodes are descendants of this node, plus every node has exactly one parent, except for the root node which has no parents.

// The given input is a directed graph that started as a rooted tree with N nodes (with distinct values 1, 2, ..., N), with one additional directed edge added. The added edge has two different vertices chosen from 1 to N, and was not an edge that already existed.

// The resulting graph is given as a 2D-array of edges. Each element of edges is a pair [u, v] that represents a directed edge connecting nodes u and v, where u is a parent of child v.

// Return an edge that can be removed so that the resulting graph is a rooted tree of N nodes. If there are multiple answers, return the answer that occurs last in the given 2D-array.

// Example 1:
// Input: [[1,2], [1,3], [2,3]]
// Output: [2,3]
// Explanation: The given directed graph will be like this:
//   1
//  / \
// v   v
// 2-->3
// Example 2:
// Input: [[1,2], [2,3], [3,4], [4,1], [1,5]]
// Output: [4,1]
// Explanation: The given directed graph will be like this:
// 5 <- 1 -> 2
//      ^    |
//      |    v
//      4 <- 3
// Note:
// The size of the input 2D-array will be between 3 and 1000.
// Every integer represented in the 2D-array will be between 1 and N, where N is the size of the input array.

// Solution 1: union find
// findRoot <- check if add current edge will cause circle
// map: save direction edge
// twoParents: 2 edge which have same parent
// circle: store circle edge
// 
// Time complexity: O(nm), n is node, m is length of edges
// Space complexity: O(n), for the map
class Solution {
    var map = [Int: Int]()

    func findRedundantDirectedConnection(_ edges: [[Int]]) -> [Int] {
        var circle = [Int]()
        var twoParents = [[Int]]()
        
        for edge in edges {
            if map[edge[0]] == nil { map[edge[0]] = edge[0] }
            
            if map[edge[1]] == nil || map[edge[1]] == edge[1] {
                map[edge[1]] = edge[0]
            } else {
                // already exist one, 2 parents
                twoParents = [[map[edge[1]]!, edge[1]], edge]
                if !circle.isEmpty { return twoParents.first! }
            }
            
            // current is not circle, add this edge, cause circle
            if circle.isEmpty, !findRoot(edge[0]) {
                circle = edge
                if !twoParents.isEmpty { return twoParents.first! }
            }
        }
        
        if !circle.isEmpty { return circle }
        if !twoParents.isEmpty { return twoParents.last! }
        return [Int]()
    }
    
    // return false if there is a circle
    func findRoot(_ node: Int) -> Bool {
        if map[node] == node { return true }
        var p = map[node]!
        while p != map[p]! {
            p = map[p]!
            if p == node { return false }
        }
        return true
    }
}