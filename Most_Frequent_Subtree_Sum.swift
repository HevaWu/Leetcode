/*
Given the root of a binary tree, return the most frequent subtree sum. If there is a tie, return all the values with the highest frequency in any order.

The subtree sum of a node is defined as the sum of all the node values formed by the subtree rooted at that node (including the node itself).



Example 1:


Input: root = [5,2,-3]
Output: [2,-3,4]
Example 2:


Input: root = [5,2,-5]
Output: [2]


Constraints:

The number of nodes in the tree is in the range [1, 104].
-105 <= Node.val <= 105
*/

/*
Solution 1:
preorder traverse tree
to get the subtreeSum map
with key is subtreeSum, val is freq
then, go through map to filter by maxFreq key

Time Complexity: O(n)
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
    func findFrequentTreeSum(_ root: TreeNode?) -> [Int] {
        guard let root = root else { return [Int]() }

        // key is subtreeSum
        // val is freq
        var map = [Int: Int]()
        check(root, &map)

        // get highest freq subtree sum array
        var maxFreq = map.values.max()
        return map.keys.filter { k -> Bool in
            return map[k] == maxFreq
        }
    }

    func check(_ node: TreeNode?, _ map: inout [Int: Int]) -> Int {
        guard let node = node else { return 0 }
        let leftSum = check(node.left, &map)
        let rightSum = check(node.right, &map)
        let subtreeSum = node.val + leftSum + rightSum
        map[subtreeSum, default: 0] += 1
        return subtreeSum
    }
}