/*
Given the root of a binary tree, the level of its root is 1, the level of its children is 2, and so on.

Return the smallest level x such that the sum of all the values of nodes at level x is maximal.



Example 1:


Input: root = [1,7,0,7,-8,null,null]
Output: 2
Explanation:
Level 1 sum = 1.
Level 2 sum = 7 + 0 = 7.
Level 3 sum = 7 + -8 = -1.
So we return the level with the maximum sum which is level 2.
Example 2:

Input: root = [989,null,10250,98693,-89388,null,null,null,-32127]
Output: 2


Constraints:

The number of nodes in the tree is in the range [1, 104].
-105 <= Node.val <= 105
*/

/*
Solution 1:
iterate over the tree, store each level's sum value
then go through level's sum array, find the maximum level sum

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
    func maxLevelSum(_ root: TreeNode?) -> Int {
        // arr[i], sum of node value in level i+1
        var arr = [Int]()
        check(root, 0, &arr)

        var index = 0
        for i in 0..<arr.count {
            if arr[i] > arr[index] {
                index = i
            }
        }
        return index+1
    }

    func check(_ node: TreeNode?, _ level: Int, _ arr: inout [Int]) {
        guard let node = node else { return }
        if level == arr.count {
            arr.append(node.val)
        } else {
            arr[level] += node.val
        }
        check(node.left, level+1, &arr)
        check(node.right, level+1, &arr)
    }
}
