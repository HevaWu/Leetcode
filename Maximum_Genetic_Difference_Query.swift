/*
There is a rooted tree consisting of n nodes numbered 0 to n - 1. Each node's number denotes its unique genetic value (i.e. the genetic value of node x is x). The genetic difference between two genetic values is defined as the bitwise-XOR of their values. You are given the integer array parents, where parents[i] is the parent for node i. If node x is the root of the tree, then parents[x] == -1.

You are also given the array queries where queries[i] = [nodei, vali]. For each query i, find the maximum genetic difference between vali and pi, where pi is the genetic value of any node that is on the path between nodei and the root (including nodei and the root). More formally, you want to maximize vali XOR pi.

Return an array ans where ans[i] is the answer to the ith query.



Example 1:


Input: parents = [-1,0,1,1], queries = [[0,2],[3,2],[2,5]]
Output: [2,3,7]
Explanation: The queries are processed as follows:
- [0,2]: The node with the maximum genetic difference is 0, with a difference of 2 XOR 0 = 2.
- [3,2]: The node with the maximum genetic difference is 1, with a difference of 2 XOR 1 = 3.
- [2,5]: The node with the maximum genetic difference is 2, with a difference of 5 XOR 2 = 7.
Example 2:


Input: parents = [3,7,-1,2,0,7,0,2], queries = [[4,6],[1,15],[0,5]]
Output: [6,14,7]
Explanation: The queries are processed as follows:
- [4,6]: The node with the maximum genetic difference is 0, with a difference of 6 XOR 0 = 6.
- [1,15]: The node with the maximum genetic difference is 1, with a difference of 15 XOR 1 = 14.
- [0,5]: The node with the maximum genetic difference is 2, with a difference of 5 XOR 2 = 7.


Constraints:

2 <= parents.length <= 105
0 <= parents[i] <= parents.length - 1 for every node i that is not the root.
parents[root] == -1
1 <= queries.length <= 3 * 104
0 <= nodei <= parents.length - 1
0 <= vali <= 2 * 105
*/

/*
Solution 2:

DFS from root to its children, so we can have the path from root down to current node.
Build Binary Trie, so we can get maximum XOR of a value val with a number in our Trie in O(32), our Trie will keeps all elements in the path from root down to the current node.
When visit the node, we add it into our Trie.
After finishing visit the node, we remove it from our Trie.
Compute queryies by nodes.

Time: O(32 * (N + M)), where N is number of nodes, M is number of queries
Space: O(32 * (N + M))
*/
class Solution {
    var trie = Trie()

    func maxGeneticDifference(_ parents: [Int], _ queries: [[Int]]) -> [Int] {
        let n = parents.count
        let m = queries.count

        var graph = Array(repeating: [Int](), count: n)

        // build graph
        var root = -1
        for i in 0..<n {
            if parents[i] == -1 {
                root = i
            } else {
                graph[parents[i]].append(i)
            }
        }

        var queryGraph = Array(
            repeating: [(qindex: Int, qval: Int)](),
            count: n
        )
        for i in 0..<m {
            queryGraph[queries[i][0]].append((i, queries[i][1]))
        }
        // print(graph, queryGraph)

        var res = Array(repeating: 0, count: m)
        dfs(root, graph, queryGraph, &res)
        return res
    }

    func dfs(_ node: Int, _ graph: [[Int]],
             _ queryGraph: [[(qindex: Int, qval: Int)]], _ res: inout [Int]) {
        trie.add(node)

        for (qindex, qval) in queryGraph[node] {
            res[qindex] = trie.find(qval)
        }

        for next in graph[node] {
            dfs(next, graph, queryGraph, &res)
        }
        trie.remove(node)
    }
}

class Trie {
    var root: TrieNode?
    init() {
        root = TrieNode()
    }

    func add(_ nodeVal: Int) {
        var cur = root

        var val = nodeVal
        for i in stride(from: 31, through: 0, by: -1) {
            let c = (nodeVal >> i) & 1
            if cur!.child[c] == nil {
                cur!.child[c] = TrieNode()
            }
            cur = cur!.child[c]
        }
        cur!.count += 1
    }

    func remove(_ nodeVal: Int) {
        _ = removeFromNode(root, nodeVal)
    }

    func removeFromNode(_ node: TrieNode?, _ nodeVal: Int, _ bitAt: Int = 31) -> Bool {
        guard let node = node else { return false }
        if bitAt == -1 {
            node.count -= 1
            return node.count == 0
        }

        let c = (nodeVal >> bitAt) & 1
        let shouldRemove = removeFromNode(node.child[c], nodeVal, bitAt - 1)
        if shouldRemove,
        node.child[c]!.count == 0,
        node.child[c]!.isEmpty() ?? true {
            node.child[c] = nil
            // print("remove", nodeVal)
        }
        return shouldRemove
    }

    func find(_ val: Int) -> Int {
        var cur = root
        var res = 0
        for i in stride(from: 31, through: 0, by: -1) {
            let c = (val >> i) & 1
            if cur!.child[1-c] != nil {
                cur = cur!.child[1-c]
                res |= (1 << i)
            } else {
                cur = cur!.child[c]
            }
        }
        return res
    }
}

class TrieNode {
    static let maxChildCount = 2
    var child: [TrieNode?] = Array(repeating: nil, count: TrieNode.maxChildCount)
    var count = 0

    func isEmpty() -> Bool {
        for i in 0..<TrieNode.maxChildCount {
            if child[i] != nil {
                return false
            }
        }
        return true
    }
}


/*
Solution 1:
TLE

recursive

Time Complexity: O(m * n)
- n: parents.count
- m: queries.count
Space Complexity: O(1)
*/
class Solution {
    func maxGeneticDifference(_ parents: [Int], _ queries: [[Int]]) -> [Int] {
        return queries.map { q -> Int in
            return find(parents, q)
        }
    }

    func find(_ parents: [Int], _ q: [Int]) -> Int {
        var node = q[0]
        var val = q[1]

        var genetic = val ^ node
        while node != -1 {
            genetic = max(genetic, val ^ node)
            node = parents[node]
        }
        return genetic
    }
}