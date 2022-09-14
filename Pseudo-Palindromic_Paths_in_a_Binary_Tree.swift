/*
Given a binary tree where node values are digits from 1 to 9. A path in the binary tree is said to be pseudo-palindromic if at least one permutation of the node values in the path is a palindrome.

Return the number of pseudo-palindromic paths going from the root node to leaf nodes.



Example 1:



Input: root = [2,3,1,3,1,null,1]
Output: 2
Explanation: The figure above represents the given binary tree. There are three paths going from the root node to leaf nodes: the red path [2,3,3], the green path [2,1,1], and the path [2,3,1]. Among these paths only red path and green path are pseudo-palindromic paths since the red path [2,3,3] can be rearranged in [3,2,3] (palindrome) and the green path [2,1,1] can be rearranged in [1,2,1] (palindrome).
Example 2:



Input: root = [2,1,1,1,3,null,null,null,null,null,1]
Output: 1
Explanation: The figure above represents the given binary tree. There are three paths going from the root node to leaf nodes: the green path [2,1,1], the path [2,1,3,1], and the path [2,1]. Among these paths only the green path is pseudo-palindromic since [2,1,1] can be rearranged in [1,2,1] (palindrome).
Example 3:

Input: root = [9]
Output: 1


Constraints:

The number of nodes in the tree is in the range [1, 105].
1 <= Node.val <= 9
*/

/*
Solution 1:
backtrack

the palindrome path will only allow
at most 1 odd frequency value node

backtrack check all paths node.val frequency
if current path's val frequency only have at most 1 odd
this path is palindrome path

Time Complexity: O(n)
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
    func pseudoPalindromicPaths (_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }

        // node value will only be 1...9
        var val = Array(repeating: 0, count: 10)
        val[root.val] += 1

        var path = 0
        check(root, &val, &path)
        return path
    }

    func check(_ node: TreeNode,
               _ val: inout [Int], _ path: inout Int) {
        if node.left == nil, node.right == nil {
            // find a path
            // check current path in val,
            // and update path if its palindrome
            var oddVal = 0
            for i in 1...9 {
                if val[i] % 2 != 0 {
                    oddVal += 1
                }
            }
            path += oddVal <= 1 ? 1 : 0
            return
        }

        if let l = node.left {
            val[l.val] += 1
            check(l, &val, &path)
            val[l.val] -= 1
        }

        if let r = node.right {
            val[r.val] += 1
            check(r, &val, &path)
            val[r.val] -= 1
        }

    }
}
