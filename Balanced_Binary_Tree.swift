/*
Given a binary tree, determine if it is height-balanced.

For this problem, a height-balanced binary tree is defined as:

a binary tree in which the left and right subtrees of every node differ in height by no more than 1.

 

Example 1:


Input: root = [3,9,20,null,null,15,7]
Output: true
Example 2:


Input: root = [1,2,2,3,3,null,null,4,4]
Output: false
Example 3:

Input: root = []
Output: true
 

Constraints:

The number of nodes in the tree is in the range [0, 5000].
-104 <= Node.val <= 104
*/

/*
Solution 2:
Improve Solution 1 by return height only.
if height = -1, means current subtree is not balance tree
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
    func isBalanced(_ root: TreeNode?) -> Bool {
        return _check(root) != -1
    }
    
    // return height, -1 if current subtree is not balanced
    func _check(_ node: TreeNode?) -> Int {
        guard let node = node else { return 0 }
        let left = _check(node.left)
        let right = _check(node.right)
        
        if left == -1 || right == -1 || abs(left-right) > 1 {
            return -1
        } else {
            return max(left, right) + 1
        }
    }
}

/*
Solution 1:
DFS

check()
- return (height, isBalanced)
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
    func isBalanced(_ root: TreeNode?) -> Bool {
        return _check(root).1
    }
    
    // return (height, isBalanced)
    func _check(_ node: TreeNode?) -> (Int, Bool) {
        guard let node = node else { return (0, true) }
        let left = _check(node.left)
        let right = _check(node.right)
        var balance = left.1 && right.1
        if balance {
            balance = abs(left.0 - right.0) <= 1
        }
        return (max(left.0, right.0)+1, balance)
    }
}