/*
Given a non-empty binary tree, return the average value of the nodes on each level in the form of an array.
Example 1:
Input:
    3
   / \
  9  20
    /  \
   15   7
Output: [3, 14.5, 11]
Explanation:
The average value of nodes on level 0 is 3,  on level 1 is 14.5, and on level 2 is 11. Hence return [3, 14.5, 11].
Note:
The range of node's value is in the range of 32-bit signed integer.
*/

/*
Solution 2:
bfs traverse

use queue to memo current level
use temp to memo next level node

1. Put the root node into the queuequeue.
2. Initialize sumsum and countcount as 0 and temptemp as an empty queue.
3. Pop a node from the front of the queuequeue. Add this node's value to the sumsum corresponding to the current level. Also, update the countcount corresponding to the current level.
4. Put the children nodes of the node last popped into the a temptemp queue(instead of queuequeue).
5. Continue steps 3 and 4 till queuequeue becomes empty. (An empty queuequeue indicates that one level of the tree has been considered).
6. Reinitialize queuequeue with its value as temptemp.
7. Populate the resres array with the average corresponding to the current level.
8. Repeat steps 2 to 7 till the queuequeue and temptemp become empty.

Time Complexity: O(n)
Space Complexity: O(m) size of queue or temp can grow up to
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
    public List<Double> averageOfLevels(TreeNode root) {
        List<Double> average = new ArrayList<>();
        if (root == null) {
            return average;
        }

        List<List<Integer>> level = new ArrayList<>();

        // bfs
        Queue<Node> queue = new LinkedList<>();
        queue.offer(new Node(root, 0));

        while (queue.size() > 0) {
            Node cur = queue.poll();
            if (cur.depth == level.size()) {
                level.add(new ArrayList<>());
            }
            level.get(cur.depth).add(cur.node.val);

            if (cur.node.left != null) {
                queue.offer(new Node(cur.node.left, cur.depth + 1));
            }
            if (cur.node.right != null) {
                queue.offer(new Node(cur.node.right, cur.depth + 1));
            }
        }

        // calculate average
        for (List<Integer> l : level) {
            double size = l.size();
            double sum = 0;
            for (int i = 0; i < size; i++) {
                sum += l.get(i);
            }
            average.add(Math.round(sum / size * 100000) / (double) 100000);
        }
        return average;
    }
}

class Node {
    int depth;
    TreeNode node;

    Node(TreeNode node, int depth) {
        this.node = node;
        this.depth = depth;
    }
}
