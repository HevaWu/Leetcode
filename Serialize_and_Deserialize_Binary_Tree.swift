/*
Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

Clarification: The input/output format is the same as how LeetCode serializes a binary tree. You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.

 

Example 1:


Input: root = [1,2,3,null,null,4,5]
Output: [1,2,3,null,null,4,5]
Example 2:

Input: root = []
Output: []
Example 3:

Input: root = [1]
Output: [1]
Example 4:

Input: root = [1,2]
Output: [1,2]
 

Constraints:

The number of nodes in the tree is in the range [0, 104].
-1000 <= Node.val <= 1000
*/

/*
Solution 1:
build it by using separator function

- serialize
store tree node by preorder, and save it into [String]
if node is not nil, append String(node.val) into str
if node is nil, append "#" into str
use "," to join array to String

- deserialize
split(separator: ",") -> [String.Subsequence]
everytime remove the first element and use it to build the current TreeNode
*/

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

class Codec {
    func serialize(_ root: TreeNode?) -> String {
        var str = [String]()
        _buildStr(root, &str)    
        return str.joined(separator: ",")
    }
    
    func _buildStr(_ node: TreeNode?, _ str: inout [String]) {
        guard let node = node else {
            str.append("#")
            return 
        }
        
        str.append(String(node.val))
        _buildStr(node.left, &str)
        _buildStr(node.right, &str)
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        var str = data.split(separator: ",")
        return _decodeStr(&str)
    }
    
    func _decodeStr(_ str: inout [String.SubSequence]) -> TreeNode? {
        guard !str.isEmpty else { return nil }
        let curVal = str.removeFirst()
        if let num = Int(curVal) {
            let node = TreeNode(num)
            node.left = _decodeStr(&str)
            node.right = _decodeStr(&str)
            return node
        } else {
            // first is #, which means nil node
            return nil
        }
    }
}

// Your Codec object will be instantiated and called as such:
// var ser = Codec()
// var deser = Codec()
// deser.deserialize(ser.serialize(root))