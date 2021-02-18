/*
Given the root of a binary search tree, and an integer k, return the kth (1-indexed) smallest element in the tree.

 

Example 1:


Input: root = [3,1,4,null,2], k = 1
Output: 1
Example 2:


Input: root = [5,3,6,2,4,null,null,1], k = 3
Output: 3
 

Constraints:

The number of nodes in the tree is n.
1 <= k <= n <= 104
0 <= Node.val <= 104
 

Follow up: If the BST is modified often (i.e., we can do insert and delete operations) and you need to find the kth smallest frequently, how would you optimize?
*/

/*
Follow up
use like LRU cache design
conbine index structure with double linked list

overall time complexity for insert/delete + search of kth smallest is 
O(h+k)
Space Complexity: O(n) to keep the linked list
*/

/*
Solution 1
dfs

use stack to memo visited left side node
Time Complexity: O(h+k)
 - h is tree height
 - h+k us stack contains at least h+k element
Space Complexity: O(h)
 - keep stacks
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
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var root = root
        var k = k
        var stack = [TreeNode?]()
        
        while true {
            while root != nil {
                stack.append(root)
                root = root?.left
            }
            
            root = stack.removeLast()
            k -= 1
            if k == 0 { return root?.val ?? -1 }
            root = root?.right
        }
        return -1
    }
}
