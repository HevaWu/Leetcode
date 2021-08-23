/*
Given the root of a Binary Search Tree and a target number k, return true if there exist two elements in the BST such that their sum is equal to the given target.



Example 1:


Input: root = [5,3,6,2,4,null,7], k = 9
Output: true
Example 2:


Input: root = [5,3,6,2,4,null,7], k = 28
Output: false
Example 3:

Input: root = [2,1,3], k = 4
Output: true
Example 4:

Input: root = [2,1,3], k = 1
Output: false
Example 5:

Input: root = [2,1,3], k = 3
Output: true


Constraints:

The number of nodes in the tree is in the range [1, 104].
-104 <= Node.val <= 104
root is guaranteed to be a valid binary search tree.
-105 <= k <= 105
*/

/*
Solution 1:
recursively check tree node's k-node.val exist or not.

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
    var arrSet = Set<Int>()

    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        guard let root = root else { return false }

        if arrSet.contains(k-root.val) {
            return true
        }

        arrSet.insert(root.val)

        if findTarget(root.left, k) || findTarget(root.right, k) {
            return true
        }
        return false
    }
}

/*
Solution 1:
convert to sorted Array
then do 2 sum in sorted array

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
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        var arr = [Int]()
        traverse(root, &arr)

        return findTarget(arr, k)
    }

    func findTarget(_ arr: [Int], _ k: Int) -> Bool {
        var arrSet = Set(arr)
        for num in arr {
            // bst, all element is unique
            if k - num != num, arrSet.contains(k - num) {
                return true
            }
        }
        return false
    }

    func traverse(_ node: TreeNode?, _ arr: inout [Int]) {
        guard let node = node else { return }
        traverse(node.left, &arr)
        arr.append(node.val)
        traverse(node.right, &arr)
    }
}