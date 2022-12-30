'''
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
'''

'''
Solution 1:
backTrack

recursively checking if there is a path to reach targetNode
Because this is a acyclic graph, so we don't need to worry about cycle

Time Complexity: O(n!)
Space Complexity: O(n)
'''
class Solution:
    def allPathsSourceTarget(self, graph: List[List[int]]) -> List[List[int]]:
        paths = []
        n = len(graph)
        visited = [False for _ in range(n)]
        cur = [0]
        visited[0] = True

        def check(index: int):
            nonlocal n, paths, visited, cur, graph
            if index == n-1:
                paths.append(cur.copy())
                return
            for next in graph[index]:
                if visited[next] == False:
                    visited[next] = True
                    cur.append(next)
                    check(next)
                    cur.pop(-1)
                    visited[next] = False

        check(0)
        return paths
