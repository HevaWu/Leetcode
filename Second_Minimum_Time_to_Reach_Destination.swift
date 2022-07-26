/*
A city is represented as a bi-directional connected graph with n vertices where each vertex is labeled from 1 to n (inclusive). The edges in the graph are represented as a 2D integer array edges, where each edges[i] = [ui, vi] denotes a bi-directional edge between vertex ui and vertex vi. Every vertex pair is connected by at most one edge, and no vertex has an edge to itself. The time taken to traverse any edge is time minutes.

Each vertex has a traffic signal which changes its color from green to red and vice versa every change minutes. All signals change at the same time. You can enter a vertex at any time, but can leave a vertex only when the signal is green. You cannot wait at a vertex if the signal is green.

The second minimum value is defined as the smallest value strictly larger than the minimum value.

For example the second minimum value of [2, 3, 4] is 3, and the second minimum value of [2, 2, 4] is 4.
Given n, edges, time, and change, return the second minimum time it will take to go from vertex 1 to vertex n.

Notes:

You can go through any vertex any number of times, including 1 and n.
You can assume that when the journey starts, all signals have just turned green.


Example 1:

        
Input: n = 5, edges = [[1,2],[1,3],[1,4],[3,4],[4,5]], time = 3, change = 5
Output: 13
Explanation:
The figure on the left shows the given graph.
The blue path in the figure on the right is the minimum time path.
The time taken is:
- Start at 1, time elapsed=0
- 1 -> 4: 3 minutes, time elapsed=3
- 4 -> 5: 3 minutes, time elapsed=6
Hence the minimum time needed is 6 minutes.

The red path shows the path to get the second minimum time.
- Start at 1, time elapsed=0
- 1 -> 3: 3 minutes, time elapsed=3
- 3 -> 4: 3 minutes, time elapsed=6
- Wait at 4 for 4 minutes, time elapsed=10
- 4 -> 5: 3 minutes, time elapsed=13
Hence the second minimum time is 13 minutes.
Example 2:


Input: n = 2, edges = [[1,2]], time = 3, change = 2
Output: 11
Explanation:
The minimum time path is 1 -> 2 with time = 3 minutes.
The second minimum time path is 1 -> 2 -> 1 -> 2 with time = 11 minutes.


Constraints:

2 <= n <= 104
n - 1 <= edges.length <= min(2 * 104, n * (n - 1) / 2)
edges[i].length == 2
1 <= ui, vi <= n
ui != vi
There are no duplicate edges.
Each vertex can be reached directly or indirectly from every other vertex.
1 <= time, change <= 103
*/

/*
Solution 1:
BFS
Dijkstra

- build G to know the connect vertex
- build D to know the current node's cost time from vertex 1, D[index].count == 2, only keep latest 2 time is enough, because BFS will greedy pick shortest path from it
- use heap to quick find current visited `minimum cost` path and its index
- check this index's connected neighbor(next)
- try update the nextCost, and check it with D

Time Complexity: O(VElogV)
Space Complexity: O(V)
*/
class Solution {
    func secondMinimum(_ n: Int, _ edges: [[Int]], _ time: Int, _ change: Int) -> Int {
        // G[i] means array of vertex which connect to vertex i
        var G = Array(repeating: [Int](), count: n+1)
        for edge in edges {
            G[edge[0]].append(edge[1])
            G[edge[1]].append(edge[0])
        }

        // D[i] means array of finded paths' taken time
        var D = Array(repeating: [Int](), count: n+1)
        D[1] = [0]

        // heap is array of [index, paths time]
        var heap = [(index: Int, cost: Int)]()
        insert(&heap, (1, 0))
        while !heap.isEmpty {
            let (index, cost) = heap.removeFirst()
            if index == n, D[index].count == 2 {
                return max(D[index][0], D[index][1])
            }

            for next in G[index] {
                var nextCost = 0
                if (cost / change) % 2 == 0 {
                    nextCost = cost + time
                } else {
                    let wait = ceil(Double(cost) / Double(2*change))
                    nextCost += (Int(wait) * 2 * change + time)
                }

                if D[next].isEmpty
                || (D[next].count == 1 && D[next][0] != nextCost) {
                    D[next].append(nextCost)
                    insert(&heap, (next, nextCost))
                }
            }
            // print(index, heap, D)
        }
        return -1
    }

    func insert(_ heap: inout [(index: Int, cost: Int)],
                _ target: (index: Int, cost: Int)) {
        if heap.isEmpty {
            heap.append(target)
            return
        }

        var l = 0
        var r = heap.count-1
        while l < r {
            let mid = l + (r-l)/2
            if heap[mid].cost <= target.cost {
                l = mid+1
            } else {
                r = mid
            }
        }

        heap.insert(target,
                    at: heap[l].cost <= target.cost ? l+1 : l)
    }
}