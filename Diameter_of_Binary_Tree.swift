// Given a binary tree, you need to compute the length of the diameter of the tree. The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.

// Example:
// Given a binary tree
//           1
//          / \
//         2   3
//        / \     
//       4   5    
// Return 3, which is the length of the path [4,2,1,3] or [5,2,1,3].

// Note: The length of path between two nodes is represented by the number of edges between them.

// Solution 1: dfs
// check pathe left & right node
// if final maxD == 0, return 0, otherwise, return maxD-1
// 
// Time Complexity: O(N). We visit every node once.
// Space Complexity: O(N)O(N), the size of our implicit call stack during our depth-first search.
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
    var maxD = 0
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        checkMaxDiameter(root)
        return maxD > 0 ? maxD - 1 : 0
    }
    
    private func checkMaxDiameter(_ root: TreeNode?) -> Int {
        guard root != nil else { return 0 }
        
        let left = checkMaxDiameter(root!.left)
        let right = checkMaxDiameter(root!.right)
        
        if left + right + 1 > maxD {
            maxD = left + right + 1
        }
        
        return 1 + max(left, right)
    }
}