/*199. Binary Tree Right Side View Add to List
Description  Submission  Solutions
Total Accepted: 71283
Total Submissions: 181103
Difficulty: Medium
Contributors: Admin
Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

For example:
Given the following binary tree,
   1            <---
 /   \
2     3         <---
 \     \
  5     4       <---
You should return [1, 3, 4].

Credits:
Special thanks to @amrsaqr for adding this problem and creating all test cases.

Hide Company Tags Amazon
Hide Tags Tree Depth-first Search Breadth-first Search
Hide Similar Problems (M) Populating Next Right Pointers in Each Node
*/

/*
Solution 1 faster than Solution 3 faster than Solution 2

Solution 1: DFS
from set a level variable to control the layer of the tree we have already seen
after the right node, we see if there is a left node, if is, we pushback this node.val

Solution 2: BFS Queue
use for loop in the while Q.isEmpty() loop
each time offer(left and right),
only push the size-1 node in the Q into return list

Solution 3: Divide and Conquer
Use two list, "lnode" and "rnode" to control the root left child and right child
recursively find the lnode an rnode
each time find current node's right view, then check back to the root
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1 recursive
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
    public List<Integer> rightSideView(TreeNode root) {
        List<Integer> rightlist = new ArrayList<>();
        if(root == null) return rightlist;
        rightTree(root, rightlist, 0);
        return rightlist;
    }

    public void rightTree(TreeNode root, List<Integer> rightlist, int level){
        if(root == null) return;
        if(rightlist.size() == level){ //check if we need to add the node at current list
            rightlist.add(root.val);
        }
        rightTree(root.right, rightlist, level+1);
        rightTree(root.left, rightlist, level+1);
    }
}





//Solution 2 Queue
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
    public List<Integer> rightSideView(TreeNode root) {
        List<Integer> rightlist = new ArrayList<>();
        if(root==null) return rightlist;

        Queue<TreeNode> Q = new LinkedList<>();
        Q.offer(root);
        while(!Q.isEmpty()){
            int size = Q.size();
            for(int i = 0; i < size; ++i){
                TreeNode cur = Q.poll();
                if(size-1 == i){  //check if i==size-1, if it is, add it to the return list
                    rightlist.add(cur.val);
                }
                if(cur.left != null) Q.offer(cur.left);
                if(cur.right != null) Q.offer(cur.right);
            }
        }
        return rightlist;
    }
}




//Solution 3  Divide and Conquer
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
    public List<Integer> rightSideView(TreeNode root) {
        List<Integer> rightlist = new ArrayList<>();
        if(root == null) return rightlist;

        List<Integer> lnode = rightSideView(root.left);
        List<Integer> rnode = rightSideView(root.right);
        int lsize = lnode.size();
        int rsize = rnode.size();

        rightlist.add(root.val);
        int len = Math.max(lsize, rsize);
        for(int i = 0; i < len; ++i){
            if(i >= rsize){
                rightlist.add(lnode.get(i));
            } else {
                //each time, if there is a right node we could find, we add the right node
                rightlist.add(rnode.get(i));
            }
        }
        return rightlist;
    }
}
