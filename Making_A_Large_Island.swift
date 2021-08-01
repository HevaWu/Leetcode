/*
You are given an n x n binary matrix grid. You are allowed to change at most one 0 to be 1.

Return the size of the largest island in grid after applying this operation.

An island is a 4-directionally connected group of 1s.



Example 1:

Input: grid = [[1,0],[0,1]]
Output: 3
Explanation: Change one 0 to 1 and connect two 1s, then we get an island with area = 3.
Example 2:

Input: grid = [[1,1],[1,0]]
Output: 4
Explanation: Change the 0 to 1 and make the island bigger, only one island with area = 4.
Example 3:

Input: grid = [[1,1],[1,1]]
Output: 4
Explanation: Can't change any 0 to 1, only one island with area = 4.


Constraints:

n == grid.length
n == grid[i].length
1 <= n <= 500
grid[i][j] is either 0 or 1.
*/

/*
Solution 1:
DFS + UF

1. go through grid, and connect all of connected island
-> use union find to record current island id
-> update all connected cell with its island size

2. go through grid, once we find a 0 cell, try to see how many island it can connect
-> use UF to track if it connect to same island again

Time Complexity: O(n^2 * n^2 + n^2)
Space Complexity: O(n^2 + n^2)
*/
class Solution {
    func largestIsland(_ grid: [[Int]]) -> Int {
        let n = grid.count
        var grid = grid
        var largest = 0

        var uf = UF(n*n)

        for i in 0..<n {
            for j in 0..<n {
                if grid[i][j] == 1 {
                    var visited = Array(
                        repeating: Array(repeating: false, count: n),
                        count: n
                    )
                    visited[i][j] = true

                    var connectCell: [(row: Int, col: Int)] = [(i, j)]
                    connect(grid, &visited, i, j, n, &connectCell, &uf)

                    let connectCount = connectCell.count
                    updateWithConnect(&grid, connectCell, connectCount)

                    largest = max(largest, connectCount)
                }
            }
        }

        // print(grid)
        // print(uf.parent)

        for i in 0..<n {
            for j in 0..<n {
                if grid[i][j] == 0 {
                    // check if change i,j to 1 can connect with some island
                    var parent = Set<Int>()
                    var canConnect = 0
                    for d in 0..<4 {
                        let r = i+dir[d]
                        let c = j+dir[d+1]
                        if r >= 0, r < n, c >= 0, c < n,
                        grid[r][c] > 0 {
                            let root = uf.find(r*n+c)
                            if !parent.contains(root) {
                                parent.insert(root)
                                canConnect += grid[r][c]

                                // print("root", r, c, root)
                            }
                        }
                    }
                    // print(i, j, canConnect, parent)

                    largest = max(largest, canConnect+1)
                }
            }
        }

        return largest
    }

    let dir = [0, 1, 0, -1, 0]
    func connect(_ grid: [[Int]], _ visited: inout [[Bool]],
                 _ i: Int, _ j: Int,
                 _ n: Int, _ connectCell: inout [(row: Int, col: Int)],
                 _ uf: inout UF) {
        for d in 0..<4 {
            let r = i+dir[d]
            let c = j+dir[d+1]
            if r >= 0, r < n, c >= 0, c < n, grid[r][c] == 1, !visited[r][c] {
                visited[r][c] = true
                uf.union(i*n+j, r*n+c)

                connectCell.append((r, c))
                connect(grid, &visited, r, c, n, &connectCell, &uf)
            }
        }
    }

    func updateWithConnect(_ grid: inout [[Int]],
                           _ connectCell: [(row: Int, col: Int)], _ connectCount: Int) {
        for (r, c) in connectCell {
            grid[r][c] = connectCount
        }
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
    }
}