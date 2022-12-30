/*
Given a directed acyclic graph (DAG) of n nodes labeled from 0 to n - 1, find all possible paths from node 0 to node n - 1, and return them in any order.

The graph is given as follows: graph[i] is a list of all nodes you can visit from node i (i.e., there is a directed edge from node i to node graph[i][j]).



Example 1:


Input: graph = [[1,2],[3],[3],[]]
Output: [[0,1,3],[0,2,3]]
Explanation: There are two paths: 0 -> 1 -> 3 and 0 -> 2 -> 3.
Example 2:


Input: graph = [[4,3,1],[3,2,4],[3],[4],[]]
Output: [[0,4],[0,3,4],[0,1,3,4],[0,1,2,3,4],[0,1,4]]
Example 3:

Input: graph = [[1],[]]
Output: [[0,1]]
Example 4:

Input: graph = [[1,2,3],[2],[3],[]]
Output: [[0,1,2,3],[0,2,3],[0,3]]
Example 5:

Input: graph = [[1,3],[2],[3],[]]
Output: [[0,1,2,3],[0,3]]


Constraints:

n == graph.length
2 <= n <= 15
0 <= graph[i][j] < n
graph[i][j] != i (i.e., there will be no self-loops).
The input graph is guaranteed to be a DAG.
*/

/*
Solution 1:
backTrack

recursively checking if there is a path to reach targetNode
Because this is a acyclic graph, so we don't need to worry about cycle

Time Complexity: O(n!)
Space Complexity: O(n)
*/
class Solution {
    public List<List<Integer>> allPathsSourceTarget(int[][] graph) {
        List<List<Integer>> paths = new ArrayList<>();
        int n = graph.length;
        boolean[] visited = new boolean[n];
        List<Integer> cur = new ArrayList<>();
        cur.add(0);
        check(0, n, graph, cur, visited, paths);
        return paths;
    }

    // update paths, to find paths from index to n-1
    void check(int index, int n, int[][] graph,
    List<Integer> cur, boolean[] visited,
    List<List<Integer>> paths) {
        if (index == n-1) {
            paths.add(new ArrayList<>(cur));
            return;
        }
        for (int next : graph[index]) {
            if (!visited[next]) {
                visited[next] = true;
                cur.add(next);
                check(next, n, graph, cur, visited, paths);
                cur.remove(cur.size()-1);
                visited[next] = false;
            }
        }
    }
}
