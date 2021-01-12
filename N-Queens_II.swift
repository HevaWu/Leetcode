/*
The n-queens puzzle is the problem of placing n queens on an n x n chessboard such that no two queens attack each other.

Given an integer n, return the number of distinct solutions to the n-queens puzzle.

 

Example 1:


Input: n = 4
Output: 2
Explanation: There are two distinct solutions to the 4-queens puzzle as shown.
Example 2:

Input: n = 1
Output: 1
 

Constraints:

1 <= n <= 9
*/

/*
Solution 2:
Optimize solution 1 by moving count out of for loop
*/
class Solution {
    var n = 0
    var visitedC = Set<Int>()
    var visitedDale = Set<Int>()
    var visitedHill = Set<Int>()
    
    func totalNQueens(_ n: Int) -> Int {
        self.n = n
        var res = 0
        backTrack(0, &res)
        return res
    }
    
    func backTrack(_ row: Int, _ res: inout Int) {
        if row == n {
            res += 1
        }
        for col in 0..<n {
            if visitedC.contains(col) { continue }
            let dale = row - col
            if visitedDale.contains(dale) { continue }
            let hill = row + col
            if visitedHill.contains(hill) { continue }
            
            // place queen
            visitedC.insert(col)
            visitedDale.insert(dale)
            visitedHill.insert(hill)

            // move to next row
            backTrack(row+1, &res)

            // recover
            visitedC.remove(col)
            visitedDale.remove(dale)
            visitedHill.remove(hill)
        }
    }
}


/*
Solution 1:
BackTrack

backTrack go through by row
Then search if we can put next queen in row+1

1. check if we put queen in row,col will not conflict with other queens
2. if no conflict, and current row==n-1, add count(reach the bottom)
3. if we still can go next, first put this queen, then search next line
4. remove row,col queens for search if we can put row,col+1... queen

Time Complexity: O(n^2)
Space Complexity: O(3n)
*/
class Solution {
    var n = 0
    var visitedC = Set<Int>()
    var visitedDale = Set<Int>()
    var visitedHill = Set<Int>()
    
    func totalNQueens(_ n: Int) -> Int {
        self.n = n
        return backTrack(0, 0)
    }
    
    func backTrack(_ row: Int, _ count: Int) -> Int {
        var count = count
        for col in 0..<n {
            if visitedC.contains(col) { continue }
            let dale = row - col
            if visitedDale.contains(dale) { continue }
            let hill = row + col
            if visitedHill.contains(hill) { continue }
            
            if row == n-1 {
                count += 1
            } else {
                // place queen
                visitedC.insert(col)
                visitedDale.insert(dale)
                visitedHill.insert(hill)
                
                // move to next row
                count = backTrack(row+1, count)
                
                // recover
                visitedC.remove(col)
                visitedDale.remove(dale)
                visitedHill.remove(hill)
            }
        }
        return count
    }
}
