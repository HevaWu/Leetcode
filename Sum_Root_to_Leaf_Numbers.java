/*129. Sum Root to Leaf Numbers  QuestionEditorial Solution  My Submissions
Total Accepted: 85895
Total Submissions: 253504
Difficulty: Medium
Given a binary tree containing digits from 0-9 only, each root-to-leaf path could represent a number.

An example is the root-to-leaf path 1->2->3 which represents the number 123.

Find the total sum of all root-to-leaf numbers.

For example,

    1
   / \
  2   3
The root-to-leaf path 1->2 represents the number 12.
The root-to-leaf path 1->3 represents the number 13.

Return the sum = 12 + 13 = 25.

Subscribe to see which companies asked this question*/

/*
Solution 2:
iterative stack DFS

Time Complexity: O(n)
Space Complexity: O(logn)
*/
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     int val;
 *     TreeNode left;
 *     TreeNode right;
 *     TreeNode() {}
 *     TreeNode(int val) { this.val = val; }
 *     TreeNode(int val, TreeNode left, TreeNode right) {
 *         this.val = val;
 *         this.left = left;
 *         this.right = right;
 *     }
 * }
 */
class Solution {
    public int sumNumbers(TreeNode root) {
        int sum = 0;

        Stack<TNode> stack = new Stack<>();
        stack.push(new TNode(root, root.val));

        while (!stack.isEmpty()) {
            TNode cur = stack.pop();
            if (cur.node.left == null && cur.node.right == null) {
                sum += cur.val;
            } else {
                if (cur.node.left != null) {
                    stack.push(new TNode(cur.node.left, cur.val * 10 + cur.node.left.val));
                }
                if (cur.node.right != null) {
                    stack.push(new TNode(cur.node.right, cur.val * 10 + cur.node.right.val));
                }
            }
        }

        return sum;
    }
}

// TreeNode with current path value
class TNode {
    TreeNode node;
    int val;
    TNode(TreeNode node, int val) {
        this.val = val;
        this.node = node;
    }
}

/*
Solution 1:
Once find one leaf node, current num value *10+ node.value
if this node is not a leaf node, recursively do sumTree(root, num*10+root.val) until find the leaf node
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
public class Solution {
    public int sumNumbers(TreeNode root) {
        return sumTree(root, 0);
    }

    public int sumTree(TreeNode root, int num){
        if(root == null) return 0;
        if(root.right == null && root.left == null){
            return num*10+root.val;
        }
        return sumTree(root.left, num*10+root.val) + sumTree(root.right, num*10+root.val);
    }
}