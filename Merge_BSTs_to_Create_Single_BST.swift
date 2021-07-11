/*
You are given n BST (binary search tree) root nodes for n separate BSTs stored in an array trees (0-indexed). Each BST in trees has at most 3 nodes, and no two roots have the same value. In one operation, you can:

Select two distinct indices i and j such that the value stored at one of the leaves of trees[i] is equal to the root value of trees[j].
Replace the leaf node in trees[i] with trees[j].
Remove trees[j] from trees.
Return the root of the resulting BST if it is possible to form a valid BST after performing n - 1 operations, or null if it is impossible to create a valid BST.

A BST (binary search tree) is a binary tree where each node satisfies the following property:

Every node in the node's left subtree has a value strictly less than the node's value.
Every node in the node's right subtree has a value strictly greater than the node's value.
A leaf is a node that has no children.



Example 1:


Input: trees = [[2,1],[3,2,5],[5,4]]
Output: [3,2,5,1,null,4]
Explanation:
In the first operation, pick i=1 and j=0, and merge trees[0] into trees[1].
Delete trees[0], so trees = [[3,2,5,1],[5,4]].

In the second operation, pick i=0 and j=1, and merge trees[1] into trees[0].
Delete trees[1], so trees = [[3,2,5,1,null,4]].

The resulting tree, shown above, is a valid BST, so return its root.
Example 2:


Input: trees = [[5,3,8],[3,2,6]]
Output: []
Explanation:
Pick i=0 and j=1 and merge trees[1] into trees[0].
Delete trees[1], so trees = [[5,3,8,2,6]].

The resulting tree is shown above. This is the only valid operation that can be performed, but the resulting tree is not a valid BST, so return null.
Example 3:


Input: trees = [[5,4],[3]]
Output: []
Explanation: It is impossible to perform any operations.
Example 4:


Input: trees = [[2,1,3]]
Output: [2,1,3]
Explanation: There is only one tree, and it is already a valid BST, so return its root.


Constraints:

n == trees.length
1 <= n <= 5 * 104
The number of nodes in each tree is in the range [1, 3].
No two roots of trees have the same value.
All the trees in the input are valid BSTs.
1 <= TreeNode.val <= 5 * 104.
*/

/*
Solution 1:

When asked to validate BST, we naturally think about in-order traversal (98. Validate Binary Search Tree). The question is how to do in-order traversal when we are given many separate trees.

First of all, we want to find a root node to start the traversal from, and we can do so by finding the node without any incoming edge (indeg = 0). If there's zero or more than one roots, we cannot create a single BST.

To traverse through nodes, we need to go from one BST to another. We achieve this with the help of a value-to-node map (nodes).

There are also two edges cases we need to check:
- There is no cycle
- We traverse through all node

Time Complexity: O(n)
Space Complexity: O(n)
*/
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {
    func canMerge(_ trees: [TreeNode?]) -> TreeNode? {
        // key is treeNode.val
        // val is treeNode
        var map = [Int: TreeNode]()

        // key is treeNode.val
        // val is indegree
        var indegree = [Int: Int]()

        for t in trees {
            if indegree[t!.val] == nil {
                indegree[t!.val] = 0
            }
            if let left = t?.left {
                indegree[left.val, default: 0] += 1
                if map[left.val] == nil {
                    map[left.val] = left
                }
            }
            if let right = t?.right {
                indegree[right.val, default: 0] += 1
                if map[right.val] == nil {
                    map[right.val] = right
                }
            }
            map[t!.val] = t
        }

        // find root node
        var sources: Int = -1
        for (k, v) in indegree {
            if v == 0 {
                // make sure only have 1 root
                if sources != -1 { return nil }
                sources = k
            }
        }

        guard sources > 0 else { return nil }

        var visited = Set<Int>()
        var isValid = true
        var leftVal = Int.min
        var root = traverse(sources, map, &visited, &isValid, &leftVal)
        guard visited.count == map.keys.count, isValid else {
            return nil
        }
        return root
    }

    func traverse(_ val: Int, _ map: [Int: TreeNode?],
                  _ visited: inout Set<Int>,
                  _ isValid: inout Bool, _ leftVal: inout Int) -> TreeNode? {
        guard isValid else { return nil }

        if visited.contains(val) {
            isValid = false
            return nil
        }

        visited.insert(val)
        var node: TreeNode? = map[val] ?? TreeNode(val)
        if let left = node?.left {
            node?.left = traverse(left.val, map, &visited, &isValid, &leftVal)
        }
        if val <= leftVal {
            isValid = false
            return nil
        }
        leftVal = val
        if let right = node?.right {
            node?.right = traverse(right.val, map, &visited, &isValid, &leftVal)
        }
        return node
    }
}