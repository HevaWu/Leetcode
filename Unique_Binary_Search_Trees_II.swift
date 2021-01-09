/*
Given an integer n, generate all structurally unique BST's (binary search trees) that store values 1 ... n.

Example:

Input: 3
Output:
[
  [1,null,3,2],
  [3,2,null,1],
  [3,1,null,null,2],
  [2,1,3],
  [1,null,2,null,3]
]
Explanation:
The above output corresponds to the 5 unique BST's shown below:

   1         3     3      2      1
    \       /     /      / \      \
     3     2     1      1   3      2
    /     /       \                 \
   2     1         2                 3
 

Constraints:

0 <= n <= 8
*/

/*
Solution 1:
recusive 

- go through from 1...n
- for node i
- get all left node, 1 to i-1
- get all right node, i+1 to n
- set root as TreeNode(i), append left, right, push into res

TimeComplexity: O(n^4)
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
    func generateTrees(_ n: Int) -> [TreeNode?] {
        if n == 0 { return [] }
        return buildTree(1, n)
    }
    
    func buildTree(_ start: Int, _ end: Int) -> [TreeNode?] {
        if start > end { return [nil] }
        var res: [TreeNode?] = []
        for i in start...end {
            let left = buildTree(start, i-1)
            let right = buildTree(i+1, end)
            for l in left {
                for r in right {
                    let root = TreeNode(i)
                    root.left = l
                    root.right = r
                    res.append(root)
                }
            }
        }
        return res
    }
}