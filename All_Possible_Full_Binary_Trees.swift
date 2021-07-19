/*
Given an integer n, return a list of all possible full binary trees with n nodes. Each node of each tree in the answer must have Node.val == 0.

Each element of the answer is the root node of one possible tree. You may return the final list of trees in any order.

A full binary tree is a binary tree where each node has exactly 0 or 2 children.



Example 1:


Input: n = 7
Output: [[0,0,0,null,null,0,0,null,null,0,0],[0,0,0,null,null,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,null,null,null,null,0,0],[0,0,0,0,0,null,null,0,0]]
Example 2:

Input: n = 3
Output: [[0,0,0]]


Constraints:

1 <= n <= 20
*/

/*
Solution 1:
recursively find all possible children

after decide to pick one root,
for remain n-1 node,
iteratively from 1...(n-1) to add possible trees

let leftList = allPossibleFBT(i)
let rightList = allPossibleFBT(n-1-i)
val.append(contentsOf: generate(leftList, rightList))

Time Complexity: O(2^N)
Space Complexity: O(2^N)
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
    var cache = [Int: [TreeNode?]]()

    func allPossibleFBT(_ n: Int) -> [TreeNode?] {
        guard n > 0, n % 2 == 1 else { return [] }

        if let val = cache[n] {
            return val
        }

        var val = [TreeNode?]()
        if n == 1 {
            val.append(TreeNode(0))
            cache[n] = val
            return val
        }

        if n == 3 {
            var node = TreeNode(0)
            node.left = TreeNode(0)
            node.right = TreeNode(0)

            val.append(node)
            cache[n] = val
            return val
        }

        for i in stride(from: 1, through: n-2, by: 2) {
            let leftList = allPossibleFBT(i)
            let rightList = allPossibleFBT(n-1-i)

            val.append(contentsOf: generate(leftList, rightList))
        }

        cache[n] = val
        return val
    }

    func generate(_ leftList: [TreeNode?], _ rightList: [TreeNode?]) -> [TreeNode?] {
        var res = [TreeNode?]()
        for i in 0..<leftList.count {
            for j in 0..<rightList.count {
                var node = TreeNode(0)
                node.left = leftList[i]
                node.right = rightList[j]

                res.append(node)
            }
        }
        return res
    }
}