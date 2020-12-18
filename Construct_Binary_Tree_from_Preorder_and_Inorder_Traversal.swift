/*
Given preorder and inorder traversal of a tree, construct the binary tree.

Note:
You may assume that duplicates do not exist in the tree.

For example, given

preorder = [3,9,20,15,7]
inorder = [9,3,15,20,7]
Return the following binary tree:

    3
   / \
  9  20
    /  \
   15   7
*/

/*
Solution 1: recursively

first find index where inorder[i] == postorder[indexPost]
then 
 	newNode.left = _build(indexPre+1, indexIn, index-1)
    newNode.right = _build(indexPre+index-indexIn+1, index+1, indexInEnd)
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
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        var n_preorder = preorder.count
        func _build(_ indexPre: Int, _ indexIn: Int, _ indexInEnd: Int) -> TreeNode? {
            if indexPre >= n_preorder || indexIn > indexInEnd {
                return nil
            }
            
            var newNode = TreeNode(preorder[indexPre])
            
            var index = 0
            for i in indexIn...indexInEnd {
                if inorder[i] == newNode.val {
                    index = i
                }
            }
            
            newNode.left = _build(indexPre+1, indexIn, index-1)
            newNode.right = _build(indexPre+index-indexIn+1, index+1, indexInEnd)
            return newNode
        }
        
        return _build(0, 0, inorder.count-1)
    }
}