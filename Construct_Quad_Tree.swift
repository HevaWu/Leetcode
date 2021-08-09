/*
Given a n * n matrix grid of 0's and 1's only. We want to represent the grid with a Quad-Tree.

Return the root of the Quad-Tree representing the grid.

Notice that you can assign the value of a node to True or False when isLeaf is False, and both are accepted in the answer.

A Quad-Tree is a tree data structure in which each internal node has exactly four children. Besides, each node has two attributes:

val: True if the node represents a grid of 1's or False if the node represents a grid of 0's.
isLeaf: True if the node is leaf node on the tree or False if the node has the four children.
class Node {
    public boolean val;
    public boolean isLeaf;
    public Node topLeft;
    public Node topRight;
    public Node bottomLeft;
    public Node bottomRight;
}
We can construct a Quad-Tree from a two-dimensional area using the following steps:

If the current grid has the same value (i.e all 1's or all 0's) set isLeaf True and set val to the value of the grid and set the four children to Null and stop.
If the current grid has different values, set isLeaf to False and set val to any value and divide the current grid into four sub-grids as shown in the photo.
Recurse for each of the children with the proper sub-grid.

If you want to know more about the Quad-Tree, you can refer to the wiki.

Quad-Tree format:

The output represents the serialized format of a Quad-Tree using level order traversal, where null signifies a path terminator where no node exists below.

It is very similar to the serialization of the binary tree. The only difference is that the node is represented as a list [isLeaf, val].

If the value of isLeaf or val is True we represent it as 1 in the list [isLeaf, val] and if the value of isLeaf or val is False we represent it as 0.



Example 1:


Input: grid = [[0,1],[1,0]]
Output: [[0,1],[1,0],[1,1],[1,1],[1,0]]
Explanation: The explanation of this example is shown below:
Notice that 0 represnts False and 1 represents True in the photo representing the Quad-Tree.

Example 2:



Input: grid = [[1,1,1,1,0,0,0,0],[1,1,1,1,0,0,0,0],[1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1],[1,1,1,1,0,0,0,0],[1,1,1,1,0,0,0,0],[1,1,1,1,0,0,0,0],[1,1,1,1,0,0,0,0]]
Output: [[0,1],[1,1],[0,1],[1,1],[1,0],null,null,null,null,[1,0],[1,0],[1,1],[1,1]]
Explanation: All values in the grid are not the same. We divide the grid into four sub-grids.
The topLeft, bottomLeft and bottomRight each has the same value.
The topRight have different values so we divide it into 4 sub-grids where each has the same value.
Explanation is shown in the photo below:

Example 3:

Input: grid = [[1,1],[1,1]]
Output: [[1,1]]
Example 4:

Input: grid = [[0]]
Output: [[1,0]]
Example 5:

Input: grid = [[1,1,0,0],[1,1,0,0],[0,0,1,1],[0,0,1,1]]
Output: [[0,1],[1,1],[1,0],[1,0],[1,1]]


Constraints:

n == grid.length == grid[i].length
n == 2^x where 0 <= x <= 6
*/

/*
Solution 1:
build tree recursively

Time Complexity: O(n^2*logn)
Space Complexity: O(n*n)
*/
/**
 * Definition for a QuadTree node.
 * public class Node {
 *     public var val: Bool
 *     public var isLeaf: Bool
 *     public var topLeft: Node?
 *     public var topRight: Node?
 *     public var bottomLeft: Node?
 *     public var bottomRight: Node?
 *     public init(_ val: Bool, _ isLeaf: Bool) {
 *         self.val = val
 *         self.isLeaf = isLeaf
 *         self.topLeft = nil
 *         self.topRight = nil
 *         self.bottomLeft = nil
 *         self.bottomRight = nil
 *     }
 * }
 */

class Solution {
    func construct(_ grid: [[Int]]) -> Node? {
        // print(grid)
        let n = grid.count
        if n == 1 {
            return Node(grid[0][0] == 1, true)
        } else {
            var temp = Array(
                repeating: Array(repeating: 0, count: n/2),
                count: n/2
            )
            for i in 0..<n/2 {
                for j in 0..<n/2 {
                    temp[i][j] = grid[i][j]
                }
            }
            let tl = construct(temp)

            for i in 0..<n/2 {
                for j in n/2..<n {
                    temp[i][j-n/2] = grid[i][j]
                }
            }
            let tr = construct(temp)

            for i in n/2..<n {
                for j in 0..<n/2 {
                    temp[i-n/2][j] = grid[i][j]
                }
            }
            let bl = construct(temp)

            for i in n/2..<n {
                for j in n/2..<n {
                    temp[i-n/2][j - n/2] = grid[i][j]
                }
            }
            let br = construct(temp)

            // print(tl?.val, tr?.val, bl?.val, br?.val, tl?.isLeaf, tr?.isLeaf)

            if let tl = tl, let tr = tr, let bl = bl, let br = br,
            tl.isLeaf, tr.isLeaf, bl.isLeaf, br.isLeaf,
            tl.val == tr.val, bl.val == br.val, tl.val == bl.val {
                return Node(tl.val, true)
            } else {
                var node = Node(false, false)
                node.topLeft = tl
                node.topRight = tr
                node.bottomLeft = bl
                node.bottomRight = br

                return node
            }
        }
    }
}