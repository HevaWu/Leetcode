/*
You are given the root of a binary tree where each node has a value 0 or 1. Each root-to-leaf path represents a binary number starting with the most significant bit.

For example, if the path is 0 -> 1 -> 1 -> 0 -> 1, then this could represent 01101 in binary, which is 13.
For all leaves in the tree, consider the numbers represented by the path from the root to that leaf. Return the sum of these numbers.

The test cases are generated so that the answer fits in a 32-bits integer.



Example 1:


Input: root = [1,0,1,0,1,0,1]
Output: 22
Explanation: (100) + (101) + (110) + (111) = 4 + 5 + 6 + 7 = 22
Example 2:

Input: root = [0]
Output: 0


Constraints:

The number of nodes in the tree is in the range [1, 1000].
Node.val is 0 or 1.
*/

/*
Solution 3:
stack + iterative

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
    func sumRootToLeaf(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var stack = [(node: TreeNode, cur: Int)]()
        stack.append((root, root.val))

        var sum = 0
        while !stack.isEmpty {
            let (node, cur) = stack.removeLast()

            if node.left == nil && node.right == nil {
                sum += cur
            } else {
                if let left = node.left {
                    stack.append((left, cur<<1 + left.val))
                }
                if let right = node.right {
                    stack.append((right, cur<<1 + right.val))
                }
            }
        }

        return sum
    }
}

/*
Solution 2:
improve solution 1 by using cur: Int to record current path
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
    func sumRootToLeaf(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var sum = 0
        sumRoot(root, 0, &sum)
        return sum
    }

    func sumRoot(_ node: TreeNode, _ cur: Int, _ sum: inout Int) {
        var cur = cur << 1 + node.val
        if node.left == nil && node.right == nil {
            sum += cur
            return
        }

        if let left = node.left {
            sumRoot(left, cur, &sum)
        }
        if let right = node.right {
            sumRoot(right, cur, &sum)
        }
    }
}

/*
Solution 1:
Recursive

use cur: [Int] record current path
use sum record current sum of all path value

Time Complexity: O(2n)
Space Complexity: O(2n)
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
    func sumRootToLeaf(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var sum = 0
        sumRoot(root, [Int](), &sum)
        return sum
    }

    func sumRoot(_ node: TreeNode, _ cur: [Int], _ sum: inout Int) {
        var cur = cur
        cur.append(node.val)
        if node.left == nil && node.right == nil {
            sum += getVal(from: cur)
            return
        }

        if let left = node.left {
            sumRoot(left, cur, &sum)
        }
        if let right = node.right {
            sumRoot(right, cur, &sum)
        }
    }

    func getVal(from arr: [Int]) -> Int {
        var val = 0
        for num in arr {
            val = val << 1 + num
        }
        return val
    }
}