/*
Given a binary search tree (BST), find the lowest common ancestor (LCA) of two given nodes in the BST.

According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”

 

Example 1:


Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
Output: 6
Explanation: The LCA of nodes 2 and 8 is 6.
Example 2:


Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
Output: 2
Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.
Example 3:

Input: root = [2,1], p = 2, q = 1
Output: 2
 

Constraints:

The number of nodes in the tree is in the range [2, 105].
-109 <= Node.val <= 109
All Node.val are unique.
p != q
p and q will exist in the BST.
*/


/*
Solution 2:
binary search 
iterative

Time Complexity: O(n)
Space Complexity: O(1)
*/
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
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let node = root, let p = p, let q = q else { return nil }
        if node.val == p.val || node.val == q.val { return node }
        
        var cur: TreeNode? = node
        while cur != nil {
            if cur!.val > q.val, cur!.val > p.val {
                cur = cur!.left
            } else if cur!.val < q.val, cur!.val < p.val {
                cur = cur!.right
            } else {
                return cur
            }
        }
        
        return cur
    }
}

/*
Solution 1:
binary search
recursive

always keep l.val < r.val
then check current node
- if node.val == p.val || node.val == q.val { return node }
- if node.val < l.val { return lowestCommonAncestor(node.right, l, r) }
- if node.val > r.val { return lowestCommonAncestor(node.left, l, r) }

Time Complexity: O(n) where n is number of nodes in the BST
Space Complexity: O(n)
*/
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
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let node = root, let p = p, let q = q else { return nil }
        if node.val == p.val || node.val == q.val { return node }
        var l: TreeNode = p
        var r: TreeNode  = q
        
        // always keep l.val < r.val
        if l.val > r.val {
            let temp = r
            r = l
            l = temp
        }
        
        if node.val > l.val, node.val < r.val {
            return node
        } else if node.val > r.val {
            return lowestCommonAncestor(node.left, l, r)
        } else if node.val < l.val {
            return lowestCommonAncestor(node.right, l, r)
        }
        
        return nil
    }
}