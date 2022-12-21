'''
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
'''

'''
Solution 2:
DFS

use group array to help tracking the people assignment
- group[i] == -1, not be assigned yet
- group[i] == 0, assign to group 0
- group[i] == 1, assign to group 1

later, use 1-group[index] to quick switch group number

Time Complexity: O(n)
Space Complexity: O(n^2)
'''
class Solution:
    def possibleBipartition(self, n: int, dislikes: List[List[int]]) -> bool:
        graph = [[] for _ in range(n+1)]
        for d in dislikes:
            graph[d[0]].append(d[1])
            graph[d[1]].append(d[0])

        group = [-1 for _ in range(n+1)]

        def canAssign(person: int, groupIndex: int):
            nonlocal graph, group
            for next in graph[person]:
                if group[next] == -1:
                    group[next] = 1-groupIndex
                    if canAssign(next, 1-groupIndex) == False:
                        return False
                else:
                    if group[next] != (1-groupIndex):
                        return False
            return True

        for i in range(n+1):
            if group[i] == -1:
                if canAssign(i, 0) == False:
                    return False
        return True


