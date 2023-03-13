'''
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
'''

'''
Solution 1: Top down
recursively check if
- first.left == second.right
- first.right == second.left
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def isSymmetric(self, root: Optional[TreeNode]) -> bool:
        if not root: return True
        def isSame(node1: Optional[TreeNode], node2: Optional[TreeNode]):
            if not node1 and not node2: return True
            if not node1 or not node2: return False
            if node1.val != node2.val: return False
            return isSame(node1.left, node2.right) and isSame(node1.right, node2.left)
        return isSame(root.left, root.right)
