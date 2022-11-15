'''
Given a complete binary tree, count the number of nodes.

Note:

Definition of a complete binary tree from Wikipedia:
In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.

Example:

Input:
    1
   / \
  2   3
 / \  /
4  5 6

Output: 6
'''

'''
Solution 3:
from root.left, recursively check if its right children is nil, and add the count
Time Complexity: O(logn)
Space ComplexityL O(logn)
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def countNodes(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        l = root.left
        r = root.left
        count = 1
        while r:
            l = l.left
            r = r.right
            count <<= 1
        return count + (self.countNodes(root.left) if l else self.countNodes(root.right))
