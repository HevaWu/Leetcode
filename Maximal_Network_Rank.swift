/*
There is an infrastructure of n cities with some number of roads connecting these cities. Each roads[i] = [ai, bi] indicates that there is a bidirectional road between cities ai and bi.

The network rank of two different cities is defined as the total number of directly connected roads to either city. If a road is directly connected to both cities, it is only counted once.

The maximal network rank of the infrastructure is the maximum network rank of all pairs of different cities.

Given the integer n and the array roads, return the maximal network rank of the entire infrastructure.



Example 1:



Input: n = 4, roads = [[0,1],[0,3],[1,2],[1,3]]
Output: 4
Explanation: The network rank of cities 0 and 1 is 4 as there are 4 roads that are connected to either 0 or 1. The road between 0 and 1 is only counted once.
Example 2:



Input: n = 5, roads = [[0,1],[0,3],[1,2],[1,3],[2,3],[2,4]]
Output: 5
Explanation: There are 5 roads that are connected to cities 1 or 2.
Example 3:

Input: n = 8, roads = [[0,1],[1,2],[2,3],[2,4],[5,6],[5,7]]
Output: 5
Explanation: The network rank of 2 and 5 is 5. Notice that all the cities do not have to be connected.


Constraints:

2 <= n <= 100
0 <= roads.length <= n * (n - 1) / 2
roads[i].length == 2
0 <= ai, bi <= n-1
ai != bi
Each pair of cities has at most one road connecting them.
*/

/*
Solution 1:
build connect and graph to help check the rank in each city pair
- connect[i] = number of cities connected with ith city
- graph[i][j] = true, if city i and city j is connect with each other

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func maximalNetworkRank(_ n: Int, _ roads: [[Int]]) -> Int {
        // connect[i] means number of cities connected with ith city
        var connect = Array(repeating: 0, count: n)

        // graph[i][j] == true if city i and city j is connected
        var graph = Array(
            repeating: Array(repeating: false, count: n),
            count: n
        )

        for road in roads {
            connect[road[0]] += 1
            connect[road[1]] += 1
            graph[road[0]][road[1]] = true
            graph[road[1]][road[0]] = true
        }
        // print(connect)

        // check each pair to get the maximal network rank
        var maxRank = 0

        for i in 0..<n {
            guard i+1 < n else { continue }
            for j in (i+1)..<n {
                let curRank = connect[i]
                + connect[j]
                + (graph[i][j] ? -1 : 0)
                maxRank = max(maxRank, curRank)
            }
        }

        return maxRank
    }
}