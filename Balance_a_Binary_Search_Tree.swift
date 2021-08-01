/*
Given a binary search tree, return a balanced binary search tree with the same node values.

A binary search tree is balanced if and only if the depth of the two subtrees of every node never differ by more than 1.

If there is more than one answer, return any of them.



Example 1:



Input: root = [1,null,2,null,3,null,4,null,null]
Output: [2,1,3,null,null,null,4]
Explanation: This is not the only correct answer, [3,1,4,null,2,null,null] is also correct.


Constraints:

The number of nodes in the tree is between 1 and 10^4.
The tree nodes will have distinct values between 1 and 10^5.
*/

/*
Solution 1:
inorder + recursion

inorder traverse binary search tree, get a sorted value array
build balanced binary search tree by using this sortedArray
- always pick mid as root value, then [start..<mid] is left subtree, [(mid+1)...end] is right subtree

Time Complexity: O(n)
- n is number of binary search tree nodes
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
    func balanceBST(_ root: TreeNode?) -> TreeNode? {
        var sortedArr = [Int]()
        inorder(root, &sortedArr)
        return buildBalanceBST(sortedArr, 0, sortedArr.count-1)
    }

    func buildBalanceBST(_ sortedArr: [Int], _ start: Int, _ end: Int) -> TreeNode? {
        guard start <= end else { return nil }
        let mid = start + (end-start)/2
        var node = TreeNode(sortedArr[mid])
        node.left = buildBalanceBST(sortedArr, start, mid-1)
        node.right = buildBalanceBST(sortedArr, mid+1, end)
        return node
    }

    func inorder(_ node: TreeNode?, _ sortedArr: inout [Int]) {
        guard let node = node else { return }
        inorder(node.left, &sortedArr)
        sortedArr.append(node.val)
        inorder(node.right, &sortedArr)
    }
}