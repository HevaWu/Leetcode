/*
Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).

For example:
Given binary tree [3,9,20,null,null,15,7],
    3
   / \
  9  20
    /  \
   15   7
return its level order traversal as:
[
  [3],
  [9,20],
  [15,7]
]
*/

/*
Solution 2:
iterative,
Queue

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
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var order = [[Int]]()
        guard let root = root else { return order }
        var queue = [(node: TreeNode, depth: Int)]()
        queue.append((root, 0))
        while !queue.isEmpty {
            let (node, depth) = queue.removeFirst()
            if order.count == depth {
                order.append([node.val])
            } else {
                order[depth].append(node.val)
            }

            if let l = node.left {
                queue.append((l, depth+1))
            }
            if let r = node.right {
                queue.append((r, depth+1))
            }
        }
        return order
    }
}

/*
Solution 1:
do this by recursively traverse Tree in "Preorder"

withe adding level to append node.val res[level].append(node.val)
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
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var res = [[Int]]()
        _levelOrder(root, &res, 0)
        return res
    }

    func _levelOrder(_ node: TreeNode?, _ res: inout [[Int]], _ level: Int) {
        guard let node = node else { return }
        if res.count == level {
            res.append([node.val])
        } else {
            res[level].append(node.val)
        }

        _levelOrder(node.left, &res, level+1)
        _levelOrder(node.right, &res, level+1)
    }
}