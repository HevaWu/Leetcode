/*
You are given the root of a binary tree with unique values, and an integer start. At minute 0, an infection starts from the node with value start.

Each minute, a node becomes infected if:

The node is currently uninfected.
The node is adjacent to an infected node.
Return the number of minutes needed for the entire tree to be infected.



Example 1:


Input: root = [1,5,3,null,4,10,6,9,2], start = 3
Output: 4
Explanation: The following nodes are infected during:
- Minute 0: Node 3
- Minute 1: Nodes 1, 10 and 6
- Minute 2: Node 5
- Minute 3: Node 4
- Minute 4: Nodes 9 and 2
It takes 4 minutes for the whole tree to be infected so we return 4.
Example 2:


Input: root = [1], start = 1
Output: 0
Explanation: At minute 0, the only node in the tree is infected so we return 0.


Constraints:

The number of nodes in the tree is in the range [1, 105].
1 <= Node.val <= 105
Each node has a unique value.
A node with a value of start exists in the tree.
*/


/*
Solution 1:
Convert the tree to graph first
Then BFS to find the time

Time Complexity: O(n + logn)
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
    func amountOfTime(_ root: TreeNode?, _ start: Int) -> Int {
        var map = [Int: Set<Int>]()
        convert(root, 0, &map)
        // print(map)
        var queue = [Int]()
        queue.append(start)
        var minutes = 0
        var visited = Set<Int>()
        visited.insert(start)

        while !queue.isEmpty {
            var size = queue.count
            for _ in 0..<size {
                var cur = queue.removeFirst()
                for num in map[cur, default: Set<Int>()] {
                    if !visited.contains(num) {
                        visited.insert(num)
                        queue.append(num)
                    }
                }
            }
            minutes += 1
        }
        return minutes - 1
    }

    func convert(_ node: TreeNode?, _ parent: Int, _ map: inout [Int: Set<Int>]) {
        guard let node = node else { return }
        var adjSet = map[node.val, default: Set<Int>()]
        if parent != 0 {
            adjSet.insert(parent)
        }
        if let left = node.left {
            adjSet.insert(left.val)
            convert(left, node.val, &map)
        }
        if let right = node.right {
            adjSet.insert(right.val)
            convert(right, node.val, &map)
        }
        map[node.val] = adjSet
    }
}
