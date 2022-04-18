/*
Given the root of a binary search tree, and an integer k, return the kth (1-indexed) smallest element in the tree.



Example 1:


Input: root = [3,1,4,null,2], k = 1
Output: 1
Example 2:


Input: root = [5,3,6,2,4,null,null,1], k = 3
Output: 3


Constraints:

The number of nodes in the tree is n.
1 <= k <= n <= 104
0 <= Node.val <= 104


Follow up: If the BST is modified often (i.e., we can do insert and delete operations) and you need to find the kth smallest frequently, how would you optimize?
*/

/*
Follow up
use like LRU cache design
conbine index structure with double linked list

overall time complexity for insert/delete + search of kth smallest is
O(h+k)
Space Complexity: O(n) to keep the linked list
*/

/*
Solution 1
dfs

use stack to memo visited left side node
Time Complexity: O(h+k)
 - h is tree height
 - h+k us stack contains at least h+k element
Space Complexity: O(h)
 - keep stacks
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
    public int kthSmallest(TreeNode root, int k) {
        int count = countNode(root.left);

        if(k<=count){
            // System.out.println(count  + "left ");
            return kthSmallest(root.left, k);
        } else if(k > count+1){
            // System.out.println(count  + "right ");
            return kthSmallest(root.right, k-1-count);
        }

        // System.out.println(count  + "return ");
        return root.val;
    }

    public int countNode(TreeNode node){
        if(node==null) return 0;
        return 1+countNode(node.left) + countNode(node.right);
    }
}