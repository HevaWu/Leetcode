// Given a 01 matrix M, find the longest line of consecutive one in the matrix. The line could be horizontal, vertical, diagonal or anti-diagonal.
// Example:
// Input:
// [[0,1,1,0],
//  [0,1,1,0],
//  [0,0,0,1]]
// Output: 3
// Hint: The number of elements in the given matrix will not exceed 10,000.

// Solution 1: brute force
// 
// Time complexity : O(n^2). We traverse along the entire matrix 4 times.
// Space complexity : O(1)O(1). Constant space is used.

// Solution 2: 3D DP
// Instead of traversing over the same matrix multiple times, we can keep a track of the 1' along all the lines possible while traversing the matrix once only. In order to do so, we make use of a 4mn4mn sized dpdp array. Here, dp[0]dp[0], dp[1]dp[1], dp[2]dp[2] ,dp[3]dp[3] are used to store the maximum number of continuous 1's found so far along the Horizontal, Vertical, Diagonal and Anti-diagonal lines respectively. e.g. dp[i][j][0]dp[i][j][0] is used to store the number of continuous 1's found so far(till we reach the element M[i][j]M[i][j]), along the horizontal lines only.
// Thus, we traverse the matrix MM in a row-wise fashion only but, keep updating the entries for every dpdp appropriately.
// 
// Time complexity : O(mn)O(mn). We traverse the entire matrix once only.
// Space complexity : O(mn)O(mn). dpdp array of size 4mn4mn is used, where mm and nn are the number of rows ans coloumns of the matrix.
class Solution {
    func longestLine(_ M: [[Int]]) -> Int {
        guard !M.isEmpty, !M[0].isEmpty else { return 0 }
        let n = M.count
        let m = M[0].count
        var M = M
        
        var longest = 0
        // 0,1,2,3 means Horizontal, Vertical, Diagonal and Anti-diagonal
        var dp = Array(repeating: Array(repeating: [0, 0, 0, 0], count: m), count: n)
        for i in 0..<n {
            for j in 0..<m where M[i][j] == 1 {
                dp[i][j][0] = j > 0 ? dp[i][j-1][0] + 1 : 1
                dp[i][j][1] = i > 0 ? dp[i-1][j][1] + 1 : 1
                dp[i][j][2] = (i > 0 && j > 0) ? dp[i-1][j-1][2] + 1 : 1
                dp[i][j][3] = (i > 0 && j < m-1) ? dp[i-1][j+1][3] + 1 : 1
                longest = max(
                    longest, 
                    max(
                        max(dp[i][j][0], dp[i][j][1]),
                        max(dp[i][j][2], dp[i][j][3])
                    )
                )
            }
        }
        return longest
    }
}

// Solution 3: 2D DP
// we can observe that the current dpdp entry is dependent only on the entries of the just previous corresponding dpdp row. Thus, instead of maintaining a 2-D dpdp matrix for each kind of line of 1's possible, we can use a 1-d array for each one of them, and update the corresponding entries in the same row during each row's traversal. Taking this into account, the previous 3-D dpdp matrix shrinks to a 2-D dpdp matrix now. The rest of the procedure remains same as the previous approach.
// 
// Time complexity : O(mn)O(mn). The entire matrix is traversed once only.
// Space complexity : O(n)O(n). dpdp array of size 4n4n is used, where nn is the number of columns of the matrix.
class Solution {
    func longestLine(_ M: [[Int]]) -> Int {
        guard !M.isEmpty, !M[0].isEmpty else { return 0 }
        let n = M.count
        let m = M[0].count
        var M = M
        
        var longest = 0
        // 0,1,2,3 means Horizontal, Vertical, Diagonal and Anti-diagonal
        // check only the rows
        var dp = Array(repeating: [0, 0, 0, 0], count: m)
        for i in 0..<n {
            var pre = 0
            for j in 0..<m {
                if M[i][j] == 1 {
                    dp[j][0] = j > 0 ? dp[j-1][0] + 1 : 1
                    dp[j][1] = i > 0 ? dp[j][1] + 1 : 1
                    
                    var temp = dp[j][2]
                    dp[j][2] = (i > 0 && j > 0) ? pre + 1 : 1
                    pre = temp
                    
                    dp[j][3] = (i > 0 && j < m-1) ? dp[j+1][3] + 1 : 1
                    longest = max(
                        longest,
                        max(
                            max(dp[j][0], dp[j][1]),
                            max(dp[j][2], dp[j][3])
                        )
                    )
                } else {
                    pre = dp[j][2]
                    dp[j][0] = 0
                    dp[j][1] = 0
                    dp[j][2] = 0
                    dp[j][3] = 0
                }
            }
        }
        return longest
    }
}