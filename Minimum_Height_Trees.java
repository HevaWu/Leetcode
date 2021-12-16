/*
A tree is an undirected graph in which any two vertices are connected by exactly one path. In other words, any connected graph without simple cycles is a tree.

Given a tree of n nodes labelled from 0 to n - 1, and an array of n - 1 edges where edges[i] = [ai, bi] indicates that there is an undirected edge between the two nodes ai and bi in the tree, you can choose any node of the tree as the root. When you select a node x as the root, the result tree has height h. Among all possible rooted trees, those with minimum height (i.e. min(h))  are called minimum height trees (MHTs).

Return a list of all MHTs' root labels. You can return the answer in any order.

The height of a rooted tree is the number of edges on the longest downward path between the root and a leaf.



Example 1:


Input: n = 4, edges = [[1,0],[1,2],[1,3]]
Output: [1]
Explanation: As shown, the height of the tree is 1 when the root is the node with label 1 which is the only MHT.
Example 2:


Input: n = 6, edges = [[3,0],[3,1],[3,2],[3,4],[5,4]]
Output: [3,4]
Example 3:

Input: n = 1, edges = []
Output: [0]
Example 4:

Input: n = 2, edges = [[0,1]]
Output: [0,1]


Constraints:

1 <= n <= 2 * 104
edges.length == n - 1
0 <= ai, bi < n
ai != bi
All the pairs (ai, bi) are distinct.
The given input is guaranteed to be a tree and there will be no repeated edges.
*/

/*
Solution 1:
Topological sort

The distance between two nodes is the number of edges that connect the two nodes.
The height of a tree can be defined as the maximum distance between the root and all its leaf nodes.

If we view the graph as an area of circle, and the leaf nodes as the peripheral of the circle, then what we are looking for are actually the centroids of the circle, i.e. nodes that is close to all the peripheral nodes (leaf nodes).
For the tree-alike graph, the number of centroids is no more than 2.

Once we trim out the first layer of the leaf nodes (nodes that have only one connection), some of the non-leaf nodes would become leaf nodes.
The trimming process continues until there are only two nodes left in the graph, which are the centroids that we are looking for.

Breadth First Search (BFS) strategy, to trim the leaf nodes layer by layer (i.e. level by level).

- Initially, we would build a graph with the adjacency list from the input.
- We then create a queue which would be used to hold the leaf nodes.
- At the beginning, we put all the current leaf nodes into the queue.
- We then run a loop until there is only two nodes left in the graph.
- At each iteration, we remove the current leaf nodes from the queue. While removing the nodes, we also remove the edges that are linked to the nodes. As a consequence, some of the non-leaf nodes would become leaf nodes. And these are the nodes that would be trimmed out in the next iteration.
- The iteration terminates when there are no more than two nodes left in the graph, which are the desired centroids nodes

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public List<Integer> findMinHeightTrees(int n, int[][] edges) {
        if (n < 2) {
            List<Integer> res = new ArrayList<>();
            for (int i = 0; i < n; i++) {
                res.add(i);
            }
            return res;
        }

        List<Set<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new HashSet<Integer>());
        }

        for (int[] edge: edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int remain = n;
        List<Integer> queue = new ArrayList<>();
        // first leaf nodes layer
        for (int i = 0; i < n; i++) {
            if (adj.get(i).size() == 1) {
                queue.add(i);
            }
        }

        while (remain > 2) {
            int size = queue.size();
            remain -= size;
            List<Integer> newQueue = new ArrayList<>();

            for (Integer node : queue) {
                int neighbor = adj.get(node).iterator().next();
                adj.get(neighbor).remove(node);
                if (adj.get(neighbor).size() == 1) {
                    newQueue.add(neighbor);
                }
            }
            queue = newQueue;
        }
        return queue;
    }
}