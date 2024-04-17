/*
You are given the root of a binary tree where each node has a value in the range [0, 25] representing the letters 'a' to 'z'.

Return the lexicographically smallest string that starts at a leaf of this tree and ends at the root.

As a reminder, any shorter prefix of a string is lexicographically smaller.

For example, "ab" is lexicographically smaller than "aba".
A leaf of a node is a node that has no children.



Example 1:


Input: root = [0,1,2,3,4,3,4]
Output: "dba"
Example 2:


Input: root = [25,1,3,1,3,0,2]
Output: "adz"
Example 3:


Input: root = [2,2,1,null,1,0,null,0]
Output: "abc"


Constraints:

The number of nodes in the tree is in the range [1, 8500].
0 <= Node.val <= 25
*/

/*
Solution 1:
Traverse tree
Check all possible leaf to root numbers, then convert the smallest one to string

Time Complexity: O(n)
- n is node of the tree
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
    func smallestFromLeaf(_ root: TreeNode?) -> String {
        var smallest = [Int]()
        check(root, [Int](), &smallest)
        return convertToString(smallest)
    }

    func check(_ node: TreeNode?, _ cur: [Int], _ smallest: inout [Int]) {
        guard let node = node else { return }
        var cur = cur
        cur.insert(node.val, at: 0)
        if node.left == nil, node.right == nil {
            updateSmallestIfNeeded(cur, &smallest)
        }
        check(node.left, cur, &smallest)
        check(node.right, cur, &smallest)
    }

    func updateSmallestIfNeeded(_ cur: [Int], _ smallest: inout [Int]) {
        if smallest.isEmpty {
            smallest = cur
            return
        }
        let cn = cur.count
        let sn = smallest.count

        var ci = 0
        var si = 0
        while ci < cn, si < sn {
            if cur[ci] > smallest[si] {
                // keep smallest
                return
            }
            if cur[ci] < smallest[si] {
                // replace with cur
                smallest = cur
                return
            }
            ci += 1
            si += 1
        }
        if ci == cn, si < sn {
            smallest = cur
        }
    }

    func convertToString(_ smallest: [Int]) -> String {
        // print(smallest)
        let a = Int(Character("a").asciiValue!)
        return String(smallest.map {
            Character(UnicodeScalar(a+$0)!)
        })
    }
}
