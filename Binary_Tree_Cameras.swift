/*
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
*/

/*
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
*/
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {
    func minCameraCover(_ root: TreeNode?) -> Int {
        var state = solve(root)
        return min(state[1], state[2])
    }

    // state0: Strict subtree: All the nodes below this node are covered, but not this node.
    // state1: Normal subtree: All the nodes below and including this node are covered, but there is no camera here.
    // state2: Placed camera: All the nodes below and including this node are covered, and there is a camera here (which may cover nodes above this node).
    // return [state0, state1, state2]
    func solve(_ node: TreeNode?) -> [Int] {
        guard let node = node else { return [0, 0, 10000] }

        let left = solve(node.left)
        let right = solve(node.right)

        let min_left_12 = min(left[1], left[2])
        let min_right_12 = min(right[1], right[2])

        let s0 = left[1] + right[1]
        let s1 = min(left[2] + min_right_12, right[2] + min_left_12)
        let s2 = 1 + min(left[0], min_left_12) + min(right[0], min_right_12)
        return [s0, s1, s2]
    }
}