/*
Given the root of a binary tree, return all duplicate subtrees.

For each kind of duplicate subtrees, you only need to return the root node of any one of them.

Two trees are duplicate if they have the same structure with the same node values.



Example 1:


Input: root = [1,2,3,4,null,2,4,null,null,4]
Output: [[2,4],[4]]
Example 2:


Input: root = [2,1,1]
Output: [[1]]
Example 3:


Input: root = [2,2,2,3,null,3,null]
Output: [[2,3],[3]]


Constraints:

The number of the nodes in the tree will be in the range [1, 10^4]
-200 <= Node.val <= 200
*/

/*
Solution 1:
map, dfs
serialize tree by "1,2,3,#,#" unique representation

when we found there are 2 subtree there, push node into res
Time Complexity: O(n^2) -> n is node number, each creation of cur, take O(n) time
Space Complexity: O(n^2) -> size of map
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
    private Map<String, Integer> map = new HashMap<>();
    private List<TreeNode> res = new ArrayList<>();

    public List<TreeNode> findDuplicateSubtrees(TreeNode root) {
        buildMap(root);
        return res;
    }

    public String buildMap(TreeNode node) {
        if (node == null) { return "#"; }
        String cur = node.val + "," + buildMap(node.left) + "," + buildMap(node.right);
        map.put(cur, map.getOrDefault(cur, 0) + 1);
        if (map.get(cur) == 2) {
            res.add(node);
        }
        return cur;
    }
}
