/*
Given the roots of two binary trees p and q, write a function to check if they are the same or not.

Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.



Example 1:


Input: p = [1,2,3], q = [1,2,3]
Output: true
Example 2:


Input: p = [1,2], q = [1,null,2]
Output: false
Example 3:


Input: p = [1,2,1], q = [1,1,2]
Output: false


Constraints:

The number of nodes in both trees is in the range [0, 100].
-104 <= Node.val <= 104
*/

/*
Solution 2:
iterative

use pQueue qQueue to help memo current checking one

Time Complexity: O(n)
Space Complexity:
- O(logn) best case of completely balanced tree
- O(n) worst case of completely unbalanced tree
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
    public boolean isSameTree(TreeNode p, TreeNode q) {
        Queue<TreeNode> pQueue = new LinkedList<>();
        pQueue.offer(p);

        Queue<TreeNode> qQueue = new LinkedList<>();
        qQueue.offer(q);
        while (!pQueue.isEmpty() && !qQueue.isEmpty()) {
            TreeNode curP = pQueue.poll();
            TreeNode curQ = qQueue.poll();

            if (curP == null && curQ == null) { continue; }
            if (curP == null || curQ == null) { return false; }

            if (curP.val != curQ.val) { return false; }
            pQueue.offer(curP.left);
            pQueue.offer(curP.right);

            qQueue.offer(curQ.left);
            qQueue.offer(curQ.right);
        }
        return pQueue.isEmpty() && qQueue.isEmpty();
    }
}

/*
Solution 1:
recursive

TimeComplexity: O(n)
SpaceComplexity:
- O(logn) best case of completely balanced tree
- O(n) worst case of completely unbalanced tree
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
    public boolean isSameTree(TreeNode p, TreeNode q) {
        if(p==null || q==null) return(p==q);
        return (q.val==p.val && isSameTree(p.left, q.left) && isSameTree(p.right, q.right));
    }
}
