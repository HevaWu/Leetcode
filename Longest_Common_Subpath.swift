/*
There is a country of n cities numbered from 0 to n - 1. In this country, there is a road connecting every pair of cities.

There are m friends numbered from 0 to m - 1 who are traveling through the country. Each one of them will take a path consisting of some cities. Each path is represented by an integer array that contains the visited cities in order. The path may contain a city more than once, but the same city will not be listed consecutively.

Given an integer n and a 2D integer array paths where paths[i] is an integer array representing the path of the ith friend, return the length of the longest common subpath that is shared by every friend's path, or 0 if there is no common subpath at all.

A subpath of a path is a contiguous sequence of cities within that path.



Example 1:

Input: n = 5, paths = [[0,1,2,3,4],
                       [2,3,4],
                       [4,0,1,2,3]]
Output: 2
Explanation: The longest common subpath is [2,3].
Example 2:

Input: n = 3, paths = [[0],[1],[2]]
Output: 0
Explanation: There is no common subpath shared by the three paths.
Example 3:

Input: n = 5, paths = [[0,1,2,3,4],
                       [4,3,2,1,0]]
Output: 1
Explanation: The possible longest common subpaths are [0], [1], [2], [3], and [4]. All have a length of 1.


Constraints:

1 <= n <= 105
m == paths.length
2 <= m <= 105
sum(paths[i].length) <= 105
0 <= paths[i][j] < n
The same city is not listed multiple times consecutively in paths[i].
*/

/*
Solution 2:
rolling hash + binary search

set base and mod for handling rolling hash properly

Time Complexity: O(log_(min paths[i].count) * m * paths[i].count)
Space Complexity: O(min paths[i].count)
*/
class Solution {
    let base = 100_007
    let mod = Int(1e11+7)
    var p = [Int]()

    func longestCommonSubpath(_ n: Int, _ paths: [[Int]]) -> Int {
        let m = paths.count

        var left = 0
        //  +1 at here
        var right = paths.map { $0.count }.min()!

        p = Array(repeating: 0, count: right)
        p[0] = 1
        for i in 1..<right {
            p[i] = base * p[i-1] % mod
        }

        while left < right {
            // use (right+left+1)/2 not (left+(right-left)/2)
            let mid = (right+left+1)/2

            if rollingHashCheck(mid, paths, m) {
                left = mid
            } else {
                right = mid-1
            }
        }
        return left
    }

    func rollingHashCheck(_ len: Int, _ paths: [[Int]], _ m: Int) -> Bool {
        var hash_set = Set<Int>()

        for i in 0..<m {
            if paths[i].count < len { return false }

            var i_set = Set<Int>()
            var hash = 0
            for j in 0..<len {
                hash = (hash + ((paths[i][j] + 1) * p[len-1-j]) % mod) % mod
            }

            if i == 0 {
                hash_set.insert(hash)
            } else {
                if hash_set.contains(hash) {
                    i_set.insert(hash)
                }
            }

            // iteratively add hash value
            for j in len..<paths[i].count {
                hash = (hash + mod - ((paths[i][j-len]+1) * p[len-1]) % mod) % mod
                hash = hash * base % mod
                hash = (hash + paths[i][j] + 1) % mod
                if i == 0 {
                    hash_set.insert(hash)
                } else {
                    if hash_set.contains(hash) {
                        i_set.insert(hash)
                    }
                }
            }

            if i > 0 {
                hash_set = i_set
            }

            if hash_set.isEmpty { return false }
        }

        return true
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func longestCommonSubpath(_ n: Int, _ paths: [[Int]]) -> Int {
        let m = paths.count

        var left = 0
        //  +1 at here
        var right = paths.map { $0.count }.min()!+1
        while left+1 < right {
            let mid = left + (right-left)/2

            let canFind = rollingHashCheck(mid, paths, m)
            if canFind {
                left = mid
            } else {
                right = mid
            }
        }
        return left
    }

    func rollingHashCheck(_ len: Int, _ paths: [[Int]], _ m: Int) -> Bool {
        var hash_set = Set<Int>()

        var cur_set = Set<Int>()
        // input paths[0] first
        if paths[0].count < len { return false }
        for i0 in 0...(paths[0].count - len) {
            var temp = paths[0][i0..<(i0+len)]
            cur_set.insert(temp.hashValue)
        }

        for i in 1..<m {
            var next_set = Set<Int>()
            if paths[i].count < len { return false }
            for ii in 0...(paths[i].count - len) {
                var temp = paths[i][ii..<(ii+len)]
                let val = temp.hashValue
                if cur_set.contains(val) {
                    next_set.insert(val)
                }
            }

            cur_set = next_set
            if cur_set.isEmpty { return false }
        }

        return true
    }
}