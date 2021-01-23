/*
Given a n-ary tree, find its maximum depth.

The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

Nary-Tree input serialization is represented in their level order traversal, each group of children is separated by the null value (See examples).

 

Example 1:



Input: root = [1,null,3,2,4,null,5,6]
Output: 3
Example 2:



Input: root = [1,null,2,3,4,5,null,null,6,7,null,8,null,9,10,null,null,11,null,12,null,13,null,null,14]
Output: 5
 

Constraints:

The depth of the n-ary tree is less than or equal to 1000.
The total number of nodes is between [0, 104].
*/

/*
Solution 2:
recursive
bottom up
*/
/**
 * Definition for a Node.
 * public class Node {
 *     public var val: Int
 *     public var children: [Node]
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.children = []
 *     }
 * }
 */

class Solution {
    func maxDepth(_ root: Node?) -> Int {
        guard let node = root else { return 0 }
        var res = 0 
        for c in node.children {
            res = max(res, maxDepth(c))
        }
        return res + 1
    }
}

/*
Solution 1:
recursive

top down
*/
/**
 * Definition for a Node.
 * public class Node {
 *     public var val: Int
 *     public var children: [Node]
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.children = []
 *     }
 * }
 */

class Solution {
    func maxDepth(_ root: Node?) -> Int {
        var res = 0
        _maxDepth(root, 1, &res)
        return res
    }
    
    func _maxDepth(_ node: Node?, _ depth: Int, _ res: inout Int) {
        guard let node = node else { return }
        if depth > res {
            res = depth
        }
        
        for c in node.children {
            _maxDepth(c, depth+1, &res)
        }
    }
}