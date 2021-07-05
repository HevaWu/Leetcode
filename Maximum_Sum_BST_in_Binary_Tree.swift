/*
Given a binary tree root, the task is to return the maximum sum of all keys of any sub-tree which is also a Binary Search Tree (BST).

Assume a BST is defined as follows:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than the node's key.
Both the left and right subtrees must also be binary search trees.


Example 1:



Input: root = [1,4,3,2,4,2,5,null,null,null,null,null,null,4,6]
Output: 20
Explanation: Maximum sum in a valid Binary search tree is obtained in root node with key equal to 3.
Example 2:



Input: root = [4,3,null,1,2]
Output: 2
Explanation: Maximum sum in a valid Binary search tree is obtained in a single root node with key equal to 2.
Example 3:

Input: root = [-4,-2,-5]
Output: 0
Explanation: All values are negatives. Return an empty BST.
Example 4:

Input: root = [2,1,3]
Output: 6
Example 5:

Input: root = [5,4,8,3,null,6,3]
Output: 7


Constraints:

The given binary tree will have between 1 and 40000 nodes.
Each node's value is between [-4 * 10^4 , 4 * 10^4].

*/

/*
Solution 1:
recursively

use BSTNode to record
- val
- isBST: BST or not
- sum: sum value of element in BST
- maxVal: max val in this BST
- minVal: min val in this BST

use build(tNode: TreeNode, maxSum: Int) -> BSTNode
to return BSTNode
- check if the tNode is nil or not
- get bLeft which is result of build(tNode.left, maxSum)
- get bRight which is result of build(tNode.right, maxSum)
- check if
    - bLeft is BST
    - bRight is BST
    - bLeft.maxVal < tNode.val
    - tNode.val < bRight.minVal
    => current node's isBST is true,
    => update current node's params
        - isBST = true
        - minVal = bLeft.minVal
        - maxVal = bRight.maxVal
        - sum = bLeft.sum + bRight.sum + tNode.val
        => check maxSum, max(maxSum, sum)
- return this bst node

Time Complexity: O(n)
- n is number of treeNode
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
    func maxSumBST(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var maxSum = 0
        build(root, &maxSum)
        return maxSum
    }

    func build(_ tNode: TreeNode?, _ maxSum: inout Int) -> BSTNode? {
        guard let tNode = tNode else { return nil }

        var bNode = BSTNode(tNode.val)
        let bLeft = build(tNode.left, &maxSum)
        let bRight = build(tNode.right, &maxSum)

        if bLeft?.isBST ?? true,
        bRight?.isBST ?? true,
        (bLeft?.maxVal ?? tNode.val-1) < tNode.val,
        tNode.val < (bRight?.minVal ?? tNode.val+1) {
            bNode.isBST = true
            bNode.minVal = bLeft?.minVal ?? tNode.val
            bNode.maxVal = bRight?.maxVal ?? tNode.val
            bNode.sum = (bLeft?.sum ?? 0) + (bRight?.sum ?? 0) + tNode.val
            maxSum = max(maxSum, bNode.sum)
        }
        return bNode
    }
}

class BSTNode {
    let val: Int

    var isBST = false

    // sum of current BST
    var sum: Int

    // if this is a BST,
    // record current tree's maxVal and minVal
    var maxVal: Int
    var minVal: Int

    init(_ val: Int) {
        self.val = val
        self.maxVal = val
        self.minVal = val
        self.sum = val
    }
}