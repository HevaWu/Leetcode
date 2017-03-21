/*366. Find Leaves of Binary Tree   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 11122
Total Submissions: 19494
Difficulty: Medium
Contributors: Admin
Given a binary tree, collect a tree's nodes as if you were doing this: Collect and remove all leaves, repeat until the tree is empty.

Example:
Given binary tree
          1
         / \
        2   3
       / \
      4   5
Returns [4, 5, 3], [2], [1].

Explanation:
1. Removing the leaves [4, 5, 3] would result in this tree:

          1
         /
        2
2. Now removing the leaf [2] would result in this tree:

          1
3. Now removing the leaf [1] would result in the empty tree:

          []
Returns [4, 5, 3], [2], [1].

Credits:
Special thanks to @elmirap for adding this problem and creating all test cases.

Hide Company Tags LinkedIn
Hide Tags Tree Depth-first Search
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*bottom up
1. find the height of each node
	the height of a node is the number of edges from the node to the deapest leaf
2. the height of a node is its index in the result list(ret)
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
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
    public List<List<Integer>> findLeaves(TreeNode root) {
        List<List<Integer> > ret = new ArrayList<>();
        height(ret, root);
        return ret;
    }

    //find the height of each node
    public int height(List<List<Integer> > ret, TreeNode root){
        if(root == null){// the leaf node
            return -1;
        }
        int level = 1 + Math.max(height(ret, root.left), height(ret, root.right)); //find the current node height
        if(ret.size() < level+1){ // level is start from 0
            ret.add(new ArrayList<>());
        }
        ret.get(level).add(root.val);
        return level;
    }
}

