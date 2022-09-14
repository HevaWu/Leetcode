/*
Given a binary tree where node values are digits from 1 to 9. A path in the binary tree is said to be pseudo-palindromic if at least one permutation of the node values in the path is a palindrome.

Return the number of pseudo-palindromic paths going from the root node to leaf nodes.



Example 1:



Input: root = [2,3,1,3,1,null,1]
Output: 2
Explanation: The figure above represents the given binary tree. There are three paths going from the root node to leaf nodes: the red path [2,3,3], the green path [2,1,1], and the path [2,3,1]. Among these paths only red path and green path are pseudo-palindromic paths since the red path [2,3,3] can be rearranged in [3,2,3] (palindrome) and the green path [2,1,1] can be rearranged in [1,2,1] (palindrome).
Example 2:



Input: root = [2,1,1,1,3,null,null,null,null,null,1]
Output: 1
Explanation: The figure above represents the given binary tree. There are three paths going from the root node to leaf nodes: the green path [2,1,1], the path [2,1,3,1], and the path [2,1]. Among these paths only the green path is pseudo-palindromic since [2,1,1] can be rearranged in [1,2,1] (palindrome).
Example 3:

Input: root = [9]
Output: 1


Constraints:

The number of nodes in the tree is in the range [1, 105].
1 <= Node.val <= 9
*/

/*
Solution 1:
backtrack

the palindrome path will only allow
at most 1 odd frequency value node

backtrack check all paths node.val frequency
if current path's val frequency only have at most 1 odd
this path is palindrome path

Time Complexity: O(n)
Space Complexity: O(1)
*/
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 * int val;
 * TreeNode left;
 * TreeNode right;
 * TreeNode() {}
 * TreeNode(int val) { this.val = val; }
 * TreeNode(int val, TreeNode left, TreeNode right) {
 * this.val = val;
 * this.left = left;
 * this.right = right;
 * }
 * }
 */
class Solution {
    int path = 0;

    public int pseudoPalindromicPaths(TreeNode root) {
        if (root == null) {
            return 0;
        }

        int[] val = new int[10];
        val[root.val] += 1;

        check(root, val);
        return path;
    }

    public void check(TreeNode node, int[] val) {
        if (node.left == null && node.right == null) {
            // check val and update path
            int odd = 0;
            for (int i = 1; i <= 9; i++) {
                if (val[i] % 2 != 0) {
                    odd += 1;
                }
            }
            path += odd <= 1 ? 1 : 0;
            return;
        }

        if (node.left != null) {
            val[node.left.val] += 1;
            check(node.left, val);
            val[node.left.val] -= 1;
        }

        if (node.right != null) {
            val[node.right.val] += 1;
            check(node.right, val);
            val[node.right.val] -= 1;
        }
    }
}
