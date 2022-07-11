'''
Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

Example:

Input: [1,2,3,null,5,null,4]
Output: [1, 3, 4]
Explanation:

   1            <---
 /   \
2     3         <---
 \     \
  5     4       <---
'''

'''
Solution 2:
recursive

Time Complexity: O(n), n is whole node count
Space Complexity: O(logn)
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def rightSideView(self, root: Optional[TreeNode]) -> List[int]:
        if not root:
            return []

        self.arr = []
        self.check(root, 0)
        return self.arr

    # check by order: node -> node.right -> node.left
    def check(self, node: TreeNode, depth: int):
        if depth == len(self.arr):
            self.arr.append(node.val)
        if node.right:
            self.check(node.right, depth+1)
        if node.left:
            self.check(node.left, depth+1)

'''
Solution 1:
iterative

always push right children in to queue first
then left one
each time, check if cur.level == res.count, if so,
find a right side node, append it to res

Time Complexity: O(n), n is whole node count
Space Complexity: O(logn)
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def rightSideView(self, root: Optional[TreeNode]) -> List[int]:
        if not root:
            return []

        queue = []
        queue.append([root, 0])
        arr = []
        while queue:
            cur = queue.pop(0)
            node = cur[0]
            depth = cur[1]
            if depth == len(arr):
                arr.append(node.val)
            if node.right:
                queue.append([node.right, depth+1])
            if node.left:
                queue.append([node.left, depth+1])
        return arr
