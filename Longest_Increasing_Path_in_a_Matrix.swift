// Given an integer matrix, find the length of the longest increasing path.

// From each cell, you can either move to four directions: left, right, up or down. You may NOT move diagonally or move outside of the boundary (i.e. wrap-around is not allowed).

// Example 1:

// Input: nums = 
// [
//   [9,9,4],
//   [6,6,8],
//   [2,1,1]
// ] 
// Output: 4 
// Explanation: The longest increasing path is [1, 2, 6, 9].
// Example 2:

// Input: nums = 
// [
//   [3,4,5],
//   [3,2,6],
//   [2,2,1]
// ] 
// Output: 4 
// Explanation: The longest increasing path is [3, 4, 5, 6]. Moving diagonally is not allowed.

// Solution 1: DFS
// for each cell, find its longest path, and compare it with previous result
// 
// Time complexity : O(2^(m+n). The search is repeated for each valid increasing path. In the worst case we can have O(2^{m+n}) calls. 
// Space complexity : O(mn)O(mn). For each DFS we need O(h)O(h) space used by the system stack, where hh is the maximum depth of the recursion. In the worst case, O(h) = O(mn)O(h)=O(mn).
class Solution {
    var directions = [(0,-1), (0,1), (-1,0), (1,0)]
    
    func longestIncreasingPath(_ matrix: [[Int]]) -> Int {
        guard !matrix.isEmpty else { return 0 }
        
        let m = matrix.count
        let n = matrix[0].count
        
        var maxPath = 0
        for i in 0..<m {
            for j in 0..<n {
                maxPath = max(maxPath, increasePath(matrix, i, j, m, n))
            }
        }
        return maxPath
    }
    
    private func increasePath(_ matrix: [[Int]], _ i: Int, _ j: Int, _ m: Int, _ n: Int) -> Int {
        var path = 0  
        for d in directions {
            let x = i + d.0
            let y = j + d.1
            guard x >= 0, x < m, y >= 0, y < n, matrix[x][y] > matrix[i][j] else { continue }
            path = max(path, increasePath(matrix, x, y, m, n))
        }
        return path + 1
    }
}

// Solution 2: DFS + memorization
// Cache the results for the recursion so that any subproblem will be calculated only once.
// use a set to prevent the repeat visit in one DFS search. This optimization will reduce the time complexity for each DFS to O(mn)O(mn) and the total algorithm to O(m^2n^2)
// 
// Time complexity : O(mn)O(mn). Each vertex/cell will be calculated once and only once, and each edge will be visited once and only once. The total time complexity is then O(V+E)O(V+E). VV is the total number of vertices and EE is the total number of edges. In our problem, O(V) = O(mn)O(V)=O(mn), O(E) = O(4V) = O(mn)O(E)=O(4V)=O(mn).
// Space complexity : O(mn)O(mn). The cache dominates the space complexity.
class Solution {
    var directions = [(0,1),(0,-1),(-1,0),(1,0)]
    var m = 0
    var n = 0
    var cache = [[Int]]()
    
    func longestIncreasingPath(_ matrix: [[Int]]) -> Int {
        guard !matrix.isEmpty else { return 0 }
        
        m = matrix.count
        n = matrix[0].count
        
        cache = Array(repeating: Array(repeating: 0, count: n), count: m)
        
        var maxPath = 0
        for i in 0..<m {
            for j in 0..<n {
                maxPath = max(maxPath, increasePath(matrix, i, j))
            }
        }
        return maxPath
    }
    
    private func increasePath(_ matrix: [[Int]], _ i: Int, _ j: Int) -> Int {
        guard cache[i][j] == 0 else { return cache[i][j] }
        for d in directions {
            let x = i + d.0
            let y = j + d.1
            guard x >= 0, x < m, y >= 0, y < n, matrix[x][y] > matrix[i][j] else { continue }
            cache[i][j] = max(cache[i][j], increasePath(matrix, x, y))
        }
        cache[i][j] += 1
        return cache[i][j]
    }
}

class Solution {
    
    var dir = [0, 1, 0, -1, 0]
    var n = 0
    var m = 0
    
    var visited = [[Int]]()
    var matrix = [[Int]]()
    
    func longestIncreasingPath(_ matrix: [[Int]]) -> Int {
        guard !matrix.isEmpty else { return 0 }
        self.matrix = matrix
        n = matrix.count
        m = matrix[0].count
        
        visited = Array(repeating: Array(repeating: 0, count: m), count: n)
        var path = 0
        for i in 0..<n {
            for j in 0..<m {
                path = max(path, dfs(i, j))
            }
        }
        return path
    }
    
    func dfs(_ i: Int, _ j: Int) -> Int {
        if visited[i][j] > 0 { return visited[i][j] }
        visited[i][j] = 1
        var temp = 1
        for d in 0..<dir.count-1 {
            let x = i + dir[d]
            let y = j + dir[d+1]
            if x < 0 || x >= n || y < 0 || y >= m { continue }
            if matrix[x][y] > matrix[i][j] { 
                temp = max(temp, dfs(x, y)+1)
            }
        }
        visited[i][j] = temp
        return temp
    }
}

// Solution 3: Dynamic programming
// We have to perform the topological sort explicitly as a preprocess. After that, we can solve the problem dynamically using our transition function following the stored topological order.
// Time complexity : O(mn)O(mn). The the topological sort is O(V+E) = O(mn)O(V+E)=O(mn). Here, VV is the total number of vertices and EE is the total number of edges. In our problem, O(V) = O(mn)O(V)=O(mn), O(E) = O(4V) = O(mn)O(E)=O(4V)=O(mn).
// Space complexity : O(mn)O(mn). We need to store the out degrees and each level of leaves.
