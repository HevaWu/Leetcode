/*
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
*/

/*
Solution 2
bidirectional BFS

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func minJumps(_ arr: [Int]) -> Int {
        let n = arr.count
        if n == 1 { return 0 }

        // key is arr[i]
        // value is array of index which equal to arr[i]
        var map = [Int: [Int]]()
        for i in 0..<n {
            map[arr[i], default: [Int]()].append(i)
        }

        // BFS bidirectional
        var startSet = Set<Int>()
        startSet.insert(0)

        var endSet = Set<Int>()
        endSet.insert(n-1)

        var visited = Array(repeating: false, count: n)
        visited[0] = true
        visited[n-1] = true

        var step = 0

        while !startSet.isEmpty {
            // always keep start as small size
            if startSet.count > endSet.count {
                let temp = startSet
                startSet = endSet
                endSet = temp
            }

            var nextStart = Set<Int>()
            for cur in startSet {
                if let list = map[arr[cur]] {
                    for next in list {
                        if endSet.contains(next) {
                            return step + 1
                        }
                        if !visited[next] {
                            visited[next] = true
                            nextStart.insert(next)
                        }
                    }
                    map[arr[cur]] = nil
                }

                if endSet.contains(cur+1) || endSet.contains(cur-1) {
                    return step + 1
                }

                // i+1
                if cur+1 < n, !visited[cur+1] {
                    visited[cur+1] = true
                    nextStart.insert(cur+1)
                }

                // i-1
                if cur-1 >= 0, !visited[cur-1] {
                    visited[cur-1] = true
                    nextStart.insert(cur-1)
                }
            }

            startSet = nextStart
            step += 1
        }

        return step
    }
}

/*
Solution 1:
BFS

check all possible path, see if there is one reaches the last index
store visited
save all same element index in map

clear dictionary to avoid check that element again

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func minJumps(_ arr: [Int]) -> Int {
        let n = arr.count
        if n == 1 { return 0 }

        // key is arr[i]
        // value is array of index which equal to arr[i]
        var map = [Int: [Int]]()
        for i in 0..<n {
            map[arr[i], default: [Int]()].append(i)
        }

        // BFS find shortest path
        var queue = Set<Int>()
        queue.insert(0)

        // use to record which index has already added to be checked
        var visited = Array(repeating: false, count: n)
        visited[0] = true

        var step = 0

        while !queue.isEmpty {
            let size = queue.count

            var nextQ = Set<Int>()
            for cur in queue {
                if cur == n-1 {
                    return step
                }

                // i+1
                if cur+1 < n, !visited[cur+1] {
                    visited[cur+1] = true
                    nextQ.insert(cur+1)
                }

                // i-1
                if cur-1 >= 0, !visited[cur-1] {
                    visited[cur-1] = true
                    nextQ.insert(cur-1)
                }

                // same index
                if let list = map[arr[cur]] {
                    for next in list {
                        if !visited[next] {
                            visited[next] = true
                            nextQ.insert(next)
                        }
                    }

                    // clear that element record to avoid check same index again
                    map[arr[cur]] = nil
                }
            }

            step += 1
            queue = nextQ
        }

        return step
    }
}