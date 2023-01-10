'''
Given the roots of two binary trees p and q, write a function to check if they are the same or not.

Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.



Example 1:


Input: p = [1,2,3], q = [1,2,3]
Output: true
Example 2:


Input: p = [1,2], q = [1,null,2]
Output: false
Example 3:


Input: p = [1,2,1], q = [1,1,2]
Output: false


Constraints:

The number of nodes in both trees is in the range [0, 100].
-104 <= Node.val <= 104
'''

'''
Solution 2:
iterative

use pQueue qQueue to help memo current checking one

Time Complexity: O(n)
Space Complexity:
- O(logn) best case of completely balanced tree
- O(n) worst case of completely unbalanced tree
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        pQueue = [p]
        qQueue = [q]
        while pQueue and qQueue:
            curP = pQueue.pop(0)
            curQ = qQueue.pop(0)

            if not curP and not curQ: continue
            if not curP or not curQ: return False

            if curP.val != curQ.val: return False
            pQueue.append(curP.left)
            pQueue.append(curP.right)

            qQueue.append(curQ.left)
            qQueue.append(curQ.right)
        return not pQueue and not qQueue

'''
Solution 1:
recursive

TimeComplexity: O(n)
SpaceComplexity:
- O(logn) best case of completely balanced tree
- O(n) worst case of completely unbalanced tree
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        if not p and not q: return True
        if not p or not q: return False
        if p.val != q.val: return False
        return self.isSameTree(p.left, q.left) and self.isSameTree(p.right, q.right)
