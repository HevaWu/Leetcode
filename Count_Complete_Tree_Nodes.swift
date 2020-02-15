// Given a complete binary tree, count the number of nodes.

// Note:

// Definition of a complete binary tree from Wikipedia:
// In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.

// Example:

// Input: 
//     1
//    / \
//   2   3
//  / \  /
// 4  5 6

// Output: 6

// Solution 1:
// The naive solution here is a linear time one-liner which counts nodes recursively one by one.
// 
// Time complexity : \mathcal{O}(N)O(N).
// Space complexity : \mathcal{O}(d) = \mathcal{O}(\log N)O(d)=O(logN) to keep the recursion stack, where d is a tree depth.
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    func countNodes(_ root: TreeNode?) -> Int {
        return root == nil ? 0 : 1 + countNodes(root!.left) + countNodes(root!.right)
    }
}

// Solution 2: 
// In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible.
// That means that complete tree has 2^k nodes in the kth level if the kth level is not the last one. The last level may be not filled completely, and hence in the last level the number of nodes could vary from 1 to 2^d where d is a tree depth.
// 
// Return 0 if the tree is empty.
// Compute the tree depth d.
// Return 1 if d == 0.
// The number of nodes in all levels but the last one is 2^d−1. The number of nodes in the last level could vary from 1 to 2^d. Enumerate potential nodes from 0 to 2^d - 1 and perform the binary search by the node index to check how many nodes are in the last level. Use the function exists(idx, d, root) to check if the node with index idx exists.
// Use binary search to implement exists(idx, d, root) as well.
// Return 2^d - 1 + the number of nodes in the last level.

// Solution 3:
// from root.left, recursively check if its right children is nil, and add the count
// Time Complexity: O(logn)
// Space ComplexityL O(logn)
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    func countNodes(_ root: TreeNode?) -> Int {
        guard root != nil else { return 0 }
        
        var count = 1
        var left = root!.left
        var right = root!.left
        while right != nil {
            left = left!.left
            right = right!.right
            count = count << 1
        }
        
        return count + (left == nil ? countNodes(root!.right) : countNodes(root!.left)) 
    }
}