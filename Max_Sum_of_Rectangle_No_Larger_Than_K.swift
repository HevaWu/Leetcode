// Given a non-empty 2D matrix matrix and an integer k, find the max sum of a rectangle in the matrix such that its sum is no larger than k.

// Example:

// Input: matrix = [[1,0,1],[0,-2,3]], k = 2
// Output: 2 
// Explanation: Because the sum of rectangle [[0, 1], [-2, 3]] is 2,
//              and 2 is the max number no larger than k (k = 2).
// Note:

// The rectangle inside the matrix must have an area > 0.
// What if the number of rows is much larger than the number of columns?

// Solution 1:
// 2D Kadane's algorithm + 1D maxSum problem with sum limit k
// 
// Time complexity: O(n^2)
// Space complexity: O(n)
class Solution {
    func maxSumSubmatrix(_ matrix: [[Int]], _ k: Int) -> Int {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return 0 }
        let n = matrix.count
        let m = matrix[0].count
        
        var maxSum = Int.min
        for l in 0..<m {
            var rowSum = Array(repeating: 0, count: n)
            for r in l..<m {
                for i in 0..<n {
                    rowSum[i] += matrix[i][r]
                }
                
                // find max subarray no more than K
                var curMax = maxSumInArray(rowSum, k)
                maxSum = max(maxSum, curMax)   
            }
        }
        
        return maxSum
    }
    
    // max sum of subarray <= k
    func maxSumInArray(_ arr: [Int], _ k: Int) -> Int {
        guard arr.count > 1 else { return arr[0] <= k ? arr[0] : Int.min }
        
        var maxSum = Int.min
        for i in 0..<arr.count {
            var j = i + 1
            var temp = arr[i]
            if temp == k { return k }
            while j < arr.count {
                temp += arr[j]
                if temp == k { return k }
                if temp > maxSum, temp <= k {
                    maxSum = temp
                }
                j += 1
            }
        }
        return maxSum <= k ? maxSum : Int.min
    }
}