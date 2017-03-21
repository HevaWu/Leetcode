/*314. Binary Tree Vertical Order Traversal
Description  Submission  Solutions  Add to List
Total Accepted: 20325
Total Submissions: 56745
Difficulty: Medium
Contributors: Admin
Given a binary tree, return the vertical order traversal of its nodes' values. (ie, from top to bottom, column by column).

If two nodes are in the same row and column, the order should be from left to right.

Examples:

Given binary tree [3,9,20,null,null,15,7],
   3
  /\
 /  \
 9  20
    /\
   /  \
  15   7
return its vertical order traversal as:
[
  [9],
  [3,15],
  [20],
  [7]
]
Given binary tree [3,9,8,4,0,1,7],
     3
    /\
   /  \
   9   8
  /\  /\
 /  \/  \
 4  01   7
return its vertical order traversal as:
[
  [4],
  [9],
  [3,0,1],
  [8],
  [7]
]
Given binary tree [3,9,8,4,0,1,7,null,null,null,2,5] (0's right child is 2 and 1's left child is 5),
     3
    /\
   /  \
   9   8
  /\  /\
 /  \/  \
 4  01   7
    /\
   /  \
   5   2
return its vertical order traversal as:
[
  [4],
  [9,5],
  [3,0,1],
  [8,2],
  [7]
]
Hide Company Tags Google Snapchat Facebook
Hide Tags Hash Table
Hide Similar Problems (M) Binary Tree Level Order Traversal
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
Solution 2 is faster than Solution 1

Solution 1:
if the root node is at col
then the left node is at col-1, the right node is at col+1
use Queue to push the node and count the col of each node
for each col, use a HashMap to store the node at this col
use min & max to calculate the range of this tree
at the end, according to the min & max, push each col into the return list

Solution 2:
at the first, we count the range of this tree
then, for each node, add it to the correspond col list
use Queue<TreeNode> to push the node and
Queue<Integer> count the cols of each node

attention:   have to use Queue to implement the traversal, if recursive, the order is wrong
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
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
    public List<List<Integer>> verticalOrder(TreeNode root) {
        if(root==null) return new ArrayList<>();

        Queue<TreeNode> tree = new LinkedList<>(); //record the tree node
        tree.add(root);
        Queue<Integer> cols = new LinkedList<>(); //record the correspond cols
        cols.add(0);
        Map<Integer, List<Integer>> mymap = new HashMap<>(); //store the node and its col, key is col, value is the list of treenode value

        int min = 0;
        int max = 0;

        while(!tree.isEmpty()){
            TreeNode cur = tree.poll();
            int col = cols.poll();
            if(!mymap.containsKey(col)){
                mymap.put(col, new ArrayList<>());
            }
            mymap.get(col).add(cur.val); //add current tree node into the map

            if(cur.left != null){
                tree.add(cur.left);
                cols.add(col-1);
                min = Math.min(min, col-1);
            }
            if(cur.right != null){
                tree.add(cur.right);
                cols.add(col+1);
                max = Math.max(max, col+1);
            }
        }

        List<List<Integer>> ret = new ArrayList<>(); //the return list
        for(int i = max; i >= min; --i){
            ret.add(0, mymap.get(i));
        }
        return ret;
    }
}



//Solution 2
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
    private int min = 0;
    private int max = 0;

    public List<List<Integer>> verticalOrder(TreeNode root) {
        if(root == null) return new ArrayList<>();
        countRange(root, 0); //count the range of the tree
        List<List<Integer>> ret = new ArrayList<>();

        //according to the range, init the return list
        for(int i = min; i <= max; ++i){
            ret.add(new ArrayList<>());
        }

        Queue<TreeNode> tree = new LinkedList<>();
        Queue<Integer> cols = new LinkedList<>();
        tree.add(root);
        cols.add(0-min);

        while(!tree.isEmpty()){
            TreeNode cur = tree.poll();
            int col = cols.poll();

            ret.get(col).add(cur.val);

            if(cur.left != null){
                tree.add(cur.left);
                cols.add(col-1);
            }
            if(cur.right != null){
                tree.add(cur.right);
                cols.add(col+1);
            }
        }

        return ret;
    }

    public void countRange(TreeNode root, int col){
        if(root==null) return;
        if(col<min) min = col;
        if(col>max) max = col;
        countRange(root.left, col-1);
        countRange(root.right, col+1);
    }
}
