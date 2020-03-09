// On a campus represented as a 2D grid, there are N workers and M bikes, with N <= M. Each worker and bike is a 2D coordinate on this grid.

// We assign one unique bike to each worker so that the sum of the Manhattan distances between each worker and their assigned bike is minimized.

// The Manhattan distance between two points p1 and p2 is Manhattan(p1, p2) = |p1.x - p2.x| + |p1.y - p2.y|.

// Return the minimum possible sum of Manhattan distances between each worker and their assigned bike.

 

// Example 1:



// Input: workers = [[0,0],[2,1]], bikes = [[1,2],[3,3]]
// Output: 6
// Explanation: 
// We assign bike 0 to worker 0, bike 1 to worker 1. The Manhattan distance of both assignments is 3, so the output is 6.
// Example 2:



// Input: workers = [[0,0],[1,1],[2,0]], bikes = [[1,0],[2,2],[2,1]]
// Output: 4
// Explanation: 
// We first assign bike 0 to worker 0, then assign bike 1 to worker 1 or worker 2, bike 2 to worker 2 or worker 1. Both assignments lead to sum of the Manhattan distances as 4.
 

// Note:

// 0 <= workers[i][0], workers[i][1], bikes[i][0], bikes[i][1] < 1000
// All worker and bike locations are distinct.
// 1 <= workers.length <= bikes.length <= 10


// Solution 1: DFS
// 
// Time complexity: O(n!)
// Space complexity: O(m+2n)
class Solution {
    var minDis = Int.max
    var visited = [Bool]()
    var workers = [[Int]]()
    var bikes = [[Int]]()
    
    func assignBikes(_ workers: [[Int]], _ bikes: [[Int]]) -> Int {
        self.workers = workers
        self.bikes = bikes
        visited = Array(repeating: false, count: bikes.count)
        dfs(0, 0)
        return minDis
    }
    
    func dfs(_ wIndex: Int, _ dis: Int) {
        guard wIndex < workers.count else { 
            minDis = min(minDis, dis)
            return 
        }
        
        guard dis <= minDis else { return }
        
        for i in 0..<bikes.count where !visited[i] {
            visited[i] = true
            dfs(wIndex+1, dis + (
                abs(bikes[i][0] - workers[wIndex][0]) + abs(bikes[i][1] - workers[wIndex][1])
            ))
            visited[i] = false
        }
    }
}

// Solution 2: use bit
// Here we use bit to represent jth bike is used or not
// state : dp[i][s] = the min distance for first i workers to build the state s ,
// transit: dp[i][s] = min(dp[i][s], dp[i - 1][prev] + dis(w[i -1], bike[j)) | 0 < j <m, prev = s ^ (1 << j)
// init:dp[0][0] = 0;
// result: dp[n][s] s should have n bit
// 
// Time complexity: O(m*n)
// Space complexity: O(nm*3)
class Solution {
    func assignBikes(_ workers: [[Int]], _ bikes: [[Int]]) -> Int {
        guard !workers.isEmpty else { return 0 }
        
        var visited = [[Int]: Int]()
        
        // i, taken, cost
        // i means worker i.
        // taken is a binary state representation of all bikes. each bit in taken correspond to bike's status: assigned or not
        //cost means current distance after assign first i workers using state taken.
        var queue = [[0,0,0]] // should use pripority queue at here, otherwise, time out of limited
        
        var minDis = Int.max
        while !queue.isEmpty {
            var cur = queue.removeLast()
            
            let index = cur[0]
            let taken = cur[1]
            let cost = cur[2]
            
            if let pre = visited[[index, taken]], cost < pre {
                visited[[index, taken]] = cost
            } else {
                visited[[index, taken]] = cost
            }
            
            if index == workers.count { 
                minDis = min(minDis, cost)
                continue
            }
            
            for j in 0..<bikes.count {
                if (taken & (1<<j)) == 0{
                    let next = [
                        index + 1, 
                        taken | (1<<j), 
                        cost + (abs(bikes[j][0] - workers[index][0]) + abs(bikes[j][1] - workers[index][1]))
                    ]
                    queue.insert(next, at: 0)
                }
            }
        }
        
        return minDis
    }
}