'''
Given a binary tree, we install cameras on the nodes of the tree.

Each camera at a node can monitor its parent, itself, and its immediate children.

Calculate the minimum number of cameras needed to monitor all nodes of the tree.



Example 1:


Input: [0,0,null,0,0]
Output: 1
Explanation: One camera is enough to monitor all nodes if placed as shown.
Example 2:


Input: [0,0,null,0,null,0,null,null,0]
Output: 2
Explanation: At least two cameras are needed to monitor all nodes of the tree. The above image shows one of the valid configurations of camera placement.

Note:

The number of nodes in the given tree will be in the range [1, 1000].
Every node has value 0.
'''

'''
Solution 1:
DP

Let solve(node) be some information about how many cameras it takes to cover the subtree at this node in various states. There are essentially 3 states:

[State 0] Strict subtree: All the nodes below this node are covered, but not this node.
[State 1] Normal subtree: All the nodes below and including this node are covered, but there is no camera here.
[State 2] Placed camera: All the nodes below and including this node are covered, and there is a camera here (which may cover nodes above this node).
Once we frame the problem in this way, the answer falls out:

To cover a strict subtree, the children of this node must be in state 1.
To cover a normal subtree without placing a camera here, the children of this node must be in states 1 or 2, and at least one of those children must be in state 2.
To cover the subtree when placing a camera here, the children can be in any state.

Time Complexity: O(n)
Space Complexity: O(logn) height of the tree
'''
# Definition for a binary tree node.
# class TreeNode:
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution:
    def minCameraCover(self, root: Optional[TreeNode]) -> int:
        # state[0]: itself not include, all below node included
        # state[1]: itself and bellow all included, but not put camera here
        # state[2]: put camera at here
        def solve(node: Optional[TreeNode]) -> List[int]:
            if not node:
                return [0, 0, 10000]
            stateL = solve(node.left)
            stateR = solve(node.right)

            minL12 = min(stateL[1], stateL[2])
            minR12 = min(stateR[1], stateR[2])

            s0 = stateL[1] + stateR[1]
            s1 = min(stateL[2]+minR12, stateR[2]+minL12)
            s2 = 1 + min(stateL[0], minL12) + min(stateR[0], minR12)
            return [s0, s1, s2]

        state = solve(root)
        return min(state[1], state[2])