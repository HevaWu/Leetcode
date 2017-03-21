/*323. Number of Connected Components in an Undirected Graph Add to List
Description  Submission  Solutions
Total Accepted: 21480
Total Submissions: 45636
Difficulty: Medium
Contributors: Admin
Given n nodes labeled from 0 to n - 1 and a list of undirected edges (each edge is a pair of nodes), write a function to find the number of connected components in an undirected graph.

Example 1:
     0          3
     |          |
     1 --- 2    4
Given n = 5 and edges = [[0, 1], [1, 2], [3, 4]], return 2.

Example 2:
     0           4
     |           |
     1 --- 2 --- 3
Given n = 5 and edges = [[0, 1], [1, 2], [2, 3], [3, 4]], return 1.

Note:
You can assume that no duplicate edges will appear in edges. Since all edges are undirected, [0, 1] is the same as [1, 0] and thus will not appear together in edges.

Hide Company Tags Google Twitter
Hide Tags Depth-first Search Breadth-first Search Union Find Graph
Hide Similar Problems (M) Number of Islands (M) Graph Valid Tree
*/






/*
1D version of Number of Islands II
n points = n islands = n trees = n roots
with each edge addedm check which island is e[0] and e[1] belongs
if in the same islands, do nothing
if not, union two islands, reduce islands counts
path compression can reduce time by 50%
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int countComponents(int n, int[][] edges) {
        if(n <= 0 ) return 0;
        int[] graph = new int[n];
        for(int i = 0; i < n; ++i){
            graph[i] = i; //init each node is in one graph
        }

        for(int[] edge: edges){//for each edge, check which graph it belongs to
            int graph1 = checkGraph(graph, edge[0]);
            int graph2 = checkGraph(graph, edge[1]);
            if(graph1 != graph2){
                graph[graph1] = graph2; //if two nodes are not in the same graph, combine them
                n--;
            }
        }

        return n;
    }

    public int checkGraph(int[] graph, int edge){
        while(graph[edge] != edge){
            graph[edge] = graph[graph[edge]];
            edge = graph[edge];
        }
        return edge;
    }
}
