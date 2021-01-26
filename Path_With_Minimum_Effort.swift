/*
You are a hiker preparing for an upcoming hike. You are given heights, a 2D array of size rows x columns, where heights[row][col] represents the height of cell (row, col). You are situated in the top-left cell, (0, 0), and you hope to travel to the bottom-right cell, (rows-1, columns-1) (i.e., 0-indexed). You can move up, down, left, or right, and you wish to find a route that requires the minimum effort.

A route's effort is the maximum absolute difference in heights between two consecutive cells of the route.

Return the minimum effort required to travel from the top-left cell to the bottom-right cell.

 

Example 1:



Input: heights = [[1,2,2],[3,8,2],[5,3,5]]
Output: 2
Explanation: The route of [1,3,5,3,5] has a maximum absolute difference of 2 in consecutive cells.
This is better than the route of [1,2,2,2,5], where the maximum absolute difference is 3.
Example 2:



Input: heights = [[1,2,3],[3,8,4],[5,3,5]]
Output: 1
Explanation: The route of [1,2,3,4,5] has a maximum absolute difference of 1 in consecutive cells, which is better than route [1,3,5,3,5].
Example 3:


Input: heights = [[1,2,1,1,1],[1,2,1,2,1],[1,2,1,2,1],[1,2,1,2,1],[1,1,1,2,1]]
Output: 0
Explanation: This route does not require any effort.
 

Constraints:

rows == heights.length
columns == heights[i].length
1 <= rows, columns <= 100
1 <= heights[i][j] <= 106

Hint 1:
Consider the grid as a graph, where adjacent cells have an edge with cost of the difference between the cells.

Hint 2:
If you are given threshold k, check if it is possible to go from (0, 0) to (n-1, m-1) using only edges of ≤ k cost.

Hint 3: 
Binary search the k value.
*/

/*
Solution 2:
DSU
kruscal algorithm

create DSU with m*n space
*/
class Solution {
    func minimumEffortPath(_ heights: [[Int]]) -> Int {
        let m = heights.count
        let n = heights[0].count
        
        if m == 1, n == 1 { return 0 }
        
        var dsu = DSU(m*n)
        
        var edges = [[Int]]()
        for i in 0..<m {
            for j in 0..<n {
                for (r, c) in [(0, 1), (1, 0)] {
                    let nr = i + r
                    let nc = j + c
                    if nr < m, nc < n {
                        edges.append([i*n + j, nr*n + nc, abs(heights[nr][nc] - heights[i][j])])
                    }
                }
            }
        }
        
        edges.sort { $0[2] > $1[2] }
        // print(edges)
        
        while let e = edges.popLast() {
            dsu.union(e[0], e[1])
            // (m-1)*n + n-1 = m*n-1
            if dsu.find(0) == dsu.find(m*n - 1) {
                return e[2]
            }
        }
        return 0
    }
}

class DSU {
    var parent = [Int]()
    
    init(_ n: Int) {
        parent = Array(0..<n)
    }
    
    func find(_ x: Int) -> Int {
        if x != parent[x] {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }
    
    func union(_ x: Int, _ y: Int) {
        parent[find(x)] = find(y)
    }
}

/*
Solution 1:
binary search
if we can find a route has <= k cost

Time Complexity: O(mnlogn)
Space Complexity: O(mn)
*/
class Solution {
    var dir = [0, 1, 0, -1, 0]
    
    func minimumEffortPath(_ heights: [[Int]]) -> Int {
        let m = heights.count
        let n = heights[0].count
        
        if m == 1, n == 1 { return 0 }
        
        var left = 0
        var right = 1000000-1
        while left < right {
            let mid = left + (right-left)/2
            if canFind(heights, m, n, mid) {
                right = mid
            } else {
                left = mid+1
            }
            // print(left, right)
        }
        return left
    }
    
    // check if we can find a route from [0,0] to [m-1, n-1] with only <= target diff
    func canFind(_ heights: [[Int]], _ m: Int, _ n: Int, _ target: Int) -> Bool {
        var queue: [(Int, Int)] = [(0,0)]
        var visited = Array(repeating: Array(repeating: false, count: n), 
                            count: m)
        visited[0][0] = true
        
        while !queue.isEmpty {
            let (curR, curC) = queue.removeFirst()
            
            if curR == m-1, curC == n-1 {
                return true
            }
            
            for d in 0..<4 {
                let row = curR+dir[d]
                let col = curC+dir[d+1]
                                
                if row >= 0, row < m, col >= 0, col < n,
                !visited[row][col],
                abs(heights[row][col] - heights[curR][curC]) <= target {
                    
                    queue.append((row, col))
                    visited[row][col] = true
                }
            }
            // print(queue)
        }
        return false
    }
}