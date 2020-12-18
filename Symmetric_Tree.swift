/*
Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).

For example, this binary tree [1,2,2,3,4,4,3] is symmetric:

    1
   / \
  2   2
 / \ / \
3  4 4  3
 

But the following [1,2,2,null,3,null,3] is not:

    1
   / \
  2   2
   \   \
   3    3
 

Follow up: Solve it both recursively and iteratively.
*/

/*
Solution 1: Top down
recursively check if 
- first.left == second.right
- first.right == second.left
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
    func isSymmetric(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        return _isSymmetric(root.left, root.right)
    }
    
    func _isSymmetric(_ first: TreeNode?, _ second: TreeNode?) -> Bool {
        if first == nil, second == nil { return true }
        guard let first = first, let second = second else { return false } 
        if first.val != second.val { return false }
        return _isSymmetric(first.left, second.right) && _isSymmetric(first.right, second.left)
    }
}