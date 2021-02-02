/*
Given the root of a binary search tree and the lowest and highest boundaries as low and high, trim the tree so that all its elements lies in [low, high]. Trimming the tree should not change the relative structure of the elements that will remain in the tree (i.e., any node's descendant should remain a descendant). It can be proven that there is a unique answer.

Return the root of the trimmed binary search tree. Note that the root may change depending on the given bounds.

 

Example 1:


Input: root = [1,0,2], low = 1, high = 2
Output: [1,null,2]
Example 2:


Input: root = [3,0,4,null,2,null,null,1], low = 1, high = 3
Output: [3,2,null,1]
Example 3:

Input: root = [1], low = 1, high = 2
Output: [1]
Example 4:

Input: root = [1,null,2], low = 1, high = 3
Output: [1,null,2]
Example 5:

Input: root = [1,null,2], low = 2, high = 4
Output: [2]
 

Constraints:

The number of nodes in the tree in the range [1, 104].
0 <= Node.val <= 104
The value of each node in the tree is unique.
root is guaranteed to be a valid binary search tree.
0 <= low <= high <= 104
*/

/*
Solution 2:
optimize Solution 1
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
    func trimBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> TreeNode? {
        guard let node = root else { return nil }
        if node.val < low { return trimBST(node.right, low, high) }
        if node.val > high { return trimBST(node.left, low, high) }
        
        node.left = trimBST(node.left, low, high)
        node.right = trimBST(node.right, low, high)
        return node
    }
}

/*
Solution 1:
recursive check

Time Complexity: O(n)
Space Complexity: O(k) k is node num between low,high
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
    func trimBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> TreeNode? {
        guard let node = root else { return nil }
        if node.val >= low, node.val <= high {
            node.left = trimBST(node.left, low, high)
            node.right = trimBST(node.right, low, high)
            return node
        } else {
            // should remove current node
            if node.val < low {
                // BST, totally remove its left part
                // pick and check its right child
                return trimBST(node.right, low, high)
            } else {
                // node.val > high
                // BST, totally remove its right part
                // pick and check its left child
                return trimBST(node.left, low, high)
            }
        }
    }
}