/*
Given the root of a binary tree, determine if it is a complete binary tree.

In a complete binary tree, every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.



Example 1:


Input: root = [1,2,3,4,5,6]
Output: true
Explanation: Every level before the last is full (ie. levels with node-values {1} and {2, 3}), and all nodes in the last level ({4, 5, 6}) are as far left as possible.
Example 2:


Input: root = [1,2,3,4,5,null,7]
Output: false
Explanation: The node with value 7 isn't as far left as possible.


Constraints:

The number of nodes in the tree is in the range [1, 100].
1 <= Node.val <= 1000
*/

/*
Solution 1:
recursive

use a level array to help record if current level is left filled
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
    func isCompleteTree(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        // level[i] represents "if current node is left filled"
        var level = [Bool]()
        if check(root, 0, &level) == false { return false }
        // print(level)
        // check if all previous level is all left filled, except last level, -2 because, there will always be a false for all nil child at last line
        for i in 0..<(level.count-2) {
            if level[i] == false {
                return false
            }
        }
        return true
    }

    // return if this node (include its child is complete tree)
    func check(_ node: TreeNode?, _ indexLevel: Int, _ level: inout [Bool]) -> Bool {
        guard let node = node else {
            if indexLevel == level.count {
                level.append(false)
            }
            level[indexLevel] = false
            return true
        }

        // node has value
        if indexLevel == level.count {
            level.append(true)
        } else {
            if level[indexLevel] == false {
                return false
            }
        }
        return check(node.left, indexLevel+1, &level) && check(node.right, indexLevel+1, &level)
    }
}
