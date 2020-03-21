// Given the root of a binary tree, each node in the tree has a distinct value.

// After deleting all nodes with a value in to_delete, we are left with a forest (a disjoint union of trees).

// Return the roots of the trees in the remaining forest.  You may return the result in any order.

 

// Example 1:



// Input: root = [1,2,3,4,5,6,7], to_delete = [3,5]
// Output: [[1,2,null,4],[6],[7]]
 

// Constraints:

// The number of nodes in the given tree is at most 1000.
// Each node has a distinct value between 1 and 1000.
// to_delete.length <= 1000
// to_delete contains distinct values between 1 and 1000.
// Accepted

// Solution 1: recursion
// recurse checking if should delete root
// use shouldDelete to help checking if current node should be deleted,
// if it is, add it as a new root in list
// recursive searching node.left, node.right
// 
// Time complexity: O(n) <- nodes count, search all of nodes
// Space complexity: O(1)
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    func delNodes(_ root: TreeNode?, _ to_delete: [Int]) -> [TreeNode?] {
        var list = [TreeNode?]()
        deleteNode(root, true, Set(to_delete), &list)
        return list
    }
    
    func deleteNode(_ node: TreeNode?, _ isRoot: Bool, _ to_delete: Set<Int>, _ list: inout [TreeNode?]) -> TreeNode? {
        guard node != nil else { return nil }
        let shouldDelete = to_delete.contains(node!.val)
        if isRoot && !shouldDelete {
            list.append(node)
        }
        node!.left = deleteNode(node!.left, shouldDelete, to_delete, &list)
        node!.right = deleteNode(node!.right, shouldDelete, to_delete, &list)

        // return nil to delete this node
        return shouldDelete ? nil : node
    }
}