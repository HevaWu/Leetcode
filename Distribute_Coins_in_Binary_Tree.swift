/*
You are given the root of a binary tree with n nodes where each node in the tree has node.val coins. There are n coins in total throughout the whole tree.

In one move, we may choose two adjacent nodes and move one coin from one node to another. A move may be from parent to child, or from child to parent.

Return the minimum number of moves required to make every node have exactly one coin.



Example 1:


Input: root = [3,0,0]
Output: 2
Explanation: From the root of the tree, we move one coin to its left child, and one coin to its right child.
Example 2:


Input: root = [0,3,0]
Output: 3
Explanation: From the left child of the root, we move two coins to the root [taking two moves]. Then, we move one coin from the root of the tree to the right child.
Example 3:


Input: root = [1,0,2]
Output: 2
Example 4:


Input: root = [1,0,0,null,3]
Output: 4


Constraints:

The number of nodes in the tree is n.
1 <= n <= 100
0 <= Node.val <= n
The sum of all Node.val is n.
*/

/*
Solution 1:
DFS

If the leaf of a tree has 0 coins (an excess of -1 from what it needs), then we should push a coin from its parent onto the leaf. If it has say, 4 coins (an excess of 3), then we should push 3 coins off the leaf. In total, the number of moves from that leaf to or from its parent is excess = Math.abs(num_coins - 1). Afterwards, we never have to consider this leaf again in the rest of our calculation.

Time Complexity: O(n)
n is number of node

Space Complexity: O(h)
h is height of the tree
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
    func distributeCoins(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var moves = 0
        traverse(root, &moves)
        return moves
    }

    func traverse(_ node: TreeNode?, _ moves: inout Int) -> Int {
        guard let node = node else { return 0 }
        let val = node.val
        let l = traverse(node.left, &moves)
        let r = traverse(node.right, &moves)

        moves += (abs(l) + abs(r))
        return val - 1 + l + r
    }
}