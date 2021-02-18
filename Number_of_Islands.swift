// Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

// Example 1:

// Input:
// 11110
// 11010
// 11000
// 00000

// Output: 1
// Example 2:

// Input:
// 11000
// 11000
// 00100
// 00011

// Output: 3

// Solution 1: 
// for each point, if we find it is `1` mark it as an island, use dfs to check all of its surrounding `1` and change them to `0`, until we search all, keep finding the next island
// 
// Time Complexity: O(MN)
// Space Complexity: O(MN) 
class Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
        guard !grid.isEmpty else { return 0 }
        
        var grid = grid
        let m = grid.count
        let n = grid[0].count
        
        var island = 0
        
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == "1" {
                    // find a new island
                    island += 1
                    
                    // DFS all of connected 1
                    dfs(&grid, i, j, m, n)
                }
            }
        }
        return island
    }
    
    private func dfs(_ grid: inout [[Character]], _ i: Int, _ j: Int, _ m: Int, _ n: Int) {
        // mark it as already visited
        grid[i][j] = "0"
        if i > 0, grid[i-1][j] == "1" { dfs(&grid, i-1, j, m, n) }
        if i < m-1, grid[i+1][j] == "1" { dfs(&grid, i+1, j, m, n) }
        if j > 0, grid[i][j-1] == "1" { dfs(&grid, i, j-1, m, n) }
        if j < n-1, grid[i][j+1] == "1" { dfs(&grid, i, j+1, m, n) }
    }
}

// Solution 2
// BFS
// 
// Time complexity : O(M \times N)O(M×N) where MM is the number of rows and NN is the number of columns.
// Space complexity : O(min(M, N))O(min(M,N)) because in worst case where the grid is filled with lands, the size of queue can grow up to min(M,NM,N).
class Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
        guard !grid.isEmpty else { return 0 }
        
        var grid = grid
        let m = grid.count
        let n = grid[0].count
        
        var island = 0
        
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == "1" {
                    island += 1
                    bfs(&grid, i, j, m, n)
                }
            }
        }
        return island
    }
    
    private func bfs(_ grid: inout [[Character]], _ i: Int, _ j: Int, _ m: Int, _ n: Int) {    
        grid[i][j] = "0"
        
        // create bfs queue for connected 1 of i,j
        var queue = [(Int, Int)]()
        queue.insert((i, j), at: 0)
        while !queue.isEmpty {
            let node = queue.removeLast()
            let x = node.0
            let y = node.1
            
            if x > 0, grid[x-1][y] == "1" { 
                queue.insert((x-1, y), at: 0) 
                grid[x-1][y] = "0" 
            }
            if x < m-1, grid[x+1][y] == "1" { 
                queue.insert((x+1, y), at: 0) 
                grid[x+1][y] = "0" 
            }
            if y > 0, grid[x][y-1] == "1" { 
                queue.insert((x, y-1), at: 0) 
                grid[x][y-1] = "0" 
            }
            if y < n-1, grid[x][y+1] == "1" { 
                queue.insert((x, y+1), at: 0) 
                grid[x][y+1] = "0" 
            }
        }
    }
}

/*
optimize solution 2
use dir
*/
class Solution {
    func numIslands(_ grid: [[Character]]) -> Int {
        guard !grid.isEmpty else { return 0 }
        
        var grid = grid
        let m = grid.count
        let n = grid[0].count
        
        var island = 0
        
        for i in 0..<m {
            for j in 0..<n where grid[i][j] == "1" {
                island += 1
                bfs(&grid, i, j, m, n)
            }
        }
        return island
    }
    
    private func bfs(_ grid: inout [[Character]], _ i: Int, _ j: Int, _ m: Int, _ n: Int) {    
        var dir = [0,-1,0,1,0]
        grid[i][j] = "0"
        
        // create bfs queue for connected 1 of i,j
        var queue = [(Int, Int)]()
        queue.insert((i, j), at: 0)
        while !queue.isEmpty {
            let (x,y) = queue.removeLast()
            
            for d in 0..<4 {
                let nx = x + dir[d]
                let ny = y + dir[d+1]
                
                if nx >= 0, nx < m, ny >= 0, ny < n, grid[nx][ny] == "1" {
                    queue.insert((nx,ny), at: 0)
                    grid[nx][ny] = "0"
                }
            }
        }
    }
}
