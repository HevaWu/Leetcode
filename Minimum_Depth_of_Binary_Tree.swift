/*
Given a binary tree, find its minimum depth.

The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.

Note: A leaf is a node with no children.



Example 1:


Input: root = [3,9,20,null,null,15,7]
Output: 2
Example 2:

Input: root = [2,null,3,null,4,null,5,null,6]
Output: 5


Constraints:

The number of nodes in the tree is in the range [0, 105].
-1000 <= Node.val <= 1000
*/

/*
Solution 1:
BFS find the shortest path

Time Complexity: O(logn)
Space Complexity: O(logn)
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
    func minDepth(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var minVal = 1000001
        var queue = [DepthNode]()
        queue.append(DepthNode(node: root, depth: 1))
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            if cur.node.left == nil, cur.node.right == nil {
                return cur.depth
            }
            if let left = cur.node.left {
                queue.append(DepthNode(node: left, depth: cur.depth+1))
            }
            if let right = cur.node.right {
                queue.append(DepthNode(node: right, depth: cur.depth+1))
            }
        }
        return 0
    }
}

struct DepthNode {
    var node: TreeNode
    var depth = 0
}
