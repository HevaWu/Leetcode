/*
Given a binary tree root, a node X in the tree is named good if in the path from root to X there are no nodes with a value greater than X.

Return the number of good nodes in the binary tree.



Example 1:



Input: root = [3,1,4,3,null,1,5]
Output: 4
Explanation: Nodes in blue are good.
Root Node (3) is always a good node.
Node 4 -> (3,4) is the maximum value in the path starting from the root.
Node 5 -> (3,4,5) is the maximum value in the path
Node 3 -> (3,1,3) is the maximum value in the path.
Example 2:



Input: root = [3,3,null,4,2]
Output: 3
Explanation: Node 2 -> (3, 3, 2) is not good, because "3" is higher than it.
Example 3:

Input: root = [1]
Output: 1
Explanation: Root is considered as good.


Constraints:

The number of nodes in the binary tree is in the range [1, 10^5].
Each node's value is between [-10^4, 10^4].
*/

/*
Solution 2:
iterative DFS

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
    func goodNodes(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var num = 0

        // dfs
        var stack: [Node] = [Node(root, root.val)]

        while !stack.isEmpty {
            let cur = stack.removeLast()
            if cur.node.val >= cur.maxVal {
                num += 1
            }

            if let l = cur.node.left {
                stack.append(Node(l, max(cur.node.val, cur.maxVal)))
            }

            if let r = cur.node.right {
                stack.append(Node(r, max(cur.node.val, cur.maxVal)))
            }
        }

        return num
    }
}

class Node {
    var node: TreeNode
    var maxVal: Int
    init(_ node: TreeNode, _ maxVal: Int) {
        self.node = node
        self.maxVal = maxVal
    }
}

/*
Solution 1:
recursively traverse the tree, and count good node numbers

Time Complexity: O(n)
- n is number of tree node
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
    func goodNodes(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var count = 0
        check(root, &count, nil)
        return count
    }

    func check(_ node: TreeNode?, _ count: inout Int, _ preMax: Int?) {
        guard let node = node else { return }
        if preMax == nil || node.val >= preMax! {
            // good node
            count += 1
            check(node.left, &count, node.val)
            check(node.right, &count, node.val)
        } else {
            check(node.left, &count, preMax)
            check(node.right, &count, preMax)
        }

    }
}
