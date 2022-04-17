'''
Given the root of a binary search tree, rearrange the tree in in-order so that the leftmost node in the tree is now the root of the tree, and every node has no left child and only one right child.



Example 1:


Input: root = [5,3,6,2,4,null,8,1,null,null,null,7,9]
Output: [1,null,2,null,3,null,4,null,5,null,6,null,7,null,8,null,9]
Example 2:


Input: root = [5,1,7]
Output: [1,null,5,null,7]


Constraints:

The number of nodes in the given tree will be in the range [1, 100].
0 <= Node.val <= 1000
'''

'''
Solution 1:
iterative traverse tree

Time Complexity: O(n)
Space Complexity: O(H)
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def increasingBST(self, root: TreeNode) -> TreeNode:
        if not root:
            return None

        dummy = TreeNode(0)
        # help build increasing tree
        cur = dummy

        stack = []
        # help inorder traverse tree
        node = root

        while node != None or stack:
            while node != None:
                stack.append(node)
                node = node.left

            node = stack.pop(-1)
            node.left = None
            cur.right = node
            cur = cur.right
            node = node.right

        return dummy.right
