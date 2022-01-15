'''
Given an array of integers arr, you are initially positioned at the first index of the array.

In one step you can jump from index i to index:

i + 1 where: i + 1 < arr.length.
i - 1 where: i - 1 >= 0.
j where: arr[i] == arr[j] and i != j.
Return the minimum number of steps to reach the last index of the array.

Notice that you can not jump outside of the array at any time.



Example 1:

Input: arr = [100,-23,-23,404,100,23,23,23,3,404]
Output: 3
Explanation: You need three jumps from index 0 --> 4 --> 3 --> 9. Note that index 9 is the last index of the array.
Example 2:

Input: arr = [7]
Output: 0
Explanation: Start index is the last index. You do not need to jump.
Example 3:

Input: arr = [7,6,9,6,9,6,9,7]
Output: 1
Explanation: You can jump directly from index 0 to index 7 which is last index of the array.


Constraints:

1 <= arr.length <= 5 * 104
-108 <= arr[i] <= 108
'''

'''
Solution 2
bidirectional BFS

Time Complexity: O(n)
Space Complexity: O(n)
'''
class Solution:
    def minJumps(self, arr: List[int]) -> int:
        n = len(arr)
        if n <= 1:
            return 0

        graph = {}
        for i in range(n):
            if arr[i] in graph:
                graph[arr[i]].append(i)
            else:
                graph[arr[i]] = [i]

        startSet = set([0])
        endSet = set([n-1])

        visited = set([0, n-1])

        step = 0
        while startSet:
            # always keep start one has fewer nodes
            if len(startSet) > len(endSet):
                startSet, endSet = endSet, startSet

            nextStart = set()

            for cur in startSet:
                # check same element index
                for next in graph[arr[cur]]:
                    if next in endSet:
                        return step+1
                    if next not in visited:
                        visited.add(next)
                        nextStart.add(next)

                # clear same element to avoid redundant check
                graph[arr[cur]].clear()

                if cur+1 in endSet or cur-1 in endSet:
                    return step+1

                if cur+1 < n and cur+1 not in visited:
                    visited.add(cur+1)
                    nextStart.add(cur+1)

                if cur-1 >= 0 and cur-1 not in visited:
                    visited.add(cur-1)
                    nextStart.add(cur-1)

            startSet = nextStart
            step += 1

        return step



'''
Solution 1:
BFS

check all possible path, see if there is one reaches the last index
store visited
save all same element index in map

clear dictionary to avoid check that element again

Time Complexity: O(n)
Space Complexity: O(n)
'''
class Solution:
    def minJumps(self, arr: List[int]) -> int:
        n = len(arr)
        if n <= 1:
            return 0

        graph = {}
        for i in range(n):
            if arr[i] in graph:
                graph[arr[i]].append(i)
            else:
                graph[arr[i]] = [i]

        startSet = set([0])
        visited = set([0])

        step = 0
        while startSet:
            nextStart = set()

            for cur in startSet:
                # check same element index
                for next in graph[arr[cur]]:
                    if next == n-1:
                        return step+1
                    if next not in visited:
                        visited.add(next)
                        nextStart.add(next)

                # clear same element to avoid redundant check
                graph[arr[cur]].clear()

                if cur+1 == n-1 or cur-1 == n-1:
                    return step+1

                if cur+1 < n and cur+1 not in visited:
                    visited.add(cur+1)
                    nextStart.add(cur+1)

                if cur-1 >= 0 and cur-1 not in visited:
                    visited.add(cur-1)
                    nextStart.add(cur-1)

            startSet = nextStart
            step += 1

        return step

