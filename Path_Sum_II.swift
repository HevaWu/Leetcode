/*
Given the root of a binary tree and an integer targetSum, return all root-to-leaf paths where each path's sum equals targetSum.

A leaf is a node with no children.



Example 1:


Input: root = [5,4,8,11,null,13,4,7,2,null,null,5,1], targetSum = 22
Output: [[5,4,11,2],[5,8,4,5]]
Example 2:


Input: root = [1,2,3], targetSum = 5
Output: []
Example 3:

Input: root = [1,2], targetSum = 0
Output: []


Constraints:

The number of nodes in the tree is in the range [0, 5000].
-1000 <= Node.val <= 1000
-1000 <= targetSum <= 1000
*/

/*
Solution 1:
dfs

traverse all of node, traverse all of root to leaf node path to check
if there is a path satisfy the rule

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
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        var res = [[Int]]()
        check(root, targetSum, [Int](), &res)
        return res
    }

    func check(_ node: TreeNode?, _ remain: Int,
               _ cur: [Int], _ res: inout [[Int]]) {
        guard let node = node else { return }
        if remain == node.val, node.left == nil, node.right == nil {
            res.append(cur+[node.val])
            return
        }

        check(node.left, remain-node.val, cur+[node.val], &res)
        check(node.right, remain-node.val, cur+[node.val], &res)
    }
}