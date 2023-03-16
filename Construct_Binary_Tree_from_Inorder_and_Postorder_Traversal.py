'''
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
'''

'''
Solution 1:

use indexIn, indexPost to memo where we go through from inorder and postorder
- always set newNode from postorder[indexPost]
- if inorder[indexIn] != newNode.val, this node should at newNode right part
  - newNode.right = _build(newNode)
- if node == nil || inorder[indexIn] != node.val, this node should be at newNode left side
  - newNode.left = _build(node)
return newNode
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def buildTree(self, inorder: List[int], postorder: List[int]) -> Optional[TreeNode]:
        indexIn = len(inorder)-1
        indexPost = len(postorder)-1
        def build(node: Optional[TreeNode]) -> Optional[TreeNode]:
            nonlocal indexPost, indexIn, inorder, postorder
            if indexPost < 0: return None
            newNode = TreeNode(postorder[indexPost])
            indexPost -= 1
            if inorder[indexIn] != newNode.val:
                newNode.right = build(newNode)
            indexIn -= 1
            if not node or node.val != inorder[indexIn]:
                newNode.left = build(node)
            return newNode

        return build(None)

