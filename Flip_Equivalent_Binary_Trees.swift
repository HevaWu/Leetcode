// For a binary tree T, we can define a flip operation as follows: choose any node, and swap the left and right child subtrees.

// A binary tree X is flip equivalent to a binary tree Y if and only if we can make X equal to Y after some number of flip operations.

// Write a function that determines whether two binary trees are flip equivalent.  The trees are given by root nodes root1 and root2.

 

// Example 1:

// Input: root1 = [1,2,3,4,5,6,null,null,null,7,8], root2 = [1,3,2,null,6,4,5,null,null,null,null,8,7]
// Output: true
// Explanation: We flipped at nodes with values 1, 3, and 5.
// Flipped Trees Diagram
 

// Note:

// Each tree will have at most 100 nodes.
// Each value in each tree will be a unique integer in the range [0, 99].

// Solution 1: recursive
// Time Complexity: O(min(N_1, N_2)), where N_1, N_2are the lengths of root1 and root2.
// Space Complexity: O(min(H_1, H_2)), where H_1, H_2are the heights of the trees of root1 and root2.
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
    func flipEquiv(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        guard let r1 = root1, let r2 = root2 else {
            return root1 == nil && root2 == nil
        }
        return r1.val == r2.val 
        && ((flipEquiv(root1!.left, root2!.left) && flipEquiv(root1!.right, root2!.right))
        || (flipEquiv(root1!.left, root2!.right) && flipEquiv(root1!.right, root2!.left)))
    }
}


// Solution 2: Canonical form DFS
// Flip each node so that the left child is smaller than the right, and call this the canonical representation. All equivalent trees have exactly one canonical representation.
// 
// Time Complexity: O(N_1 + N_2)where N_1, N_2are the lengths of root1 and root2. (In Python, this is \min(N_1, N_2)
// Space Complexity: O(N_1 + N_2)(In Python, this is \min(H_1, H_2) where H_1, H_2are the heights of the trees of root1 and root2.)
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
    func flipEquiv(_ root1: TreeNode?, _ root2: TreeNode?) -> Bool {
        var list1 = [Int]()
        var list2 = [Int]()
        
        dfs(root1, in: &list1)
        dfs(root2, in: &list2)
        
        return list1 == list2
    }
    
    private func dfs(_ root: TreeNode?, in list: inout [Int]) {
        guard root != nil else { return }
        
        list.append(root!.val)
        let left = root!.left == nil ? 0 : root!.left!.val
        let right = root!.right == nil ? 0 : root!.right!.val
        if left < right {
            dfs(root!.left, in: &list)
            dfs(root!.right, in: &list)
        } else {
            dfs(root!.right, in: &list)
            dfs(root!.left, in: &list)
        }
    }
}