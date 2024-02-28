/*
Given the root of a binary tree, return the leftmost value in the last row of the tree.



Example 1:


Input: root = [2,1,3]
Output: 1
Example 2:


Input: root = [1,2,3,4,null,5,6,null,null,7]
Output: 7


Constraints:

The number of nodes in the tree is in the range [1, 104].
-231 <= Node.val <= 231 - 1
*/

/*
Solution 1:
Recursive function to find bottom left value
Preorder traversal

Time Complexity: O(n)
Space Complexity: O(1)
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
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        guard let root = root else { return -1 }
        var leftMostVal = root.val
        var leftMostNodeLevel = 0
        findLeftMost(root, 0, &leftMostNodeLevel, &leftMostVal)
        return leftMostVal
    }

    func findLeftMost(_ node: TreeNode, _ nodeLevel: Int, _ leftMostNodeLevel: inout Int, _ leftMostVal: inout Int) {
        if nodeLevel > leftMostNodeLevel {
            leftMostVal = node.val
            leftMostNodeLevel = nodeLevel
        }
        if let left = node.left {
            findLeftMost(left, nodeLevel+1, &leftMostNodeLevel, &leftMostVal)
        }
        if let right = node.right {
            findLeftMost(right, nodeLevel+1, &leftMostNodeLevel, &leftMostVal)
        }
    }
}
