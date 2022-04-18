'''
Given the root of a binary search tree, and an integer k, return the kth (1-indexed) smallest element in the tree.



Example 1:


Input: root = [3,1,4,null,2], k = 1
Output: 1
Example 2:


Input: root = [5,3,6,2,4,null,null,1], k = 3
Output: 3


Constraints:

The number of nodes in the tree is n.
1 <= k <= n <= 104
0 <= Node.val <= 104


Follow up: If the BST is modified often (i.e., we can do insert and delete operations) and you need to find the kth smallest frequently, how would you optimize?
'''

'''
Follow up
use like LRU cache design
conbine index structure with double linked list

overall time complexity for insert/delete + search of kth smallest is
O(h+k)
Space Complexity: O(n) to keep the linked list
'''

'''
Solution 1
dfs

use stack to memo visited left side node
Time Complexity: O(h+k)
 - h is tree height
 - h+k us stack contains at least h+k element
Space Complexity: O(h)
 - keep stacks
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        stack = []

        # inorder traverse tree
        node = root
        while node != None or stack:
            while node != None:
                stack.append(node)
                node = node.left

            node = stack.pop(-1)
            k -= 1
            if k == 0:
                return node.val

            node = node.right

        return -1
