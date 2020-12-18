/*
Given inorder and postorder traversal of a tree, construct the binary tree.

Note:
You may assume that duplicates do not exist in the tree.

For example, given

inorder = [9,3,15,20,7]
postorder = [9,15,7,20,3]
Return the following binary tree:

    3
   / \
  9  20
    /  \
   15   7
*/

/*
Solution 1:

use indexIn, indexPost to memo where we go through from inorder and postorder
- always set newNode from postorder[indexPost]
- if inorder[indexIn] != newNode.val, this node should at newNode right part
  - newNode.right = _build(newNode)
- if node == nil || inorder[indexIn] != node.val, this node should be at newNode left side
  - newNode.left = _build(node)
return newNode
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
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        var indexIn = inorder.count - 1
        var indexPost = postorder.count - 1
        
        func _build(_ node: TreeNode?) -> TreeNode? {
            if indexPost < 0 { return nil }

            var newNode = TreeNode(postorder[indexPost])
            indexPost -= 1

            if inorder[indexIn] != newNode.val {
                newNode.right = _build(newNode)
            }
            indexIn -= 1

            if node == nil || (inorder[indexIn] != node!.val) {
                newNode.left = _build(node)
            }

            return newNode 
        }
        
        return _build(nil)
    }
}