/*
Given an array of integers preorder, which represents the preorder traversal of a BST (i.e., binary search tree), construct the tree and return its root.

It is guaranteed that there is always possible to find a binary search tree with the given requirements for the given test cases.

A binary search tree is a binary tree where for every node, any descendant of Node.left has a value strictly less than Node.val, and any descendant of Node.right has a value strictly greater than Node.val.

A preorder traversal of a binary tree displays the value of the node first, then traverses Node.left, then traverses Node.right.



Example 1:


Input: preorder = [8,5,1,7,10,12]
Output: [8,5,10,1,7,null,12]
Example 2:

Input: preorder = [1,3]
Output: [1,null,3]


Constraints:

1 <= preorder.length <= 100
1 <= preorder[i] <= 108
All the values of preorder are unique.
*/

/*
Solution 1:
recursive build tree

Time Complexity: O(n)
Space Complexity: O(n)
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
    func bstFromPreorder(_ preorder: [Int]) -> TreeNode? {
        let n = preorder.count
        return check(0, n, preorder)
    }

    func check(_ index: Int, _ n: Int,
               _ preorder: [Int]) -> TreeNode? {
        if index == n { return nil }
        var node = TreeNode(preorder[index])
        // start from index+1
        var next = index+1
        while next < n {
            if preorder[next] < preorder[index] {
                next += 1
            } else {
                break
            }
        }
        // check from index+1
        node.left = check(index+1, next, preorder)
        node.right = check(next, n, preorder)
        return node
    }
}