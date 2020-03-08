// Given a 2D binary matrix filled with 0's and 1's, find the largest square containing only 1's and return its area.

// Example:

// Input: 

// 1 0 1 0 0
// 1 0 1 1 1
// 1 1 1 1 1
// 1 0 0 1 0

// Output: 4

// Solution 1: force
// search every cell with 1
// We use a variable to contain the size of the largest square found so far and another variable to store the size of the current, both initialized to 0. Starting from the left uppermost point in the matrix, we search for a 1. No operation needs to be done for a 0. Whenever a 1 is found, we try to find out the largest square that can be formed including that 1. For this, we move diagonally (right and downwards), i.e. we increment the row index and column index temporarily and then check whether all the elements of that row and column are 1 or not. If all the elements happen to be 1, we move diagonally further as previously. If even one element turns out to be 0, we stop this diagonal movement and update the size of the largest square. Now we, continue the traversal of the matrix from the element next to the initial 1 found, till all the elements of the matrix have been traversed.
// 
// Time complexity : O\big((mn)^2\big). In worst case, we need to traverse the complete matrix for every 1.
// Space complexity : O(1)O(1). No extra space is used.
class Solution {
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return 0 }
        let n = matrix.count
        let m = matrix[0].count
        
        var maxLen = 0
        for i in 0..<n {
            for j in 0..<m where matrix[i][j] == "1" {
                var len = 1
                var isSquare = true
                while len + i < n, len + j < m, isSquare {
                    // check diagnose
                    
                    // check rows
                    for k in j...(len+j) {
                        if matrix[i+len][k] == "0" {
                            isSquare = false
                            break
                        }
                    }
                    
                    // check cols
                    for k in i...(len+i) {
                        if matrix[k][len+j] == "0" {
                            isSquare = false
                            break
                        }
                    }
                    
                    if isSquare {
                        len += 1
                    }
                }
                
                if len > maxLen {
                    maxLen = len
                }
            }
        }
        
        return maxLen * maxLen
    }
}

// Solution 2: DP
// We initialize another matrix (dp) with the same dimensions as the original one initialized with all 0’s.
// dp(i,j) represents the side length of the maximum square whose bottom right corner is the cell with index (i,j) in the original matrix.
// Starting from index (0,0), for every 1 found in the original matrix, we update the value of the current element as
// \text{dp}(i, j) = \min \big( \text{dp}(i-1, j), \text{dp}(i-1, j-1), \text{dp}(i, j-1) \big) + 1.dp(i,j)=min(dp(i−1,j),dp(i−1,j−1),dp(i,j−1))+1.
// We also remember the size of the largest square found so far. In this way, we traverse the original matrix once and find out the required maximum size. This gives the side length of the square (say maxsqlenmaxsqlen). The required result is the area maxsqlen^2
// 
// Time complexity : O(mn)O(mn). Single pass.
// Space complexity : O(mn)O(mn). Another matrix of same size is used for dp.
class Solution {
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return 0 }
        let n = matrix.count
        let m = matrix[0].count
        
        var dp = Array(repeating: Array(repeating: 0, count: m+1), count: n+1)
        var maxLen = 0
        for i in 1...n {
            for j in 1...m where matrix[i-1][j-1] == "1" {
                dp[i][j] = min(min(dp[i-1][j], dp[i][j-1]), dp[i-1][j-1]) + 1
                if dp[i][j] > maxLen {
                    maxLen = dp[i][j]
                }
            }
        }
        
        return maxLen*maxLen
    }
}

// Solution 3: Optimize DP
// In the previous approach for calculating dp of i^{th}row we are using only the previous element and the (i-1)^{th}row. Therefore, we don't need 2D dp matrix as 1D dp array will be sufficient for this.
// Initially the dp array contains all 0's. As we scan the elements of the original matrix across a row, we keep on updating the dp array as per the equation dp[j]=min(dp[j-1],dp[j],prev)dp[j]=min(dp[j−1],dp[j],prev), where prev refers to the old dp[j-1]dp[j−1]. For every row, we repeat the same process and update in the same dp array.
// 
// Time complexity : O(mn)O(mn). Single pass.
// Space complexity : O(n)O(n). Another array which stores elements in a row is used for dp.
class Solution {
    func maximalSquare(_ matrix: [[Character]]) -> Int {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return 0 }
        let n = matrix.count
        let m = matrix[0].count
        
        var dp = Array(repeating: 0, count: m+1)
        var pre = 0
        var maxLen = 0
        for i in 1...n {
            for j in 1...m {
                let temp = dp[j]
                if matrix[i-1][j-1] == "1" {
                    dp[j] = min(min(dp[j-1], dp[j]), pre) + 1
                    if dp[j] > maxLen {
                        maxLen = dp[j]
                    }
                } else {
                    // need to update to 0 if current is "0"
                    dp[j] = 0
                }
                pre = temp
            }
        }
        return maxLen * maxLen
    }
}
