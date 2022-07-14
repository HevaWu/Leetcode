'''
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
'''

'''
Solution 1: recursively

first find index where inorder[i] == postorder[indexPost]
then
 	newNode.left = _build(indexPre+1, indexIn, index-1)
    newNode.right = _build(indexPre+index-indexIn+1, index+1, indexInEnd)
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
        def check(indexPre: int, indexIn: int, indexInEnd: int) -> Optional[TreeNode]:
            if indexPre == len(preorder) or indexIn > indexInEnd:
                return None
            node = TreeNode(preorder[indexPre])
            index = indexIn
            while index <= indexInEnd and inorder[index] != preorder[indexPre]:
                index += 1
            node.left = check(indexPre+1, indexIn, index-1)
            node.right = check(indexPre+index-indexIn+1, index+1, indexInEnd)
            return node
        return check(0, 0, len(inorder)-1)
