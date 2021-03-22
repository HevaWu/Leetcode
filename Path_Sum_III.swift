/*
You are given a binary tree in which each node contains an integer value.

Find the number of paths that sum to a given value.

The path does not need to start or end at the root or a leaf, but it must go downwards (traveling only from parent nodes to child nodes).

The tree has no more than 1,000 nodes and the values are in the range -1,000,000 to 1,000,000.

Example:

root = [10,5,-3,3,2,null,11,3,-2,null,1], sum = 8

      10
     /  \
    5   -3
   / \    \
  3   2   11
 / \   \
3  -2   1

Return 3. The paths that sum to 8 are:

1.  5 -> 3
2.  5 -> 2 -> 1
3. -3 -> 11

*/

/*
Solution 1:
build prefixMap to help checking already checked path

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
class Solution {
    func pathSum(_ root: TreeNode?, _ sum: Int) -> Int {
        // [prefixSum, how many paths get to this prefixSum]
        var preSum = [Int: Int]()
        preSum[0] = 1
        return checkPath(root, sum, 0, &preSum)
    }
    
    func checkPath(_ node: TreeNode?, _ sum: Int, 
                   _ cur: Int, _ preSum: inout [Int: Int]) -> Int {
        guard let node = node else { return 0 }
        
        let cur = cur + node.val
        var res = preSum[cur-sum, default: 0]
        
        preSum[cur, default: 0] += 1
        res += checkPath(node.left, sum, cur, &preSum) + checkPath(node.right, sum, cur, &preSum)
        preSum[cur]! -= 1
        return res
    }
}