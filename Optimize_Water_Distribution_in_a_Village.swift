// There are n houses in a village. We want to supply water for all the houses by building wells and laying pipes.

// For each house i, we can either build a well inside it directly with cost wells[i], or pipe in water from another well to it. The costs to lay pipes between houses are given by the array pipes, where each pipes[i] = [house1, house2, cost] represents the cost to connect house1 and house2 together using a pipe. Connections are bidirectional.

// Find the minimum total cost to supply water to all houses.

 

// Example 1:



// Input: n = 3, wells = [1,2,2], pipes = [[1,2,1],[2,3,1]]
// Output: 3
// Explanation: 
// The image shows the costs of connecting houses using pipes.
// The best strategy is to build a well in the first house with cost 1 and connect the other houses to it with cost 2 so the total cost is 3.
 

// Constraints:

// 1 <= n <= 10000
// wells.length == n
// 0 <= wells[i] <= 10^5
// 1 <= pipes.length <= 10000
// 1 <= pipes[i][0], pipes[i][1] <= n
// 0 <= pipes[i][2] <= 10^5
// pipes[i][0] != pipes[i][1]

// Solution 1: union find
// Merge all costs of pipes together and sort by key.
// Greedily lay the pipes if it can connect two seperate union.
// Appply union find to record which houses are connected.
// 
// Time O(ElogE)
// Space O(N)
class Solution {
    var uf = [Int]()
    func minCostToSupplyWater(_ n: Int, _ wells: [Int], _ pipes: [[Int]]) -> Int {
        var edges = pipes
        uf = Array(repeating: 0, count: n+1)
        
        for i in 0..<n {
            uf[i+1] = i+1 // init union find
            edges.append([0, i+1, wells[i]])
        }
        
        // sort by cost
        edges.sort(by: { first, second -> Bool in
            return first[2] < second[2]
        })
        
        // union find
        var cost = 0
        for edge in edges {
            let v1 = find(edge[0])
            let v2 = find(edge[1])
            if v1 != v2 {
                // merge 2 vertex
                uf[v1] = v2
                cost += edge[2]
            }
        }
        return cost
    }
    
    func find(_ index: Int) -> Int {
        if uf[index] != index { 
            // update current uf[index]
            uf[index] = find(uf[index]) 
        }
        return uf[index]
    }
}