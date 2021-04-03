/*
There are n items each belonging to zero or one of m groups where group[i] is the group that the i-th item belongs to and it's equal to -1 if the i-th item belongs to no group. The items and the groups are zero indexed. A group can have no item belonging to it.

Return a sorted list of the items such that:

The items that belong to the same group are next to each other in the sorted list.
There are some relations between these items where beforeItems[i] is a list containing all the items that should come before the i-th item in the sorted array (to the left of the i-th item).
Return any solution if there is more than one solution and return an empty list if there is no solution.



Example 1:



Input: n = 8, m = 2, group = [-1,-1,1,0,0,1,0,-1], beforeItems = [[],[6],[5],[6],[3,6],[],[],[]]
Output: [6,3,4,1,5,2,0,7]
Example 2:

Input: n = 8, m = 2, group = [-1,-1,1,0,0,1,0,-1], beforeItems = [[],[6],[5],[6],[3],[],[4],[]]
Output: []
Explanation: This is the same as example 1 except that 4 needs to be before 6 in the sorted list.


Constraints:

1 <= m <= n <= 3 * 104
group.length == beforeItems.length == n
-1 <= group[i] <= m - 1
0 <= beforeItems[i].length <= n - 1
0 <= beforeItems[i][j] <= n - 1
i != beforeItems[i][j]
beforeItems[i] does not contain duplicates elements.
*/

/*
Solution 1:
dfs

use n+m to handle group part
use m extra space to handle if item has group

Note the beforeItems checking logic:
We need to put item in n+group[x] if it belongs to one group
But, if cur and before belong to same group, we can directly set graph[item].append(i)
- let beforeIndex = group[item] == -1 ? item : n+group[item]
- let curIndex = group[i] == -1 ? i : n+group[i]

after handling group and beforeItems
we can prepare dfs to see if we can find a route there

Time Complexity: O(n^2)
Space Complexity: O((n+m)* n))
*/
class Solution {
    func sortItems(_ n: Int, _ m: Int, _ group: [Int], _ beforeItems: [[Int]]) -> [Int] {
        var graph = Array(repeating: [Int](), count: n+m)
        var res = [Int]()

        var indegree = Array(repeating: 0, count: n+m)

        // handle group
        for i in 0..<n {
            if group[i] == -1 { continue }
            graph[n+group[i]].append(i)
            indegree[i] += 1
        }

        // handle beforeItems
        for i in 0..<n {
            for item in beforeItems[i] {
                let beforeIndex = group[item] == -1 ? item : n+group[item]
                let curIndex = group[i] == -1 ? i : n+group[i]

                if beforeIndex == curIndex {
                    // same group, directly append i after item
                    graph[item].append(i)
                    indegree[i] += 1
                } else {
                    // different group, put curIndex after group part
                    graph[beforeIndex].append(curIndex)
                    indegree[curIndex] += 1
                }
            }
        }

        for i in 0..<n+m {
            if indegree[i] == 0 {
                dfs(graph, &indegree, i, n, &res)
            }
        }

        return res.count == n ? res : [Int]()
    }

    func dfs(_ graph: [[Int]], _ indegree: inout [Int],
             _ cur: Int, _ n: Int, _ res: inout [Int]) {
        if cur < n {
            res.append(cur)
        }
        indegree[cur] -= 1

        for child in graph[cur] {
            indegree[child] -= 1
            if indegree[child] == 0 {
                dfs(graph, &indegree, child, n, &res)
            }
        }
    }
}