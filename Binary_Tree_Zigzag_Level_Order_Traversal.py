'''
Given a binary tree, return the zigzag level order traversal of its nodes' values. (ie, from left to right, then right to left for the next level and alternate between).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its zigzag level order traversal as:
[
  [3],
  [20,9],
  [15,7]
]
'''


'''
Solution 1
recursive

use level to check where to insert node.val
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def zigzagLevelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        arr = []
        def check(node: Optional[TreeNode], level: int):
            nonlocal arr
            if not node: return
            if level == len(arr):
                arr.append([])
            if level % 2 != 0:
                arr[level].insert(0, node.val)
            else:
                arr[level].append(node.val)
            check(node.left, level+1)
            check(node.right, level+1)
        check(root, 0)
        return arr
