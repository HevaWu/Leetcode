/*
Given a complete binary tree, count the number of nodes.

Note:

Definition of a complete binary tree from Wikipedia:
In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.

Example:

Input:
    1
   / \
  2   3
 / \  /
4  5 6

Output: 6
*/

/*
Solution 3:
from root.left, recursively check if its right children is nil, and add the count
Time Complexity: O(logn)
Space ComplexityL O(logn)
*/
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode(int x) { val = x; }
 * }
 */
public
class Solution {
 public
  int countNodes(TreeNode root) {
    if (root == null) return 0;
    int count = 1;
    TreeNode curL = root.left;
    TreeNode curR = root.left;
    while (curR != null) {
      curL = curL.left;
      curR = curR.right;
      count = count << 1;
    }
    return count +
           ((curL == null) ? countNodes(root.right) : countNodes(root.left));
  }
}
