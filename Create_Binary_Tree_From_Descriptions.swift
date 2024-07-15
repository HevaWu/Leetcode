/*
You are given a 2D integer array descriptions where descriptions[i] = [parenti, childi, isLefti] indicates that parenti is the parent of childi in a binary tree of unique values. Furthermore,

If isLefti == 1, then childi is the left child of parenti.
If isLefti == 0, then childi is the right child of parenti.
Construct the binary tree described by descriptions and return its root.

The test cases will be generated such that the binary tree is valid.



Example 1:


Input: descriptions = [[20,15,1],[20,17,0],[50,20,1],[50,80,0],[80,19,1]]
Output: [50,20,80,15,17,19]
Explanation: The root node is the node with value 50 since it has no parent.
The resulting binary tree is shown in the diagram.
Example 2:


Input: descriptions = [[1,2,1],[2,3,0],[3,4,1]]
Output: [1,2,null,null,3,4]
Explanation: The root node is the node with value 1 since it has no parent.
The resulting binary tree is shown in the diagram.


Constraints:

1 <= descriptions.length <= 104
descriptions[i].length == 3
1 <= parenti, childi <= 105
0 <= isLefti <= 1
The binary tree described by descriptions is valid.
*/

/*
Solution 1:
Build parentToChild and childToParent map
for all parent in parentToChild, if it cannot find parent, it should be the root node value

Then use the root node value to build the tree recursively

Time Complexity: O(m + n)
- m = descriptions.count
- n = all tree node
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
    func createBinaryTree(_ descriptions: [[Int]]) -> TreeNode? {
        // key is the parent node value
        // value is the child and isLeft
        var parentToChild = [Int: [ChildNode]]()
        var childToParent = [Int: Int]()
        for d in descriptions {
            let newChild = ChildNode(val: d[1], isLeft: d[2] == 1 ? true : false)
            parentToChild[d[0], default: [ChildNode]()].append(newChild)
            childToParent[d[1]] = d[0]
        }

        var rootVal = -1
        for parent in parentToChild.keys {
            if childToParent[parent] == nil {
                rootVal = parent
            }
        }
        return buildTree(rootVal, parentToChild)
    }

    func buildTree(_ nodeVal: Int, _ parentToChild: [Int: [ChildNode]]) -> TreeNode {
        var node = TreeNode(nodeVal)
        guard let childList = parentToChild[nodeVal] else {
            return node
        }

        for child in childList {
            if child.isLeft {
                node.left = buildTree(child.val, parentToChild)
            } else {
                node.right = buildTree(child.val, parentToChild)
            }
        }
        return node
    }
}

struct ChildNode {
    let val: Int
    let isLeft: Bool
}
