/*515. Find Largest Value in Each Tree Row Add to List
Description  Submission  Solutions
Total Accepted: 6900
Total Submissions: 13074
Difficulty: Medium
Contributors: µsic_forever
You need to find the largest value in each row of a binary tree.

Example:
Input:

          1
         / \
        3   2
       / \   \
      5   3   9

Output: [1, 3, 9]
Hide Company Tags LinkedIn
Hide Tags Tree Depth-first Search Breadth-first Search
 */






/*
Solution 1 faster than Solution 2

Solution 1: DFS, recursive 10 ms/ 78 test
according to the level of the node
for each node, update the list at its level element

Solution 2: BFS, Queue. 21 ms/ 78 test
two Queue, one for node, one for level

 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1: DFS, recursive
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
    public List<Integer> largestValues(TreeNode root) {
        List<Integer> largeVal = new ArrayList<>();
        if(root==null) return largeVal;

        searchTree(root, largeVal, 0);
        return largeVal;
    }

    public void searchTree(TreeNode root, List<Integer> largeVal, int level){
        if(root == null) return;

        if(largeVal.size() == level){
            largeVal.add(root.val);
        }
        int temp = largeVal.get(level);
        largeVal.set(level, Math.max(temp, root.val));  //use "set" function to set the level index value in list

        searchTree(root.left, largeVal, level+1);
        searchTree(root.right, largeVal, level+1);
    }
}
