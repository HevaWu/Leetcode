/*
Given a binary tree, return the sum of values of nodes with even-valued grandparent.  (A grandparent of a node is the parent of its parent, if it exists.)

If there are no nodes with an even-valued grandparent, return 0.



Example 1:



Input: root = [6,7,8,2,7,1,3,9,null,1,4,null,null,null,5]
Output: 18
Explanation: The red nodes are the nodes with even-value grandparent while the blue nodes are the even-value grandparents.


Constraints:

The number of nodes in the tree is between 1 and 10^4.
The value of nodes is between 1 and 100.
*/

/*
Solution 1:
pre-order traversal of the tree

by passing parentIsEven to help this node.children to check their grandparent node.

Time Complexity: O(n)
- n is number of tree nodes
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
    func sumEvenGrandparent(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var sum = 0
        let isEven = root.val % 2 == 0 ? true : false
        check(root.left, isEven, &sum)
        check(root.right, isEven, &sum)
        return sum
    }

    // preorder traversal
    func check(_ node: TreeNode?, _ parentIsEven: Bool, _ sum: inout Int) {
        guard let node = node else { return }
        if parentIsEven {
            sum += (node.left?.val ?? 0)
            sum += (node.right?.val ?? 0)
        }

        let isEven = node.val % 2 == 0 ? true : false
        check(node.left, isEven, &sum)
        check(node.right, isEven, &sum)
    }
}