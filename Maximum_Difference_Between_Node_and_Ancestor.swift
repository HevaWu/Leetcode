/*
026. Maximum Difference Between Node and Ancestor
Medium
3.3K
79
Companies
Given the root of a binary tree, find the maximum value v for which there exist different nodes a and b where v = |a.val - b.val| and a is an ancestor of b.

A node a is an ancestor of b if either: any child of a is equal to b or any child of a is an ancestor of b.



Example 1:


Input: root = [8,3,10,1,6,null,14,null,null,4,7,13]
Output: 7
Explanation: We have various ancestor-node differences, some of which are given below :
|8 - 3| = 5
|3 - 7| = 4
|8 - 1| = 7
|10 - 13| = 3
Among all possible differences, the maximum value of 7 is obtained by |8 - 1| = 7.
Example 2:


Input: root = [1,null,2,null,0,3]
Output: 3


Constraints:

The number of nodes in the tree is in the range [2, 5000].
0 <= Node.val <= 105
*/

/*
Solution 1:
itrate all path, and keep record minVal maxVal in the path

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
    func maxAncestorDiff(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var maxDiff = 0
        check(root, root.val, root.val, &maxDiff)
        return maxDiff
    }

    func check(_ node: TreeNode?, _ minVal: Int, _ maxVal: Int, _ maxDiff: inout Int) {
        guard let node = node else { return }
        let tmin = min(minVal, node.val)
        let tmax = max(maxVal, node.val)
        if tmax - tmin > maxDiff {
            maxDiff = tmax - tmin
        }
        check(node.left, tmin, tmax, &maxDiff)
        check(node.right, tmin, tmax, &maxDiff)
    }
}
