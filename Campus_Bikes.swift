// On a campus represented as a 2D grid, there are N workers and M bikes, with N <= M. Each worker and bike is a 2D coordinate on this grid.

// Our goal is to assign a bike to each worker. Among the available bikes and workers, we choose the (worker, bike) pair with the shortest Manhattan distance between each other, and assign the bike to that worker. (If there are multiple (worker, bike) pairs with the same shortest Manhattan distance, we choose the pair with the smallest worker index; if there are multiple ways to do that, we choose the pair with the smallest bike index). We repeat this process until there are no available workers.

// The Manhattan distance between two points p1 and p2 is Manhattan(p1, p2) = |p1.x - p2.x| + |p1.y - p2.y|.

// Return a vector ans of length N, where ans[i] is the index (0-indexed) of the bike that the i-th worker is assigned to.

 

// Example 1:



// Input: workers = [[0,0],[2,1]], bikes = [[1,2],[3,3]]
// Output: [1,0]
// Explanation: 
// Worker 1 grabs Bike 0 as they are closest (without ties), and Worker 0 is assigned Bike 1. So the output is [1, 0].
// Example 2:



// Input: workers = [[0,0],[1,1],[2,0]], bikes = [[1,0],[2,2],[2,1]]
// Output: [0,2,1]
// Explanation: 
// Worker 0 grabs Bike 0 at first. Worker 1 and Worker 2 share the same distance to Bike 2, thus Worker 1 is assigned to Bike 2, and Worker 2 will take Bike 1. So the output is [0,2,1].
 

// Note:

// 0 <= workers[i][j], bikes[i][j] < 1000
// All worker and bike locations are distinct.
// 1 <= workers.length <= bikes.length <= 1000

// Solution 1: bucket sort
// Since the range of distance is [0, 2000] which is much lower than the # of pairs, which is 1e6. It's a good time to use bucket sort. Basically, it's to put each pair into the bucket representing its distance. Eventually, we can loop thru each bucket from lower distance.
// Therefore, it's O(M * N) time and O(M * N) space.
class Solution {
    func assignBikes(_ workers: [[Int]], _ bikes: [[Int]]) -> [Int] {
        guard !workers.isEmpty else { return [Int]() }
        
        var buckets = Array(repeating: [(Int, Int)](), count: 2000)
        for i in 0..<workers.count {
            for j in 0..<bikes.count {
                let dis = abs(workers[i][0] - bikes[j][0]) + abs(workers[i][1] - bikes[j][1])
                buckets[dis].append((i, j))
            }
        }
        
        var visited = Array(repeating: false, count: bikes.count)
        var assigned = Array(repeating: -1, count: workers.count)
        for i in 0..<buckets.count {
            guard !buckets[i].isEmpty else { continue }
            for j in 0..<buckets[i].count {
                let temp = buckets[i][j]
                if !visited[temp.1], assigned[temp.0] == -1 {
                    assigned[temp.0] = temp.1
                    visited[temp.1] = true
                }
            }
        }
        return assigned
    }
}