/*
You are given a tree with n nodes numbered from 0 to n-1 in the form of a parent array where parent[i] is the parent of node i. The root of the tree is node 0.

Implement the function getKthAncestor(int node, int k) to return the k-th ancestor of the given node. If there is no such ancestor, return -1.

The k-th ancestor of a tree node is the k-th node in the path from that node to the root.



Example:



Input:
["TreeAncestor","getKthAncestor","getKthAncestor","getKthAncestor"]
[[7,[-1,0,0,1,1,2,2]],[3,1],[5,2],[6,3]]

Output:
[null,1,0,-1]

Explanation:
TreeAncestor treeAncestor = new TreeAncestor(7, [-1, 0, 0, 1, 1, 2, 2]);

treeAncestor.getKthAncestor(3, 1);  // returns 1 which is the parent of 3
treeAncestor.getKthAncestor(5, 2);  // returns 0 which is the grandparent of 5
treeAncestor.getKthAncestor(6, 3);  // returns -1 because there is no such ancestor


Constraints:

1 <= k <= n <= 5*10^4
parent[0] == -1 indicating that 0 is the root node.
0 <= parent[i] < n for all 0 < i < n
0 <= node < n
There will be at most 5*10^4 queries.
*/

/*
Solution 2:

we can make a P[i][node], it means [node]'s [2^i]th parent.
and when we want to take the Kth parent, we just turn the number 'k' to binary number, and see the bits to trace parent.

for example

let's set K = 5,
5 (in 10 base ) = 101(in 2 base),
so we find the (2^0) parent firstly, then find the (2^2) parent,

Time complexity:
O(log(max(K)) * number of node) for initilizing(prepare)
O(log(K)) for getKthAncestor (N times query).
*/
class TreeAncestor {
    var ancestor: [[Int]]

    init(_ n: Int, _ parent: [Int]) {
        // ancestor[i][node] node's 2^i th parent
        ancestor = Array(
            repeating: Array(repeating: -1, count: n),
            count: 20
        )

        // 2^0
        for node in 0..<n {
            ancestor[0][node] = parent[node]
        }

        // 2^i
        for i in 1..<20 {
            for node in 0..<n {
                let p = ancestor[i-1][node]
                if p != -1 {
                    ancestor[i][node] = ancestor[i-1][p]
                }
            }
        }
    }

    func getKthAncestor(_ node: Int, _ k: Int) -> Int {
        var node = node
        for i in 0..<20 {
            if (k & (1<<i)) != 0 {
                node = ancestor[i][node]
                if node == -1 { return -1 }
            }
        }
        return node
    }
}

/**
 * Your TreeAncestor object will be instantiated and called as such:
 * let obj = TreeAncestor(n, parent)
 * let ret_1: Int = obj.getKthAncestor(node, k)
 */

/*
Solution 1:
TLE
*/
class TreeAncestor {
    let n: Int
    let parent: [Int]
    var ancestor: [[Int?]]

    init(_ n: Int, _ parent: [Int]) {
        self.n = n
        self.parent = parent

        ancestor = Array(
            repeating: Array(repeating: nil, count: n+1),
            count: n
        )
    }

    func getKthAncestor(_ node: Int, _ k: Int) -> Int {
        if let val = ancestor[node][k] { return val }

        var cur = node
        var _k = k
        while _k != 0 {
            cur = parent[cur]
            if cur == -1 { break }
            _k -= 1
        }
        ancestor[node][k] = cur
        return cur
    }
}

/**
 * Your TreeAncestor object will be instantiated and called as such:
 * let obj = TreeAncestor(n, parent)
 * let ret_1: Int = obj.getKthAncestor(node, k)
 */