'''
Given the root of a Binary Search Tree (BST), return the minimum difference between the values of any two different nodes in the tree.



Example 1:


Input: root = [4,2,6,1,3]
Output: 1
Example 2:


Input: root = [1,0,48,null,null,12,49]
Output: 1


Constraints:

The number of nodes in the tree is in the range [2, 100].
0 <= Node.val <= 105
'''

'''
Solution 2:
recursively check each node,
compare its left most value and right most value

Time Complexity: O(n)
Space Complexity: O(1)
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def minDiffInBST(self, root: Optional[TreeNode]) -> int:
        minDiff = 100001

        def checkDiff(node: Optional[TreeNode], lMost: int, rMost: int):
            nonlocal minDiff
            if not node: return
            if lMost != -1: minDiff = min(minDiff, node.val-lMost)
            if rMost != -1: minDiff = min(minDiff, rMost-node.val)
            checkDiff(node.left, lMost, node.val)
            checkDiff(node.right, node.val, rMost)

        checkDiff(root, -1, -1)
        return minDiff
