/*
Given the root of a binary tree, calculate the vertical order traversal of the binary tree.

For each node at position (x, y), its left and right children will be at positions (x - 1, y - 1) and (x + 1, y - 1) respectively.

The vertical order traversal of a binary tree is a list of non-empty reports for each unique x-coordinate from left to right. Each report is a list of all nodes at a given x-coordinate. The report should be primarily sorted by y-coordinate from highest y-coordinate to lowest. If any two nodes have the same y-coordinate in the report, the node with the smaller value should appear earlier.

Return the vertical order traversal of the binary tree.

 

Example 1:


Input: root = [3,9,20,null,null,15,7]
Output: [[9],[3,15],[20],[7]]
Explanation: Without loss of generality, we can assume the root node is at position (0, 0):
The node with value 9 occurs at position (-1, -1).
The nodes with values 3 and 15 occur at positions (0, 0) and (0, -2).
The node with value 20 occurs at position (1, -1).
The node with value 7 occurs at position (2, -2).
Example 2:


Input: root = [1,2,3,4,5,6,7]
Output: [[4],[2],[1,5,6],[3],[7]]
Explanation: The node with value 5 and the node with value 6 have the same position according to the given scheme.
However, in the report [1,5,6], the node with value 5 comes first since 5 is smaller than 6.
 

Constraints:

The number of nodes in the tree is in the range [1, 1000].
0 <= Node.val <= 1000
*/

/*
Solution 1:
BFS

1. go through tree, and store nodeInfo(node, x, y) into map
- node.left, x-1, y+1
- node.right, x+1, y+1
- map = [Int: [Int: [Int]]]
  - key1 is x
  - key2 is y
  - val is node.val list
2. store to res
  - sort map based on key1
  - sort map based on key2
  - try to append element in map[k]![v]!.sorted()

Time Complexity: O(n + n log n) where n is total node in the tree
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
    func verticalTraversal(_ root: TreeNode?) -> [[Int]] {
        guard let node = root else { return [] }
        var map = [Int: [Int: [Int]]]()
        var queue: [NodeInfo] = [NodeInfo(node: node, x: 0, y: 0)]
        
        while !queue.isEmpty {
            let curNodeInfo = queue.removeFirst()
            let curNode = curNodeInfo.node
            let x = curNodeInfo.x
            let y = curNodeInfo.y
            
            map[x, default: [Int: [Int]]()][y, default: [Int]()].append(curNode.val)
            
            if let left = curNode.left {
                queue.append(NodeInfo(node: left, x: x-1, y: y+1))
            }
            
            if let right = curNode.right {
                queue.append(NodeInfo(node: right, x: x+1, y: y+1))
            }
        }
        
        // print(map)
        var res = [[Int]]()
        for k in map.keys.sorted() {
            var cur = [Int]()
            
            // use > to control element push element from higher y
            for v in map[k]!.keys.sorted() {
                // sort is required
                // left side element might larger than right one
                // ex: [0,2,1,3,null,null,null,4,5,null,7,6,null,10,8,11,9]
                let temp = map[k]![v]!.sorted()
                cur.append(contentsOf: temp)
                // print(map[k]![v]!)
            }
            res.append(cur)
        }
        return res
    }
}

struct NodeInfo {
    let node: TreeNode
    let x: Int
    let y: Int
}