/*
You have n binary tree nodes numbered from 0 to n - 1 where node i has two children leftChild[i] and rightChild[i], return true if and only if all the given nodes form exactly one valid binary tree.

If node i has no left child then leftChild[i] will equal -1, similarly for the right child.

Note that the nodes have no values and that we only use the node numbers in this problem.



Example 1:


Input: n = 4, leftChild = [1,-1,3,-1], rightChild = [2,-1,-1,-1]
Output: true
Example 2:


Input: n = 4, leftChild = [1,-1,3,-1], rightChild = [2,3,-1,-1]
Output: false
Example 3:


Input: n = 2, leftChild = [1,0], rightChild = [-1,-1]
Output: false


Constraints:

n == leftChild.length == rightChild.length
1 <= n <= 104
-1 <= leftChild[i], rightChild[i] <= n - 1
*/


/*
Solution 1:
queue  BFS

1. use leftChild and rightChild record the node which have parent (each node should only have one parent, if not, return false)
2. go through hasParent, find the root node, if cannot find root, return false
3. use root node, BFS to check if can build valid binary tree

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func validateBinaryTreeNodes(_ n: Int, _ leftChild: [Int], _ rightChild: [Int]) -> Bool {
        var hasParent = Array(repeating: false, count: n)
        for i in 0..<n {
            let lc = leftChild[i]
            let rc = rightChild[i]
            if lc != -1 {
                if hasParent[lc] { return false }
                hasParent[lc] = true
            }
            if rc != -1 {
                if hasParent[rc] { return false }
                hasParent[rc] = true
            }
        }

        var root = -1
        for i in 0..<n {
            if !hasParent[i] {
                if root == -1 {
                    root = i
                } else {
                    return false
                }
            }
        }

        if root == -1 { return false }

        // record the node which already put into the tree
        var inTree = Array(repeating: false, count: n)
        inTree[root] = true
        var queue = [root]
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            let lc = leftChild[cur]
            if lc != -1 {
                if inTree[lc] { return false }
                inTree[lc] = true
                queue.append(lc)
            }

            let rc = rightChild[cur]
            if rc != -1 {
                if inTree[rc] { return false }
                inTree[rc] = true
                queue.append(rc)
            }
        }

        for i in 0..<n {
            if !inTree[i] { return false }
        }
        return true
    }
}
