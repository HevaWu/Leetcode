/*
Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

Example:

Input: [1,2,3,null,5,null,4]
Output: [1, 3, 4]
Explanation:

   1            <---
 /   \
2     3         <---
 \     \
  5     4       <---
*/

/*
Solution 1:
iterative

always push right children in to queue first
then left one
each time, check if cur.level == res.count, if so,
find a right side node, append it to res

Time Complexity: O(n), n is whole node count
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
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let node = root else { return [] }
        var res: [Int] = [node.val]
        
        var queue: [(TreeNode, Int)] = [(node, 1)]
        while !queue.isEmpty {
            let (cur, level) = queue.removeFirst()
            if level == res.count { 
                if cur.right != nil { queue.append((cur.right!, level+1)) }
                if cur.left != nil { queue.append((cur.left!, level+1)) }
                continue 
            }
            
            // find a right side node
            res.append(cur.val)
            
            if cur.right != nil { queue.append((cur.right!, level+1)) }
            if cur.left != nil { queue.append((cur.left!, level+1)) }
        }
        
        return res
    }
}

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
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let node = root else { return [] }
        var res: [Int] = [Int]()
        
        var queue: [(TreeNode, Int)] = [(node, 0)]
        while !queue.isEmpty {
            let (cur, level) = queue.removeFirst()
            if level == res.count { 
                // find a right side node
                res.append(cur.val)
            }
            
            if cur.right != nil { queue.append((cur.right!, level+1)) }
            if cur.left != nil { queue.append((cur.left!, level+1)) }
        }
        
        return res
    }
}