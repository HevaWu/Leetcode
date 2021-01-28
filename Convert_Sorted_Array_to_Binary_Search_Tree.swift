/*
Given an array where elements are sorted in ascending order, convert it to a height balanced BST.

For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of every node never differ by more than 1.

Example:

Given the sorted array: [-10,-3,0,5,9],

One possible answer is: [0,-3,9,-10,null,5], which represents the following height balanced BST:

      0
     / \
   -3   9
   /   /
 -10  5
*/

/*
Solution 1:
binary search

since this is a sorted array
we can always put mid as the root node, 
then put left part as node.left, right part as node.right
recursively add mid node into tree

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
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard !nums.isEmpty else { return nil }
        return bst(nums, 0, nums.count-1)
    }
    
    func bst(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode? {
        if left > right { return nil }
        let mid = left + (right-left)/2
        var node = TreeNode(nums[mid])
        node.left = bst(nums, left, mid-1)
        node.right = bst(nums, mid+1, right)
        return node
    }
}