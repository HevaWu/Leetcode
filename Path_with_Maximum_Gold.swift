// In a gold mine grid of size m * n, each cell in this mine has an integer representing the amount of gold in that cell, 0 if it is empty.

// Return the maximum amount of gold you can collect under the conditions:

// Every time you are located in a cell you will collect all the gold in that cell.
// From your position you can walk one step to the left, right, up or down.
// You can't visit the same cell more than once.
// Never visit a cell with 0 gold.
// You can start and stop collecting gold from any position in the grid that has some gold.
 

// Example 1:

// Input: grid = [[0,6,0],[5,8,7],[0,9,0]]
// Output: 24
// Explanation:
// [[0,6,0],
//  [5,8,7],
//  [0,9,0]]
// Path to get the maximum gold, 9 -> 8 -> 7.
// Example 2:

// Input: grid = [[1,0,7],[2,0,6],[3,4,5],[0,3,0],[9,0,20]]
// Output: 28
// Explanation:
// [[1,0,7],
//  [2,0,6],
//  [3,4,5],
//  [0,3,0],
//  [9,0,20]]
// Path to get the maximum gold, 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7.
 

// Constraints:

// 1 <= grid.length, grid[i].length <= 15
// 0 <= grid[i][j] <= 100
// There are at most 25 cells containing gold.

// Solution 1: DFS
// DFS traverse grid, mark it as 0 once it is traversed
// 
// Time complexity: O(4^(nm) for the algorithm (Although I would argue that complexity is O(3^nm) as each cell after the first would just have 3 choices at max.), O(1) for this question. Since the question states that there are at most 25 cells with gold. 
// Space complexity: O(nm) for the algorithm. O(1) for this question. Since the depth of recursion can go upto max 25 cells
class Solution {
    var dir = [0, 1, 0, -1, 0]
    
    func getMaximumGold(_ grid: [[Int]]) -> Int {
        guard !grid.isEmpty, !grid[0].isEmpty else { return 0 }
        var grid = grid
        
        var gold = 0
        for i in 0..<grid.count {
            for j in 0..<grid[0].count where grid[i][j] != 0 {
                gold = max(gold, grid[i][j] + check(&grid, i, j))
            }
        }
        
        return gold
    }
    
    func check(_ grid: inout [[Int]], _ i: Int, _ j: Int) -> Int {     
        // set grid[i][j] to 0 marked it as visited
        var temp = grid[i][j]
        grid[i][j] = 0
        
        var gold = 0
        for index in 0..<dir.count-1 {
            let i1 = i + dir[index]
            let j1 = j + dir[index+1]
            if i1 >= 0, i1 < grid.count, j1 >= 0, j1 < grid[0].count, grid[i1][j1] != 0 {
                gold = max(gold, grid[i1][j1] + check(&grid, i1, j1))
            }
        }
        grid[i][j] = temp
        return gold
    }
}