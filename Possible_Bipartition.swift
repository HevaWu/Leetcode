/*
We want to split a group of n people (labeled from 1 to n) into two groups of any size. Each person may dislike some other people, and they should not go into the same group.

Given the integer n and the array dislikes where dislikes[i] = [ai, bi] indicates that the person labeled ai does not like the person labeled bi, return true if it is possible to split everyone into two groups in this way.



Example 1:

Input: n = 4, dislikes = [[1,2],[1,3],[2,4]]
Output: true
Explanation: group1 [1,4] and group2 [2,3].
Example 2:

Input: n = 3, dislikes = [[1,2],[1,3],[2,3]]
Output: false
Example 3:

Input: n = 5, dislikes = [[1,2],[2,3],[3,4],[4,5],[1,5]]
Output: false


Constraints:

1 <= n <= 2000
0 <= dislikes.length <= 104
dislikes[i].length == 2
1 <= dislikes[i][j] <= n
ai < bi
All the pairs of dislikes are unique.
*/

/*
Solution 2:
DFS

use group array to help tracking the people assignment
- group[i] == -1, not be assigned yet
- group[i] == 0, assign to group 0
- group[i] == 1, assign to group 1

later, use 1-group[index] to quick switch group number

Time Complexity: O(n)
Space Complexity: O(n^2)
*/
class Solution {
    func possibleBipartition(_ n: Int, _ dislikes: [[Int]]) -> Bool {
        var graph = Array(repeating: [Int](), count: n+1)
        for d in dislikes {
            graph[d[0]].append(d[1])
            graph[d[1]].append(d[0])
        }

        // group == -1 not assigned yet
        // group == 0 assigned to first group
        // group == 1 assigned to second group
        var group = Array(repeating: -1, count: n+1)
        for i in 1...n {
            if group[i] == -1 {
                group[i] = 0
                if !canAssign(i, graph, 0, &group) {
                    return false
                }
            }
        }
        return true
    }

    // check if fine to assign people to groupIndex,
    // and keep dislike grouph fine
    func canAssign(_ people: Int, _ graph: [[Int]], _ groupIndex: Int,
    _ group: inout [Int]) -> Bool {
        for next in graph[people] {
            if group[next] == -1 {
                // next person is not be assigned yet
                group[next] = 1-groupIndex
                if !canAssign(next, graph, 1-groupIndex, &group) {
                    return false
                }
            } else {
                // next person already been assigned,
                // check if hakve conflict
                if group[next] != (1-groupIndex) {
                    return false
                }
            }
        }
        return true
    }
}

/*
Solution 1:
UF Union Find

- put each person's dislike person in one array
- for person i, union all this persons' dislike
  - check if after union, person i and either node in dislike array has same parent, if so, return false

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func possibleBipartition(_ n: Int, _ dislikes: [[Int]]) -> Bool {
        var person = Array(repeating: [Int](), count: n+1)
        for d in dislikes {
            person[d[0]].append(d[1])
            person[d[1]].append(d[0])
        }

        var uf = UF(n)
        for i in 1...n {
            // union all this person dislikes people
            let list = person[i]
            if !list.isEmpty {
                let dislikeHead = list[0]
                // cannot put dislike people in same group
                if list.count > 1 {
                    for j in 1..<list.count {
                        uf.union(dislikeHead, list[j])
                    }
                }
                if uf.find(i) == uf.find(dislikeHead) { return false }
            }
        }
        return true
    }
}

class UF {
    var parent: [Int]
    init(_ n: Int) {
        parent = Array(0...n)
    }

    func find(_ x: Int) -> Int {
        if x != parent[x] {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func union(_ x: Int, _ y: Int) {
        let px = find(x)
        let py = find(y)
        parent[px] = py
    }
}
