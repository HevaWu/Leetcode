/*
Given two binary search trees root1 and root2.

Return a list containing all the integers from both trees sorted in ascending order.



Example 1:


Input: root1 = [2,1,4], root2 = [1,0,3]
Output: [0,1,1,2,3,4]
Example 2:

Input: root1 = [0,-10,10], root2 = [5,1,7,0,2]
Output: [-10,0,0,1,2,5,7,10]
Example 3:

Input: root1 = [], root2 = [5,1,7,0,2]
Output: [0,1,2,5,7]
Example 4:

Input: root1 = [0,-10,10], root2 = []
Output: [-10,0,10]
Example 5:


Input: root1 = [1,null,8], root2 = [8,1]
Output: [1,1,8,8]


Constraints:

Each tree has at most 5000 nodes.
Each node's value is between [-10^5, 10^5].
*/

/*
Solution 1:
preorder traverse tree

traverse 2 tree and have 2 sorted list
merge 2 sorted list and generate results

Time Complexity: O(n1 + n2)
Space Complexity: O(n1 + n2)
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
    func getAllElements(_ root1: TreeNode?, _ root2: TreeNode?) -> [Int] {
        if root1 == nil, root2 == nil { return [Int]() }

        var list1 = traverse(root1)
        var list2 = traverse(root2)

        // merge list1 and list2 to a sorted list
        var list = [Int]()
        while !list1.isEmpty || !list2.isEmpty {
            if !list1.isEmpty, !list2.isEmpty {
                if list1.first! < list2.first! {
                    list.append(list1.removeFirst())
                } else {
                    list.append(list2.removeFirst())
                }
            } else if !list1.isEmpty {
                list.append(list1.removeFirst())
            } else if !list2.isEmpty {
                list.append(list2.removeFirst())
            }
        }
        return list
    }

    func traverse(_ node: TreeNode?) -> [Int] {
        guard let node = node else { return [] }
        return traverse(node.left) + [node.val] + traverse(node.right)
    }
}