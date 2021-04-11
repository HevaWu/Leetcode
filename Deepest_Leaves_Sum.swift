/*
Given the root of a binary tree, return the sum of values of its deepest leaves.


Example 1:


Input: root = [1,2,3,4,5,null,6,7,null,null,null,null,8]
Output: 15
Example 2:

Input: root = [6,7,8,2,7,1,3,9,null,1,4,null,null,null,5]
Output: 19


Constraints:

The number of nodes in the tree is in the range [1, 104].
1 <= Node.val <= 100
*/

/*
Solution 2:
BFS

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
class Solution2 {
    func deepestLeavesSum(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        var queue = [(node: TreeNode, depth: Int)]()
        queue.append((root, 0))

        var maxDepth = 0
        var deepestSum = 0

        while !queue.isEmpty {
            let (node, depth) = queue.removeFirst()
            if depth == maxDepth {
                deepestSum += node.val
            } else if depth > maxDepth {
                maxDepth = depth
                deepestSum = node.val
            }

            if let left = node.left {
                queue.append((left, depth+1))
            }
            if let right = node.right {
                queue.append((right, depth+1))
            }
        }
        return deepestSum
    }
}

/*
Solution 1:
traverse tree and record each depth level sum
return depthSum.last for deepest one

Time Complexity: O(n)
- n is total node in the tree
Space Complexity: O(log n)
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
class Solution1 {
    func deepestLeavesSum(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var depthSum = [Int]()
        traverse(root, 0, &depthSum)
        return depthSum.last!
    }

    func traverse(_ node: TreeNode, _ depth: Int, _ depthSum: inout [Int]) {
        if depth == depthSum.count {
            depthSum.append(node.val)
        } else {
            depthSum[depth] += node.val
        }

        if let left = node.left {
            traverse(left, depth+1, &depthSum)
        }
        if let right = node.right {
            traverse(right, depth+1, &depthSum)
        }
    }
}