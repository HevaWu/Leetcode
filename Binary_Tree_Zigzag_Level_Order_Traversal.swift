/*
Given a binary tree, return the zigzag level order traversal of its nodes' values. (ie, from left to right, then right to left for the next level and alternate between).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its zigzag level order traversal as:
[
  [3],
  [20,9],
  [15,7]
]
*/


/*
Solution 1
recursive

use level to check where to insert node.val
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
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        var res = [[Int]]()
        _zigzag(root, 0, &res)
        return res
    }
    
    func _zigzag(_ node: TreeNode?, _ level: Int, _ res: inout [[Int]]) {
        guard let node = node else { return }
        if res.count == level {
            res.append([Int]())
        }
        
        if level % 2 == 0 {
            res[level].append(node.val)   
        } else {
            res[level].insert(node.val, at: 0)
        }
        
        _zigzag(node.left, level+1, &res)
        _zigzag(node.right, level+1, &res)
    }
}