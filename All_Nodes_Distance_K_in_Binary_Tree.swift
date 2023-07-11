/*
Given the root of a binary tree, the value of a target node target, and an integer k, return an array of the values of all nodes that have a distance k from the target node.

You can return the answer in any order.



Example 1:


Input: root = [3,5,1,6,2,0,8,null,null,7,4], target = 5, k = 2
Output: [7,4,1]
Explanation: The nodes that are a distance 2 from the target node (with value 5) have values 7, 4, and 1.
Example 2:

Input: root = [1], target = 1, k = 3
Output: []


Constraints:

The number of nodes in the tree is in the range [1, 500].
0 <= Node.val <= 500
All the values Node.val are unique.
target is the value of one of the nodes in the tree.
0 <= k <= 1000
*/

/*
Solution 1:
DFS

dfs to map each node parent
dfs again to find target node distance k node list

Time Complexity: O(n)
Space Complexity: O(n)
*/
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    func distanceK(_ root: TreeNode?, _ target: TreeNode?, _ k: Int) -> [Int] {
        var parentMap = [TreeNode: TreeNode?]()
        dfs(root, nil, &parentMap)

        var res = [Int]()
        dfsK(target, k, nil, parentMap, &res)
        return res
    }

    func dfs(_ node: TreeNode?, _ parent: TreeNode?, _ parentMap: inout [TreeNode: TreeNode?]) {
        guard let node = node else { return }
        parentMap[node] = parent
        dfs(node.left, node, &parentMap)
        dfs(node.right, node, &parentMap)
    }

    func dfsK(_ node: TreeNode?, _ k: Int, _ parent: TreeNode?, _ parentMap: [TreeNode: TreeNode?], _ res: inout [Int]) {
        guard let node = node else { return }
        if k == 0 {
            res.append(node.val)
            return
        }
        if node.left != parent {
            dfsK(node.left, k-1, node, parentMap, &res)
        }
        if node.right != parent {
            dfsK(node.right, k-1, node, parentMap, &res)
        }
        if let parentNode = parentMap[node], parentNode != parent {
            dfsK(parentNode, k-1, node, parentMap, &res)
        }
    }
}

extension TreeNode: Hashable, Equatable {
    public var hashValue: Int {
        return self.val
    }

    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool{
        return lhs.val == rhs.val
    }
}
