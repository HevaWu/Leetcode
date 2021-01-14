/*
Given the roots of two binary trees p and q, write a function to check if they are the same or not.

Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

 

Example 1:


Input: p = [1,2,3], q = [1,2,3]
Output: true
Example 2:


Input: p = [1,2], q = [1,null,2]
Output: false
Example 3:


Input: p = [1,2,1], q = [1,1,2]
Output: false
 

Constraints:

The number of nodes in both trees is in the range [0, 100].
-104 <= Node.val <= 104
*/

/*
Solution 2:
iterative

use pQueue qQueue to help memo current checking one

Time Complexity: O(n)
Space Complexity: 
- O(logn) best case of completely balanced tree
- O(n) worst case of completely unbalanced tree
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
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        var pQueue: [TreeNode?] = [p]
        var qQueue: [TreeNode?] = [q]
        while !pQueue.isEmpty, !qQueue.isEmpty {
            let curP = pQueue.removeFirst()
            let curQ = qQueue.removeFirst()
            if !isEqual(curP, curQ) {
                return false
            }
            if let curP = curP {
                pQueue.append(curP.left)
                pQueue.append(curP.right)
            }
            if let curQ = curQ {
                qQueue.append(curQ.left)
                qQueue.append(curQ.right)
            }
        }
        return pQueue.isEmpty && qQueue.isEmpty
    }
    
    func isEqual(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil, q == nil { return true }
        if p == nil || q == nil { return false }
        return p!.val == q!.val
    }
}

/*
Solution 1:
recursive

TimeComplexity: O(n)
SpaceComplexity: 
- O(logn) best case of completely balanced tree
- O(n) worst case of completely unbalanced tree
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
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil, q == nil { return true }
        if p == nil || q == nil { return false }
        if p!.val == q!.val { 
            return isSameTree(p!.left, q!.left) && isSameTree(p!.right, q!.right)
        } else {
            return false
        }
    }
}