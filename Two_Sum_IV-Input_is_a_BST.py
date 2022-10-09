'''
Given the root of a Binary Search Tree and a target number k, return true if there exist two elements in the BST such that their sum is equal to the given target.



Example 1:


Input: root = [5,3,6,2,4,null,7], k = 9
Output: true
Example 2:


Input: root = [5,3,6,2,4,null,7], k = 28
Output: false
Example 3:

Input: root = [2,1,3], k = 4
Output: true
Example 4:

Input: root = [2,1,3], k = 1
Output: false
Example 5:

Input: root = [2,1,3], k = 3
Output: true


Constraints:

The number of nodes in the tree is in the range [1, 104].
-104 <= Node.val <= 104
root is guaranteed to be a valid binary search tree.
-105 <= k <= 105
'''

'''
Solution 1:
recursively check tree node's k-node.val exist or not.

Time Complexity: O(n)
Space Complexity: O(n)
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def findTarget(self, root: Optional[TreeNode], k: int) -> bool:
        arrSet = set()

        def check(root: Optional[TreeNode], k: int) -> bool:
            nonlocal arrSet
            if not root: return False
            if k-root.val in arrSet: return True
            arrSet.add(root.val)
            return check(root.left, k) or check(root.right, k)

        return check(root, k)

'''
Solution 2:
DFS iterative

Time Complexity: O(n)
Space Complexity: O(logn)
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def findTarget(self, root: Optional[TreeNode], k: int) -> bool:
        if not root: return False

        arrSet = set()
        nodeStack = [root]
        while nodeStack:
            cur = nodeStack.pop(-1)
            if k-cur.val in arrSet: return True
            arrSet.add(cur.val)
            if cur.left: nodeStack.append(cur.left)
            if cur.right: nodeStack.append(cur.right)
        return False
