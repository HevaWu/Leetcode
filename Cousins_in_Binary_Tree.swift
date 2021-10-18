/*
Given the root of a binary tree with unique values and the values of two different nodes of the tree x and y, return true if the nodes corresponding to the values x and y in the tree are cousins, or false otherwise.

Two nodes of a binary tree are cousins if they have the same depth with different parents.

Note that in a binary tree, the root node is at the depth 0, and children of each depth k node are at the depth k + 1.



Example 1:


Input: root = [1,2,3,4], x = 4, y = 3
Output: false
Example 2:


Input: root = [1,2,3,null,4,null,5], x = 5, y = 4
Output: true
Example 3:


Input: root = [1,2,3,null,4], x = 2, y = 3
Output: false


Constraints:

The number of nodes in the tree is in the range [2, 100].
1 <= Node.val <= 100
Each node has a unique value.
x != y
x and y are exist in the tree.
*/

/*
Solution 2:
BFS check same depth node

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
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        guard let root = root else {
            return false
        }

        if root.val == x || root.val == y { return false }

        var queue = [TreeNode]()
        queue.append(root)

        while !queue.isEmpty {
            let size = queue.count

            var findX = false
            var findY = false
            for i in 0..<size {
                let cur = queue.removeFirst()
                if cur.val == x {
                    findX = true
                }
                if cur.val == y {
                    findY = true
                }

                // check children for see the parent
                if let left = cur.left, let right = cur.right {
                    if (left.val == x && right.val == y)
                    || (left.val == y && right.val == x) {
                        return false
                    }
                }

                if let left = cur.left {
                    queue.append(left)
                }
                if let right = cur.right {
                    queue.append(right)
                }
            }

            if findX && findY { return true }
            if findX || findY { return false }
        }

        return false
    }
}

/*
Solution 1:
use dx, dy, isSameParent to track status when go through the tree

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
    func isCousins(_ root: TreeNode?, _ x: Int, _ y: Int) -> Bool {
        guard let root = root else {
            return false
        }
        var dx = root.val == x ? 0 : -1
        var dy = root.val == y ? 0 : -1
        var isSameParent = false
        check(root, x, y, 0, &dx, &dy, &isSameParent)
        return dx == dy && dx != -1 && !isSameParent
    }

    func check(_ node: TreeNode?, _ x: Int, _ y: Int,
               _ depth: Int,
               _ dx: inout Int, _ dy: inout Int,
               _ isSameParent: inout Bool) {
        guard let node = node else { return }

        if node.left?.val == x {
            dx = depth+1
            isSameParent = node.right?.val == y
        } else if node.left?.val == y {
            dy = depth+1
            isSameParent = node.right?.val == x
        } else if node.right?.val == x {
            dx = depth+1
            isSameParent = node.left?.val == y
        } else if node.right?.val == y {
            dy = depth+1
            isSameParent = node.left?.val == x
        }

        if dx != -1 && dy != -1 {
            return
        } else {
            check(node.left, x, y, depth+1, &dx, &dy, &isSameParent)
            check(node.right, x, y, depth+1, &dx, &dy, &isSameParent)
        }
    }
}