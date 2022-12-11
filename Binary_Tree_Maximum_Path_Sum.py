'''
Given a non-empty binary tree, find the maximum path sum.

For this problem, a path is defined as any sequence of nodes from some starting node to any node in the tree along the parent-child connections. The path must contain at least one node and does not need to go through the root.

Example 1:

Input: [1,2,3]

       1
      / \
     2   3

Output: 6
Example 2:

Input: [-10,9,20,null,null,15,7]

   -10
   / \
  9  20
    /  \
   15   7

Output: 42

'''

'''
Solution 1: recursive
Initiate max_sum as the smallest possible integer and call max_gain(node = root).
Implement max_gain(node) with a check to continue the old path/to start a new path:
Base case : if node is null, the max gain is 0.
Call max_gain recursively for the node children to compute max gain from the left and right subtrees : left_gain = max(max_gain(node.left), 0) and
right_gain = max(max_gain(node.right), 0).
Now check to continue the old path or to start a new path. To start a new path would cost price_newpath = node.val + left_gain + right_gain. Update max_sum if it's better to start a new path.
For the recursion return the max gain the node and one/zero of its subtrees could add to the current path : node.val + max(left_gain, right_gain).
//
Time complexity : O(N) where N is number of nodes, since we visit each node not more than 2 times.
Space complexity : \mathcal{O}(\log(N))O(log(N)). We have to keep a recursion stack of the size of the tree height, which is \mathcal{O}(\log(N))O(log(N)) for the binary tree.
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def maxPathSum(self, root: Optional[TreeNode]) -> int:
        maxSum = -30_000_001

        def check(node: Optional[TreeNode]) -> int:
            nonlocal maxSum
            if not node: return 0
            maxLeft = max(0, check(node.left))
            maxRight = max(0, check(node.right))
            maxSum = max(maxSum, node.val + maxLeft + maxRight)
            return node.val + max(maxLeft, maxRight)

        check(root)
        return maxSum
