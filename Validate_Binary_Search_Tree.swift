/*
Given the root of a binary tree, determine if it is a valid binary search tree (BST).

A valid BST is defined as follows:

The left subtree of a node contains only nodes with keys less than the node's key.
The right subtree of a node contains only nodes with keys greater than the node's key.
Both the left and right subtrees must also be binary search trees.


Example 1:


Input: root = [2,1,3]
Output: true
Example 2:


Input: root = [5,1,4,null,null,3,6]
Output: false
Explanation: The root node's value is 5 but its right child's value is 4.


Constraints:

The number of nodes in the tree is in the range [1, 104].
-231 <= Node.val <= 231 - 1
*/


/*
Solution 2:
DFS iterative

Time Complexity: O(n)
- n is number of nodes in the tree
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
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        var stack = [Node]()
        stack.append(Node(root, Int.min, Int.max))

        while !stack.isEmpty {
            let cur = stack.removeLast()
            guard cur.node.val > cur.minVal,
            cur.node.val < cur.maxVal  else {
                return false
            }
            if let l = cur.node.left {
                stack.append(Node(l, cur.minVal, cur.node.val))
            }
            if let r = cur.node.right {
                stack.append(Node(r, cur.node.val, cur.maxVal))
            }
        }
        return true
    }
}

struct Node {
    let node: TreeNode
    let minVal: Int
    let maxVal: Int
    init(_ node: TreeNode, _ minVal: Int, _ maxVal: Int) {
        self.node = node
        self.minVal = minVal
        self.maxVal = maxVal
    }
}

/*
Solution 2:
BFS iterative

Time Complexity: O(n)
- n is number of nodes in the tree
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
    func isValidBST(_ root: TreeNode?) -> Bool {
        guard let root = root else { return true }
        var queue = [Node]()
        queue.append(Node(root, Int.min, Int.max))

        while !queue.isEmpty {
            let cur = queue.removeFirst()
            guard cur.node.val > cur.minVal,
            cur.node.val < cur.maxVal  else {
                return false
            }
            if let l = cur.node.left {
                queue.append(Node(l, cur.minVal, cur.node.val))
            }
            if let r = cur.node.right {
                queue.append(Node(r, cur.node.val, cur.maxVal))
            }
        }
        return true
    }
}

struct Node {
    let node: TreeNode
    let minVal: Int
    let maxVal: Int
    init(_ node: TreeNode, _ minVal: Int, _ maxVal: Int) {
        self.node = node
        self.minVal = minVal
        self.maxVal = maxVal
    }
}

/*
Solution 1: DFS

recursively check if subTree is BST by
setting minVal and maxVal
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
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValidBST(root, Int.min, Int.max)
    }

    func isValidBST(_ node: TreeNode?, _ minVal: Int, _ maxVal: Int) -> Bool {
        guard let node = node else { return true }
        if node.val >= maxVal || node.val <= minVal { return false }
        return isValidBST(node.left, minVal, node.val)
        && isValidBST(node.right, node.val, maxVal)
    }
}
