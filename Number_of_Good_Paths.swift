/*
There is a tree (i.e. a connected, undirected graph with no cycles) consisting of n nodes numbered from 0 to n - 1 and exactly n - 1 edges.

You are given a 0-indexed integer array vals of length n where vals[i] denotes the value of the ith node. You are also given a 2D integer array edges where edges[i] = [ai, bi] denotes that there exists an undirected edge connecting nodes ai and bi.

A good path is a simple path that satisfies the following conditions:

The starting node and the ending node have the same value.
All nodes between the starting node and the ending node have values less than or equal to the starting node (i.e. the starting node's value should be the maximum value along the path).
Return the number of distinct good paths.

Note that a path and its reverse are counted as the same path. For example, 0 -> 1 is considered to be the same as 1 -> 0. A single node is also considered as a valid path.



Example 1:


Input: vals = [1,3,2,1,3], edges = [[0,1],[0,2],[2,3],[2,4]]
Output: 6
Explanation: There are 5 good paths consisting of a single node.
There is 1 additional good path: 1 -> 0 -> 2 -> 4.
(The reverse path 4 -> 2 -> 0 -> 1 is treated as the same as 1 -> 0 -> 2 -> 4.)
Note that 0 -> 2 -> 3 is not a good path because vals[2] > vals[0].
Example 2:


Input: vals = [1,1,2,2,3], edges = [[0,1],[1,2],[2,3],[2,4]]
Output: 7
Explanation: There are 5 good paths consisting of a single node.
There are 2 additional good paths: 0 -> 1 and 2 -> 3.
Example 3:


Input: vals = [1], edges = []
Output: 1
Explanation: The tree consists of only one node, so there is one good path.


Constraints:

n == vals.length
1 <= n <= 3 * 104
0 <= vals[i] <= 105
edges.length == n - 1
edges[i].length == 2
0 <= ai, bi < n
ai != bi
edges represents a valid tree.
*/

/*
Solution 2:
DSU

Consider a node with the value X in a tree T. Let's try to find the number of good paths that start and end with the value X. The nodes having values greater than X are of no use, so let's remove them and form a new subgraph of all the nodes (and edges in T connected to these nodes) having values less than or equal to X. Note that the new subgraph could be a connected tree, or there could be multiple connected trees separated from each other.

Let's say we have two existing trees (components) c1 and c2 which are subgraphs of T.

Imagine if there were 6 nodes with the value X, say a, b, c, d, e, and f. We want to add all of them to the subgraph and find the number of good paths starting and ending with X. Let's say a, b, and c connect with some nodes in c1. Nodes d and e connect with some nodes in c2. Node f does not connect with any existing component and creates a new component c3 with just the node f.

Let's compute the number of good paths. In component c1, if we start with node a we get three good paths. The a node itself as well as the paths from a to b and a to c. For node b, we have the node itself and the path to c (the path to a is already covered). And for node c, we just have the node itself. So, there are six good paths formed in component c1. What if there were N nodes in place of three? Starting from the first node, we would have N good paths: the node itself and N - 1 paths to other nodes with the same value. For the second node, we would have N - 1 options (since the first node is already covered), and so on. So, if N nodes having the same value connect in a component, the good paths would be N + N - 1 + N - 2 + .. + 1 = N * (N + 1) / 2.

Similary, we can count three good paths forming in component c2. We can also use the same formula with N = 2 which gives (2 * (2 + 1) / 2) = 3 good paths.

For the component c3, there is one good path for node f, the node itself. It needs nodes with higher values to connect to other nodes in the original tree T, which do not lead to the formation of a good path. Here, N = 1, so using the formula gives us one good path.

Having added all the nodes with the value X, how can we compute the good paths with starting nodes having a value X + 1 (or next higher value)? To the subgraph formed above, we add all the nodes having the value X + 1 and repeat the same process to compute all the good paths starting with the value X + 1. The nodes with the value X can serve as intermediate nodes in a good path starting and ending with the value X + 1.

Create an adjacency list where adj[X] contains all the neighbors of node X.
Create a map valuesToNodes where valuesToNodes[X] is an array that contains all the nodes having the value X. The data structure chosen to create such a map sorts the keys in non-decreasing order, i.e., the keys are sorted.
Iterate over all the nodes and add each node to valuesToNodes[vals[node]].
Create a class UnionFind defining standard methods find and union_set.
Create an instance of UnionFind, passing the size as n. Also, initialize the count of good paths variable goodPaths with 0.
Iterate over each entry value, nodes in valuesToNodes in ascending order.
For every node in nodes, iterate over its neighbors.
For each neighbor of the node, if vals[node] >= vals[neighbor] we perform a union of the node with the neighbor.
After iterating through all the nodes, we create a map group. group[A] contains the number of nodes (from the nodes array) that belong to the same component A. For every node in nodes, we find its component and increment the size of that component by 1 in groups, i.e., group[find(node)] = group[find(node)] + 1.
We iterate through all the entries in the group and, for each key, get the value called size corresponding to it. Add (size * (size + 1) / 2) to the goodPaths.
Return goodPaths.

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func numberOfGoodPaths(_ vals: [Int], _ edges: [[Int]]) -> Int {
        let n = vals.count
        var graph = Array(repeating: [Int](), count: n)
        for edge in edges {
            graph[edge[0]].append(edge[1])
            graph[edge[1]].append(edge[0])
        }

        // key is node val
        // val is list of nodes have this val
        var valToNodes = [Int: [Int]]()
        for i in 0..<n {
            valToNodes[vals[i], default: [Int]()].append(i)
        }

        let uf = UF(n)
        var good = 0

        let sortedKey = valToNodes.keys.sorted()
        for val in sortedKey {
            guard let nodeList = valToNodes[val] else { continue }
            for node in nodeList {
                for next in graph[node] {
                    if vals[node] >= vals[next] {
                        uf.union(node, next)
                    }
                }
            }

            // check current same connected node
            // key is uf.find(node)
            // val is number of same uf parent nodes
            var group = [Int: Int]()
            for node in nodeList {
                group[uf.find(node), default: 0] += 1
            }

            // calculate and update good path
            for val in group.values {
                good += ((val * (val+1))/2)
            }
        }
        return good
    }
}

class UF {
    var parent: [Int]
    init(_ n: Int) {
        parent = Array(0..<n)
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func union(_ x: Int, _ y: Int) {
        let px = find(x)
        let py = find(y)
        if px != py {
            parent[px] = py
        }
    }
}

/*
Solution 1:
TLE

DFS find all connected path

Time Complexity: O(E + n!)
Space Complexity: O(n^2)
*/
class Solution {
    func numberOfGoodPaths(_ vals: [Int], _ edges: [[Int]]) -> Int {
        let n = vals.count
        var graph = Array(repeating: [Int](), count: n)
        for edge in edges {
            graph[edge[0]].append(edge[1])
            graph[edge[1]].append(edge[0])
        }

        var good = n
        for i in 0..<n {
            // find all paths start from i, update good
            check(i, -1, i, graph, vals, &good)
        }
        return good
    }

    func check(_ cur: Int, _ parent: Int, _ start: Int,
    _ graph: [[Int]], _ vals: [Int],
    _ good: inout Int) {
        if start < cur, vals[cur] == vals[start] {
            // find one good path
            // always keep start index as smallest to make sure no repeat path
            good += 1
        }
        for next in graph[cur] {
            if next == parent { continue }
            if vals[next] <= vals[start] {
                check(next, cur, start, graph, vals, &good)
            }
        }
    }
}
