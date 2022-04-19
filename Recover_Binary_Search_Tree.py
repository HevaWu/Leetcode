'''
You are given the root of a binary search tree (BST), where the values of exactly two nodes of the tree were swapped by mistake. Recover the tree without changing its structure.



Example 1:


Input: root = [1,3,null,null,2]
Output: [3,1,null,null,2]
Explanation: 3 cannot be a left child of 1 because 3 > 1. Swapping 1 and 3 makes the BST valid.
Example 2:


Input: root = [3,1,4,null,null,2]
Output: [2,1,4,null,null,3]
Explanation: 2 cannot be in the right subtree of 3 because 2 < 3. Swapping 2 and 3 makes the BST valid.


Constraints:

The number of nodes in the tree is in the range [2, 1000].
-231 <= Node.val <= 231 - 1


Follow up: A solution using O(n) space is pretty straight-forward. Could you devise a constant O(1) space solution?
'''

'''
Solution 1
first of all, traverse the tree find the two elements which need to swap
then swap the values of two nodes
during traverse, we use three TreeNode to help find two nodes
to the first element, firstelement larger than the next one
the second element always smaller than the previous one

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
    def __init__(self):
        self.first = None
        self.second = None
        self.pre = TreeNode(-sys.maxsize - 1)

    def recoverTree(self, root: Optional[TreeNode]) -> None:
        """
        Do not return anything, modify root in-place instead.
        """

        self.traverse(root)

        temp = self.first.val
        self.first.val = self.second.val
        self.second.val = temp

    def traverse(self, node: Optional[TreeNode]) -> None:
        if node == None:
            return

        self.traverse(node.left)
        if self.first == None and self.pre.val >= node.val:
            self.first = self.pre

        if self.first != None and self.pre.val >= node.val:
            self.second = node

        # update pre node before traverse right
        self.pre = node
        self.traverse(node.right)