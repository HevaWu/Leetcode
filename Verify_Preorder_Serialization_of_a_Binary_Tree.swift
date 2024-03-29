/*
One way to serialize a binary tree is to use preorder traversal. When we encounter a non-null node, we record the node's value. If it is a null node, we record using a sentinel value such as '#'.


For example, the above binary tree can be serialized to the string "9,3,4,#,#,1,#,#,2,#,6,#,#", where '#' represents a null node.

Given a string of comma-separated values preorder, return true if it is a correct preorder traversal serialization of a binary tree.

It is guaranteed that each comma-separated value in the string must be either an integer or a character '#' representing null pointer.

You may assume that the input format is always valid.

For example, it could never contain two consecutive commas, such as "1,,3".
Note: You are not allowed to reconstruct the tree.



Example 1:

Input: preorder = "9,3,4,#,#,1,#,#,2,#,6,#,#"
Output: true
Example 2:

Input: preorder = "1,#"
Output: false
Example 3:

Input: preorder = "9,#,#,1"
Output: false


Constraints:

1 <= preorder.length <= 104
preorder consist of integers in the range [0, 100] and '#' separated by commas ','.
*/

/*
Solution 1:
stack

convert string to splited array
use stack to record if current node's left is matched or not
true means current tree level node's left is well-formed
false means current tree level node's left is waiting for update

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func isValidSerialization(_ preorder: String) -> Bool {
        var preorder = preorder.split(separator: ",")

        let n = preorder.count
        if n == 1 { return preorder.first! == "#" }

        // if have multiple nodes, but start will nil, return false
        if preorder[0] == "#" { return false }

        // already match left node or not
        var stack: [Bool] = [false]
        for i in 1..<n {
            let node = preorder[i]

            // we need to make sure there is some valid node in the tree
            guard !stack.isEmpty else { return false }

            if node == "#" {
                while !stack.isEmpty, stack.last == true {
                    stack.removeLast()
                }

                if let last = stack.last {
                    // change last object from false to true
                    // which means last node find proper left node
                    stack.removeLast()
                    stack.append(true)
                }
            } else {
                stack.append(false)
            }

            // print(stack, node)
        }

        return stack.isEmpty
    }
}