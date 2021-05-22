/*
The n-queens puzzle is the problem of placing n queens on an n x n chessboard such that no two queens attack each other.

Given an integer n, return all distinct solutions to the n-queens puzzle.

Each solution contains a distinct board configuration of the n-queens' placement, where 'Q' and '.' both indicate a queen and an empty space, respectively.



Example 1:


Input: n = 4
Output: [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]
Explanation: There exist two distinct solutions to the 4-queens puzzle as shown above
Example 2:

Input: n = 1
Output: [["Q"]]


Constraints:

1 <= n <= 9
*/

/*
Solution 1:
backtrack

iterate each row to check if we can pick a col cur[row][col] to place Q

Time Complexity:O(N!+S(N)∗N^2)=O(N!)
- Unlike the brute force approach, we will only place queens on squares that aren't under attack. For the first queen, we have NN options. For the next queen, we won't attempt to place it in the same column as the first queen, and there must be at least one square attacked diagonally by the first queen as well. Thus, the maximum number of squares we can consider for the second queen is N - 2N−2. For the third queen, we won't attempt to place it in 2 columns already occupied by the first 2 queens, and there must be at least two squares attacked diagonally from the first 2 queens. Thus, the maximum number of squares we can consider for the third queen is N - 4N−4. This pattern continues, resulting in an approximate time complexity of N!N!.
- While it costs O(N^2) to build each valid solution, the amount of valid solutions S(N)S(N) does not grow nearly as fast as N!N!, so O(N! + S(N) * N^2) = O(N!)O(N!+S(N)∗N^2)=O(N!)

Space Complexity: O(N^2)
*/
class Solution {
    func solveNQueens(_ n: Int) -> [[String]] {
        var cur: [[Character]] = Array(
            repeating: Array(repeating: ".", count: n),
            count: n
        )

        var res = [[String]]()
        check(0, n, &cur, &res)
        return res
    }

    func check(_ row: Int, _ n: Int, _ cur: inout [[Character]], _ res: inout [[String]]) {
        if row == n {
            // transfer [[Character]] to [String]
            let valid = cur.map { String($0) }
            res.append(valid)
            return
        }

        // find where to put Q at cur[row]
        for j in 0..<n {
            if canPlace(row, j, n, cur) {
                cur[row][j] = "Q"
                check(row+1, n, &cur, &res)
                cur[row][j] = "."
            }
        }
    }

    func canPlace(_ r: Int, _ c: Int, _ n: Int, _ cur: [[Character]]) -> Bool {
        // 0..<r to skip later all empty cell
        for i in 0..<r {
            for j in 0..<n {
                if cur[i][j] == "Q" {
                    // check same column & diagonal
                    if j == c || r-i == c-j || i-r == c-j { return false }
                }
            }
        }

        return true
    }
}