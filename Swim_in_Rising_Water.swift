/*
On an N x N grid, each square grid[i][j] represents the elevation at that point (i,j).

Now rain starts to fall. At time t, the depth of the water everywhere is t. You can swim from a square to another 4-directionally adjacent square if and only if the elevation of both squares individually are at most t. You can swim infinite distance in zero time. Of course, you must stay within the boundaries of the grid during your swim.

You start at the top left square (0, 0). What is the least time until you can reach the bottom right square (N-1, N-1)?

Example 1:

Input: [[0,2],[1,3]]
Output: 3
Explanation:
At time 0, you are in grid location (0, 0).
You cannot go anywhere else because 4-directionally adjacent neighbors have a higher elevation than t = 0.

You cannot reach point (1, 1) until time 3.
When the depth of water is 3, we can swim anywhere inside the grid.
Example 2:

Input: [[0,1,2,3,4],[24,23,22,21,5],[12,13,14,15,16],[11,17,18,19,20],[10,9,8,7,6]]
Output: 16
Explanation:
 0  1  2  3  4
24 23 22 21  5
12 13 14 15 16
11 17 18 19 20
10  9  8  7  6

The final route is marked in bold.
We need to wait until time 16 so that (0, 0) and (4, 4) are connected.
Note:

2 <= N <= 50.
grid[i][j] is a permutation of [0, ..., N*N - 1].
*/

/*
Solution 3:
binary search + dfs

- binary search check if canSwim from 0,0 to n-1,n-1 at "mid" time
- in canSwim, dfs check if there is connected path(from 0,0 to n-1,n-1) that all elements <= time

Time Complexity: O(logn * n * n)
Space Complexity: O(n*n)
*/
class Solution {
    func swimInWater(_ grid: [[Int]]) -> Int {
        let n = grid.count
        var visited = [[Bool]]()

        var left = 0
        var right = n*n-1
        while left < right {
            let mid = left + (right-left)/2
            visited = Array(
                repeating: Array(repeating: false, count: n),
                count: n
            )
            // add grid[0][0] checking incase 0,0 time is not 0
            if grid[0][0] <= mid && canSwim(mid, grid, 0, 0, n, n, &visited) {
                right = mid
            } else {
                left = mid+1
            }
        }
        return left
    }

    let dir = [0, 1, 0, -1, 0]
    // can swim from i,j to m-1, n-1
    func canSwim(_ time: Int, _ grid: [[Int]],
                 _ i: Int, _ j : Int, _ m: Int, _ n: Int,
                 _ visited: inout [[Bool]]) -> Bool {
        if i == m-1, j == n-1 { return true }
        visited[i][j] = true

        for d in 0..<4 {
            let r = i+dir[d]
            let c = j+dir[d+1]
            if r >= 0, r < m, c >= 0, c < n, !visited[r][c], grid[r][c] <= time {
                if canSwim(time, grid, r, c, m, n, &visited)  { return true }
            }
        }
        return false
    }
}

/*
Solution 2:
binary search + UF

Time Complexity: O(logn * n* n)
Space Complexity: O(n*n)
*/
class Solution {
    func swimInWater(_ grid: [[Int]]) -> Int {
        let n = grid.count

        var left = 0
        var right = n*n-1

        let target = n*n-1

        while left < right {
            let mid = left + (right-left)/2
            var uf = UF(n*n)
            for i in 0..<n {
                var canUnion = false
                for j in 0..<n {
                    if grid[i][j] > mid { continue }
                    // down
                    if i+1 < n, grid[i+1][j] <= mid {
                        uf.union(i*n + j, (i+1)*n + j)
                        canUnion = true
                    }
                    // right
                    if j+1 < n, grid[i][j+1] <= mid {
                        uf.union(i*n + j, i*n + (j+1))
                        canUnion = true
                    }
                }
                if !canUnion { break }
            }
            if !uf.isConnected(0, target) {
                left = mid+1
            } else {
                right = mid
            }
        }
        return left
    }
}

class UF {
    var parent: [Int]
    var rank: [Int]
    init(_ n: Int) {
        parent = Array(0..<n)
        rank = Array(repeating: 0, count: n)
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func isConnected(_ x: Int, _ y: Int) -> Bool {
        return find(x) == find(y)
    }

    func union(_ x: Int, _ y: Int) {
        let px = find(x)
        let py = find(y)
        if px == py { return }

        if rank[px] == rank[py] {
            rank[py] += 1
            parent[px] = py
        } else if rank[px] < rank[py] {
            parent[px] = py
        } else {
            parent[py] = px
        }
        // parent[find(x)] = find(y)
    }
}

/*
Solution 1:
UF
Time Limit Exceeded

Time Complexity: O(time*mn)
Space Complexity: O(n*n)
*/
class Solution {
    func swimInWater(_ grid: [[Int]]) -> Int {
        let n = grid.count

        var uf = UF(n*n)
        var time = 0
        while !uf.isConnected(0, n*n-1) {
            for i in 0..<n {
                for j in 0..<n {
                    if grid[i][j] > time { continue }
                    if i+1 < n, grid[i+1][j] <= time {
                        uf.union(i*n + j, (i+1)*n + j)
                    }
                    if j+1 < n, grid[i][j+1] <= time {
                        uf.union(i*n + j, i*n + (j+1))
                    }
                }
            }
            time += 1
        }
        return time - 1
    }
}

class UF {
    var parent: [Int]
    init(_ n: Int) {
        parent = Array(0..<n)
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func isConnected(_ x: Int, _ y: Int) -> Bool {
        return find(x) == find(y)
    }

    func union(_ x: Int, _ y: Int) {
        parent[find(x)] = find(y)
    }
}