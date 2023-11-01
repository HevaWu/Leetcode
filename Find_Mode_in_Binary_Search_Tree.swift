/*
Given the root of a binary search tree (BST) with duplicates, return all the mode(s) (i.e., the most frequently occurred element) in it.

If the tree has more than one mode, return them in any order.

Assume a BST is defined as follows:

The left subtree of a node contains only nodes with keys less than or equal to the node's key.
The right subtree of a node contains only nodes with keys greater than or equal to the node's key.
Both the left and right subtrees must also be binary search trees.


Example 1:


Input: root = [1,null,2,2]
Output: [2]
Example 2:

Input: root = [0]
Output: [0]


Constraints:

The number of nodes in the tree is in the range [1, 104].
-105 <= Node.val <= 105


Follow up: Could you do that without using any extra space? (Assume that the implicit stack space incurred due to recursion does not count).
*/

/*
Solution 1:
find all nodes frequency
Then get the most frequent values key array

Time Complexity: O(n)
Space Complexity: O(nlogn)
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
    func findMode(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [] }
        var freq = [Int: Int]()
        var stack: [TreeNode] = [root]
        while !stack.isEmpty {
            let cur = stack.removeLast()
            freq[cur.val, default: 0] += 1
            if let left = cur.left {
                stack.append(left)
            }
            if let right = cur.right {
                stack.append(right)
            }
        }
        var sortedMap = freq.sorted(by: {$0.1 > $1.1})
        let maxVal = sortedMap[0].value
        var modes = [Int]()
        for (k,v) in sortedMap {
            if v == maxVal {
                modes.append(k)
            } else {
                break
            }
        }
        return modes
    }
}
