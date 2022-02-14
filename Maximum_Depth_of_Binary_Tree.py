'''
Given the root of a binary tree, return its maximum depth.

A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

Example 1:


Input: root = [3,9,20,null,null,15,7]
Output: 3
Example 2:

Input: root = [1,null,2]
Output: 2
Example 3:

Input: root = []
Output: 0
Example 4:

Input: root = [0]
Output: 1


Constraints:

The number of nodes in the tree is in the range [0, 104].
-100 <= Node.val <= 100
'''

'''
Solution 2:
DFS stack
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if root:
            stack = []
            stack.append(SNode(root, 1))
            depth = 0
            while stack:
                cur = stack.pop()
                if cur.node.left==None and cur.node.right==None:
                    depth = max(depth, cur.level)
                else:
                    if cur.node.left:
                        stack.append(SNode(cur.node.left, cur.level+1))
                    if cur.node.right:
                        stack.append(SNode(cur.node.right, cur.level+1))
            return depth

        else:
            return 0

class SNode:
    def __init__(self, node: TreeNode, level: int):
        self.node = node
        self.level = level

'''
Solution 1:
recursive DFS
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if root:
            return 1+max(self.maxDepth(root.left), self.maxDepth(root.right))
        else:
            return 0
