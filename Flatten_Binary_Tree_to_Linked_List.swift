/*
Given the root of a binary tree, flatten the tree into a "linked list":

The "linked list" should use the same TreeNode class where the right child pointer points to the next node in the list and the left child pointer is always null.
The "linked list" should be in the same order as a pre-order traversal of the binary tree.


Example 1:


Input: root = [1,2,5,3,4,null,6]
Output: [1,null,2,null,3,null,4,null,5,null,6]
Example 2:

Input: root = []
Output: []
Example 3:

Input: root = [0]
Output: [0]


Constraints:

The number of nodes in the tree is in the range [0, 2000].
-100 <= Node.val <= 100


Follow up: Can you flatten the tree in-place (with O(1) extra space)?
*/

/*
Solution 2:
iterative

Stack to track root, right, left
build from top to bottom

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
    func flatten(_ root: TreeNode?) {
        guard let root = root else { return }
        var cur = root
        var stack = [TreeNode]()

        if let r = cur.right {
            stack.append(r)
        }
        if let l = cur.left {
            stack.append(l)
        }

        while !stack.isEmpty {
            let node = stack.removeLast()
            if let r = node.right {
                stack.append(r)
            }
            if let l = node.left {
                stack.append(l)
            }
            // add node to cur
            cur.left = nil
            cur.right = node
            cur = node
        }
    }
}

/*
Solution 1:
traverse

start from the first right leaf node, then the left node
use next pointer to control the position of the next node
from the bottom to the top of the tree
from the right to left flatten the tree

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
    var next: TreeNode?
    func flatten(_ root: TreeNode?) {
        guard let root = root else { return }
        flatten(root.right)
        flatten(root.left)
        root.right = next
        root.left = nil
        next = root
    }
}