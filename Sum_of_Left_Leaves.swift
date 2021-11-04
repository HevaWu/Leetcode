/*
Given the root of a binary tree, return the sum of all left leaves.



Example 1:


Input: root = [3,9,20,null,null,15,7]
Output: 24
Explanation: There are two left leaves in the binary tree, with values 9 and 15 respectively.
Example 2:

Input: root = [1]
Output: 0


Constraints:

The number of nodes in the tree is in the range [1, 1000].
-1000 <= Node.val <= 1000
*/

/*
Solution 2:
Stack

Time Complexity: O(n)
Space Complexity: O(logn)
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
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var sum = 0
        var stack: [TreeNode] = [root]
        while !stack.isEmpty {
            let cur = stack.removeLast()
            if let left = cur.left {
                if left.left == nil && left.right == nil {
                    sum += left.val
                } else {
                    stack.append(left)
                }
            }
            if let right = cur.right {
                stack.append(right)
            }
        }
        return sum
    }
}

/*
Solution 1:
recursive

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
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var sum = 0
        checkLeft(root, &sum)
        return sum
    }

    func checkLeft(_ node: TreeNode, _ sum: inout Int) {
        if let left = node.left {
            // check if this left node is leaves
            if left.left == nil, left.right == nil {
                sum += left.val
            } else {
                checkLeft(left, &sum)
            }
        }
        if let right = node.right {
            checkLeft(right, &sum)
        }
    }
}