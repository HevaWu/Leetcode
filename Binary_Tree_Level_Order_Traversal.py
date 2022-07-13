'''
Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its level order traversal as:
[
  [3],
  [9,20],
  [15,7]
]
'''

'''
Solution 2:
iterative,
Queue

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
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        order = []
        if not root:
            return order

        # queue[(node, depth)]
        queue = []
        queue.append([root, 0])

        while queue:
            [node, depth] = queue.pop(0)
            if depth == len(order):
                order.append([node.val])
            else:
                order[depth].append(node.val)

            if node.left:
                queue.append([node.left, depth+1])
            if node.right:
                queue.append([node.right, depth+1])

        return order
