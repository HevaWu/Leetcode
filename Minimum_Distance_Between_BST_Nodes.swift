/*
Given the root of a Binary Search Tree (BST), return the minimum difference between the values of any two different nodes in the tree.



Example 1:


Input: root = [4,2,6,1,3]
Output: 1
Example 2:


Input: root = [1,0,48,null,null,12,49]
Output: 1


Constraints:

The number of nodes in the tree is in the range [2, 100].
0 <= Node.val <= 105
*/

/*
Solution 2:
recursively check each node,
compare its left most value and right most value

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
    func minDiffInBST(_ root: TreeNode?) -> Int {
        var minDis = 100001
        checkDiff(root, nil, nil, &minDis)
        return minDis
    }

    func checkDiff(_ node: TreeNode?, _ lMost: Int?, _ rMost: Int?,
    _ minDis: inout Int) {
        guard let node = node else { return }
        if let lMost = lMost {
            minDis = min(minDis, node.val-lMost)
        }
        if let rMost = rMost {
            minDis = min(minDis, rMost - node.val)
        }
        checkDiff(node.left, lMost, node.val, &minDis)
        checkDiff(node.right, node.val, rMost, &minDis)
    }
}

/*
Solution 1:
build tree array, sort it, check minDis between two elements

Time Complexity: O(nlogn)
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
    func minDiffInBST(_ root: TreeNode?) -> Int {
        var arr = [Int]()
        var queue = [root]
        while !queue.isEmpty {
            if let cur = queue.removeFirst() {
                arr.append(cur.val)
                queue.append(cur.left)
                queue.append(cur.right)
            }
        }

        arr.sort()
        let n = arr.count
        var minDis = arr[1] - arr[0]
        for i in 2..<n {
            minDis = min(minDis, arr[i] - arr[i-1])
            if minDis == 0 { return 0 }
        }
        return minDis
    }
}
