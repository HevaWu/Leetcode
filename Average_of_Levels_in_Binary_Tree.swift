/*
Given a non-empty binary tree, return the average value of the nodes on each level in the form of an array.
Example 1:
Input:
    3
   / \
  9  20
    /  \
   15   7
Output: [3, 14.5, 11]
Explanation:
The average value of nodes on level 0 is 3,  on level 1 is 14.5, and on level 2 is 11. Hence return [3, 14.5, 11].
Note:
The range of node's value is in the range of 32-bit signed integer.
*/

/*
Solution 2:
bfs traverse

use queue to memo current level
use temp to memo next level node

1. Put the root node into the queuequeue.
2. Initialize sumsum and countcount as 0 and temptemp as an empty queue.
3. Pop a node from the front of the queuequeue. Add this node's value to the sumsum corresponding to the current level. Also, update the countcount corresponding to the current level.
4. Put the children nodes of the node last popped into the a temptemp queue(instead of queuequeue).
5. Continue steps 3 and 4 till queuequeue becomes empty. (An empty queuequeue indicates that one level of the tree has been considered).
6. Reinitialize queuequeue with its value as temptemp.
7. Populate the resres array with the average corresponding to the current level.
8. Repeat steps 2 to 7 till the queuequeue and temptemp become empty.

Time Complexity: O(n)
Space Complexity: O(m) size of queue or temp can grow up to
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
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        guard let node = root else { return [0] }
        
        var queue: [TreeNode] = [node]
        
        // use to memo next level TreeNode
        var temp = [TreeNode]()
        
        var sum = 0
        var count = 0
        var res = [Double]()
        
        while !queue.isEmpty {
            let cur = queue.removeFirst()
            
            count += 1
            sum += cur.val
            
            if let left = cur.left {
                temp.append(left)
            }
            if let right = cur.right {
                temp.append(right)
            }
            
            if queue.isEmpty {
                res.append(Double(sum)/Double(count))
                
                // clear cache for check next level
                queue = temp
                sum = 0
                count = 0
                temp = [TreeNode]()
            }
        }
        
        return res
    }
}

/*
Solution 1:
preorder traverse tree, 
save count,sum into correct level
then for the result, map{ sum/count } would be enough

Time Complexity: O(n) n is node in the tree.
Space Complexity: O(2logn)
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
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        guard let node = root else { return [0] }
        var levels = [(count: Int, sum: Int)]()
        preorder(root, 0, &levels)
        return levels.map { Double($0.sum)/Double($0.count) }
    }
    
    func preorder(_ node: TreeNode?, _ level: Int, 
                  _ levels: inout [(count: Int, sum: Int)]) {
        guard let node = node else { return }
        if level == levels.count {
            levels.append((1, node.val))
        } else {
            levels[level].count += 1
            levels[level].sum += node.val
        }
        
        preorder(node.left, level+1, &levels)
        preorder(node.right, level+1, &levels)
    }
}