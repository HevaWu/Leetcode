// Return any binary tree that matches the given preorder and postorder traversals.

// Values in the traversals pre and post are distinct positive integers.

 

// Example 1:

// Input: pre = [1,2,4,5,3,6,7], post = [4,5,2,6,7,3,1]
// Output: [1,2,3,4,5,6,7]
 

// Note:

// 1 <= pre.length == post.length <= 30
// pre[] and post[] are both permutations of 1, 2, ..., pre.length.
// It is guaranteed an answer exists. If there exists multiple answers, you can return any of them.

// Solution 1: recursive 
// 
// Time Complexity: O(N^2), where NN is the number of nodes.
// Space Complexity: O(N^2).
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    func constructFromPrePost(_ pre: [Int], _ post: [Int]) -> TreeNode? {
        guard !pre.isEmpty else { return nil }
        
        var root = TreeNode(pre[0])
        if pre.count == 1 { return root }
        
        var left = 0
        for i in 0..<pre.count{
            if post[i] == pre[1] {
                left = i+1
            }
        }
        
        root.left = constructFromPrePost(Array(pre[1..<(left+1)]), Array(post[0..<(left)]))
        root.right = constructFromPrePost(Array(pre[(left+1)..<pre.count]), Array(post[left..<pre.count-1]))
        
        return root
    }
}


/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */
class Solution {
    var pre = [Int]()
    var post = [Int]()
    func constructFromPrePost(_ pre: [Int], _ post: [Int]) -> TreeNode? {
        self.pre = pre
        self.post = post
        return check(0, 0, pre.count)
    }
    
    func check(_ preIndex: Int, _ postIndex: Int, _ len: Int) -> TreeNode? {
        if len == 0 { return nil }
        var root = TreeNode(pre[preIndex])
        if len == 1 { return root }
        
        var left = 1
        while left < len {
            if post[postIndex + left - 1] == pre[preIndex + 1] {
                break
            }
            left += 1
        }
        
        root.left = check(preIndex+1, postIndex, left)
        root.right = check(preIndex+left+1, postIndex+left, len-1-left)
        return root
    }
}