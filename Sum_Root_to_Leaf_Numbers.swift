/*
You are given the root of a binary tree containing digits from 0 to 9 only.

Each root-to-leaf path in the tree represents a number.

For example, the root-to-leaf path 1 -> 2 -> 3 represents the number 123.
Return the total sum of all root-to-leaf numbers. Test cases are generated so that the answer will fit in a 32-bit integer.

A leaf node is a node with no children.



Example 1:


Input: root = [1,2,3]
Output: 25
Explanation:
The root-to-leaf path 1->2 represents the number 12.
The root-to-leaf path 1->3 represents the number 13.
Therefore, sum = 12 + 13 = 25.
Example 2:


Input: root = [4,9,0,5,1]
Output: 1026
Explanation:
The root-to-leaf path 4->9->5 represents the number 495.
The root-to-leaf path 4->9->1 represents the number 491.
The root-to-leaf path 4->0 represents the number 40.
Therefore, sum = 495 + 491 + 40 = 1026.


Constraints:

The number of nodes in the tree is in the range [1, 1000].
0 <= Node.val <= 9
The depth of the tree will not exceed 10.
*/

/*
Solution 2:
iterative stack DFS

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
    func sumNumbers(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var sum = 0
        var stack = [(node: TreeNode, val: Int)]()
        stack.append((root, root.val))

        while !stack.isEmpty {
            let (node, val) = stack.removeLast()

            if node.left == nil && node.right == nil {
                sum += val
            } else {
                if let left = node.left {
                    stack.append((left, val*10 + left.val))
                }
                if let right = node.right {
                    stack.append((right, val*10 + right.val))
                }
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
    func sumNumbers(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var sum = 0
        check(root, root.val, &sum)
        return sum
    }

    func check(_ node: TreeNode, _ cur: Int, _ sum: inout Int) {
        if node.left == nil && node.right == nil {
            // current node is leaf node
            sum += cur
        } else {
            if let left = node.left {
                check(left, cur*10 + left.val, &sum)
            }
            if let right = node.right {
                check(right, cur*10 + right.val, &sum)
            }
        }
    }
}
