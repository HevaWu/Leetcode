/*
You want to build some obstacle courses. You are given a 0-indexed integer array obstacles of length n, where obstacles[i] describes the height of the ith obstacle.

For every index i between 0 and n - 1 (inclusive), find the length of the longest obstacle course in obstacles such that:

You choose any number of obstacles between 0 and i inclusive.
You must include the ith obstacle in the course.
You must put the chosen obstacles in the same order as they appear in obstacles.
Every obstacle (except the first) is taller than or the same height as the obstacle immediately before it.
Return an array ans of length n, where ans[i] is the length of the longest obstacle course for index i as described above.



Example 1:

Input: obstacles = [1,2,3,2]
Output: [1,2,3,3]
Explanation: The longest valid obstacle course at each position is:
- i = 0: [1], [1] has length 1.
- i = 1: [1,2], [1,2] has length 2.
- i = 2: [1,2,3], [1,2,3] has length 3.
- i = 3: [1,2,3,2], [1,2,2] has length 3.
Example 2:

Input: obstacles = [2,2,1]
Output: [1,2,1]
Explanation: The longest valid obstacle course at each position is:
- i = 0: [2], [2] has length 1.
- i = 1: [2,2], [2,2] has length 2.
- i = 2: [2,2,1], [1] has length 1.
Example 3:

Input: obstacles = [3,1,5,6,4,2]
Output: [1,1,2,3,2,2]
Explanation: The longest valid obstacle course at each position is:
- i = 0: [3], [3] has length 1.
- i = 1: [3,1], [1] has length 1.
- i = 2: [3,1,5], [3,5] has length 2. [1,5] is also valid.
- i = 3: [3,1,5,6], [3,5,6] has length 3. [1,5,6] is also valid.
- i = 4: [3,1,5,6,4], [3,4] has length 2. [1,4] is also valid.
- i = 5: [3,1,5,6,4,2], [1,2] has length 2.


Constraints:

n == obstacles.length
1 <= n <= 105
1 <= obstacles[i] <= 107
*/

/*
Solution 3:
binary search

KEY: insert and replace

add/update obstacles[i] into arr

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func longestObstacleCourseAtEachPosition(_ obstacles: [Int]) -> [Int] {
        let n = obstacles.count
        if n == 1 { return [1] }

        var res = Array(repeating: 1, count: n)
        var arr = [obstacles[0]]

        for i in 1..<n {
            let index = findIndex(obstacles[i], arr)
            res[i] = index+1

            // not directly insert, insert and replace
            if index == arr.count {
                arr.append(obstacles[i])
            } else {
                arr[index] = obstacles[i]
            }
        }

        return res
    }

    func findIndex(_ target: Int, _ arr: [Int]) -> Int {
        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] <= target {
                left = mid+1
            } else {
                right = mid
            }
        }
        return arr[left] <= target ? left+1 : left
    }
}

/*
Solution 2: TLE
find longest path in [0..<i] end with obstacles[i]
sort by increasing longest

Time Complexity: O(nlogn)
*/
class Solution {
    func longestObstacleCourseAtEachPosition(_ obstacles: [Int]) -> [Int] {
        let n = obstacles.count
        if n == 1 { return [1] }

        var res = Array(repeating: 1, count: n)
        var arr: [(oVal: Int, longest: Int)] = [(obstacles[0], 1)]

        for i in 1..<n {
            for j in stride(from: arr.count-1, through: 0, by: -1) {
                if arr[j].oVal <= obstacles[i] {
                    res[i] = 1+arr[j].longest
                    break
                }
            }
            insert((obstacles[i], res[i]), &arr)
        }

        return res
    }

    // arr sorted by increasing longest
    func insert(_ target: (oVal: Int, longest: Int), _ arr: inout [(oVal: Int, longest: Int)]) {
        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid].longest <= target.longest {
                left = mid+1
            } else {
                right = mid
            }
        }
        arr.insert(target, at: arr[left].longest <= target.longest ? left+1 : left)
    }
}

/*
Solution 1: TLE
*/
class Solution {
    func longestObstacleCourseAtEachPosition(_ obstacles: [Int]) -> [Int] {
        let n = obstacles.count
        if n == 1 { return [1] }

        var res = Array(repeating: 1, count: n)

        for i in 1..<n {

            for j in 0..<i {
                if obstacles[j] <= obstacles[i] {
                    res[i] = max(res[i], 1+res[j])
                }
            }
        }

        return res
    }

}