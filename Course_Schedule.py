'''
There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
Return true if you can finish all courses. Otherwise, return false.



Example 1:

Input: numCourses = 2, prerequisites = [[1,0]]
Output: true
Explanation: There are a total of 2 courses to take.
To take course 1 you should have finished course 0. So it is possible.
Example 2:

Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
Output: false
Explanation: There are a total of 2 courses to take.
To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.


Constraints:

1 <= numCourses <= 105
0 <= prerequisites.length <= 5000
prerequisites[i].length == 2
0 <= ai, bi < numCourses
All the pairs prerequisites[i] are unique.
'''

'''
Solution 1:
bfs

build prerequisites graph[pre][course]
use courses[] to memo courseNo's prerequisites

start from check no prerequisites course
wait until searching finished,
if count != numCourses, there is a circle exists

Time Complexity: O(n)
Space Complexity: O(n*n)
'''
class Solution:
    def canFinish(self, numCourses: int, prerequisites: List[List[int]]) -> bool:
        # need[i] means the number of prerequisite courses for course i
        need = [0 for i in range(numCourses)]
        # pend[i] means once take course i, the courses can take
        nextCourses = [[] for i in range(numCourses)]
        for p in prerequisites:
            need[p[0]] += 1
            nextCourses[p[1]].append(p[0])

        # the course user could take for now
        queue = []
        for i in range(numCourses):
            if need[i] == 0:
                queue.append(i)

        while queue:
            cur = queue.pop(0)

            # next might be able to take course
            for i in nextCourses[cur]:
                need[i] -= 1
                if need[i] == 0:
                    queue.append(i)

        # check if any remaining course there
        for i in range(numCourses):
            if need[i] != 0:
                return False
        return True
