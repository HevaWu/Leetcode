/*
Given the root of a binary tree and an integer limit, delete all insufficient nodes in the tree simultaneously, and return the root of the resulting binary tree.

A node is insufficient if every root to leaf path intersecting this node has a sum strictly less than limit.

A leaf is a node with no children.



Example 1:


Input: root = [1,2,3,4,-99,-99,7,8,9,-99,-99,12,13,-99,14], limit = 1
Output: [1,2,3,4,null,null,7,8,9,null,14]
Example 2:


Input: root = [5,4,8,11,null,17,4,7,1,null,null,5,3], limit = 22
Output: [5,4,8,11,null,17,4,7,null,null,null,5]
Example 3:


Input: root = [1,2,-3,-5,null,4,null], limit = -1
Output: [1,null,-3,4]


Constraints:

The number of nodes in the tree is in the range [1, 5000].
-105 <= Node.val <= 105
-109 <= limit <= 109
*/

/*
Solution 1:

traverse binary tree and delete path

if current node is leaf node, check if path is valid or not,
if path is not valid, return nil, means we will delete this node

if current node is NOT leaf node, check its left and right children,
- if after checking, both left and right change to nil,
    means current node's children path all invalid, this node will be insufficient node,
    return nil
- otherwise, some path still valid, update node.left and node.right

Time Complexity: O(n)
- n is total number of node
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
    func sufficientSubset(_ root: TreeNode?, _ limit: Int) -> TreeNode? {
        guard let root = root else { return nil }
        return check(root, 0, limit)
    }

    func check(_ node: TreeNode?, _ cur: Int, _ limit: Int) -> TreeNode? {
        guard let node = node else { return nil }

        if node.left == nil, node.right == nil {
            // current node is leaf node
            if cur+node.val < limit {
                return nil
            } else {
                return node
            }
        } else {
            let left = check(node.left, cur+node.val, limit)
            let right = check(node.right, cur+node.val, limit)

            if left == nil, right == nil {
                // current node's children path all deleted,
                // this node should be deleted too
                return nil
            } else {
                node.left = left
                node.right = right
                return node
            }
        }
    }
}