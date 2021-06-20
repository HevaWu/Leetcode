/*
You are given two m x n binary matrices grid1 and grid2 containing only 0's (representing water) and 1's (representing land). An island is a group of 1's connected 4-directionally (horizontal or vertical). Any cells outside of the grid are considered water cells.

An island in grid2 is considered a sub-island if there is an island in grid1 that contains all the cells that make up this island in grid2.

Return the number of islands in grid2 that are considered sub-islands.



Example 1:


Input: grid1 = [[1,1,1,0,0],[0,1,1,1,1],[0,0,0,0,0],[1,0,0,0,0],[1,1,0,1,1]], grid2 = [[1,1,1,0,0],[0,0,1,1,1],[0,1,0,0,0],[1,0,1,1,0],[0,1,0,1,0]]
Output: 3
Explanation: In the picture above, the grid on the left is grid1 and the grid on the right is grid2.
The 1s colored red in grid2 are those considered to be part of a sub-island. There are three sub-islands.
Example 2:


Input: grid1 = [[1,0,1,0,1],[1,1,1,1,1],[0,0,0,0,0],[1,1,1,1,1],[1,0,1,0,1]], grid2 = [[0,0,0,0,0],[1,1,1,1,1],[0,1,0,1,0],[0,1,0,1,0],[1,0,0,0,1]]
Output: 2
Explanation: In the picture above, the grid on the left is grid1 and the grid on the right is grid2.
The 1s colored red in grid2 are those considered to be part of a sub-island. There are two sub-islands.


Constraints:

m == grid1.length == grid2.length
n == grid1[i].length == grid2[i].length
1 <= m, n <= 500
grid1[i][j] and grid2[i][j] are either 0 or 1.
*/

/*
Solution 2:
DFS

only use dfs would be enough at here
for each island in grid2, we check if current connected all can be find in grid1, if so, mark it as sub, if not, not add it

Time Complexity: O(mn)
Space Complexity: O(1)
*/
class Solution {
    func countSubIslands(_ grid1: [[Int]], _ grid2: [[Int]]) -> Int {
        let m = grid1.count
        let n = grid1[0].count

        var grid2 = grid2
        var finded = 0
        for i in 0..<m {
            for j in 0..<n {
                if grid2[i][j] == 1, dfs(i, j, m, n, grid1, &grid2) {
                    grid2[i][j] = 0
                    finded += 1
                }
            }
        }
        return finded
    }

    let dir = [0, 1, 0, -1, 0]
    func dfs(_ i: Int, _ j: Int, _ m: Int, _ n: Int,
             _ grid1: [[Int]], _ grid2: inout [[Int]]) -> Bool {
        var isSub = grid1[i][j] == 1
        for d in 0..<4 {
            let r = i + dir[d]
            let c = j + dir[d+1]
            if r >= 0, r < m, c >= 0, c < n, grid2[r][c] == 1 {
                grid2[r][c] = 0
                isSub = dfs(r, c, m, n, grid1, &grid2) && isSub
            }
        }
        return isSub
    }
}

/*
Solution 1:
DFS + UF

use uf to record current linked island cells

for grid1, dfs process, set first find island as island root
also, mark current find island root in a set

for grid2, once find an island, use isSub to dfs check if island root is same,
if all of linked cells are in same island, and island root also in set(grid1's island root set),
mark this as a subIsland

Time Complexity: O(mn)
Space Complexity: O(mn)
*/
class Solution {
    func countSubIslands(_ grid1: [[Int]], _ grid2: [[Int]]) -> Int {
        let m = grid1.count
        let n = grid1[0].count

        // union island in grid1, make root as i*m + j
        var uf = UF(m*n)
        var grid1 = grid1
        var root = Set<Int>()
        for i in 0..<m {
            for j in 0..<n {
                if grid1[i][j] == 1 {
                    grid1[i][j] = 0

                    let ufRoot = i*n + j
                    root.insert(ufRoot)
                    dfs(i, j, m, n, &grid1, &uf, ufRoot)
                }
            }
        }

        var grid2 = grid2
        var finded = 0
        for i in 0..<m {
            for j in 0..<n {
                if grid2[i][j] == 1 {
                    grid2[i][j] = 0

                    let ufRoot = uf.find(i*n + j)
                    if isSub(i, j, m, n, &grid2, uf, ufRoot) {
                        finded += (root.contains(ufRoot) ? 1 : 0)
                        // print(i, j, ufRoot, finded)
                    }
                    // print(i, j, grid2)
                }
            }
        }

        return finded
    }

    func isSub(_ i: Int, _ j: Int, _ m: Int, _ n: Int,
               _ grid: inout [[Int]], _ uf: UF, _ ufRoot: Int) -> Bool {
        // print(i, j)
        var res = true
        for d in 0..<4 {
            let r = i + dir[d]
            let c = j + dir[d+1]
            if r >= 0, r < m, c >= 0, c < n, grid[r][c] == 1 {
                // print(i, j, r, c)
                grid[r][c] = 0

                res = (uf.find(r*n + c) == ufRoot) && res

                // put && res at the end to make sure isSub run first
                res = isSub(r, c, m, n, &grid, uf, ufRoot) && res
                // print(res)
            }
        }
        return res
    }

    let dir = [0, 1, 0, -1, 0]
    // dfs union all island
    func dfs(_ i: Int, _ j: Int, _ m: Int, _ n: Int,
             _ grid: inout [[Int]], _ uf: inout UF, _ ufRoot: Int) {
        for d in 0..<4 {
            let r = i + dir[d]
            let c = j + dir[d+1]
            if r >= 0, r < m, c >= 0, c < n, grid[r][c] == 1 {
                grid[r][c] = 0
                uf.union(ufRoot, r*n + c)
                dfs(r, c, m, n, &grid, &uf, ufRoot)
            }
        }
    }
}

class UF {
    var parent: [Int]
    // var rank: [Int]
    init(_ n: Int) {
        parent = Array(0..<n)
        // rank = Array(repeating: 0, count: n)
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
        if x == y || px == py { return }
        parent[py] = px

        // if px == py { return }
        // if rank[px] < rank[py] {
        //     parent[py] = px
        // } else {
        //     if rank[px] == rank[py] {
        //         rank[px] += 1
        //     }
        //     parent[px] = py
        // }
    }
}