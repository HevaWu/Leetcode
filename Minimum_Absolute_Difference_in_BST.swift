/*
Given the root of a Binary Search Tree (BST), return the minimum absolute difference between the values of any two different nodes in the tree.



Example 1:


Input: root = [4,2,6,1,3]
Output: 1
Example 2:


Input: root = [1,0,48,null,null,12,49]
Output: 1


Constraints:

The number of nodes in the tree is in the range [2, 104].
0 <= Node.val <= 105


Note: This question is the same as 783: https://leetcode.com/problems/minimum-distance-between-bst-nodes/
*/

/*
Solution 2:
optimize solution 1, use "last" to record the previous element before node

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
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        var diff = 100_001
        var last = -1
        check(root, &diff, &last)
        return diff
    }

    // build array with left, node, right order of subtree
    func check(_ node: TreeNode?, _ diff: inout Int, _ last: inout Int) {
        guard let node = node else { return }
        check(node.left, &diff, &last)
        if last != -1 {
            diff = min(diff, node.val - last)
        }
        last = node.val
        check(node.right, &diff, &last)
    }
}

/*
Solution 1:
binary search tree, the left < node.val < right.val
use this feature, go through tree with left, node, right order

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
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        var diff = 100_001
        var arr = [Int]()
        check(root, &diff, &arr)
        return diff
    }

    // build array with left, node, right order of subtree
    func check(_ node: TreeNode?, _ diff: inout Int, _ arr: inout [Int]) {
        guard let node = node else { return }
        check(node.left, &diff, &arr)
        if !arr.isEmpty {
            diff = min(diff, node.val-arr.last!)
        }
        arr.append(node.val)
        check(node.right, &diff, &arr)
    }
}
