/*
Given an n x n matrix where each of the rows and columns are sorted in ascending order, return the kth smallest element in the matrix.

Note that it is the kth smallest element in the sorted order, not the kth distinct element.

 

Example 1:

Input: matrix = [[1,5,9],[10,11,13],[12,13,15]], k = 8
Output: 13
Explanation: The elements in the matrix are [1,5,9,10,11,12,13,13,15], and the 8th smallest number is 13
Example 2:

Input: matrix = [[-5]], k = 1
Output: -5
 

Constraints:

n == matrix.length
n == matrix[i].length
1 <= n <= 300
-109 <= matrix[i][j] <= -109
All the rows and columns of matrix are guaranteed to be sorted in non-degreasing order.
1 <= k <= n2
*/

/*
Solution 1:
binary search

left = matrix[0][0]
right = matrix[n-1][n-1]

find how many element equal to 
mid =left+(right-left)/2

Time Complexity: O(log (right-left) * n * n)
Space Complexity: O(1)
*/
class Solution {
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        let n = matrix.count
        if n == 1 || k == 1 { return matrix[0][0] }
        if k == n*n { return matrix[n-1][n-1] }
        
        var left = matrix[0][0]
        var right = matrix[n-1][n-1]
        
        while left < right {
            let mid = left+(right-left)/2
            
            var count = 0
            var j = n-1
            for i in 0..<n {
                while j >= 0, matrix[i][j] > mid {
                    j -= 1
                }
                count += (j + 1)
            }
            
            if count < k {
                left = mid + 1
            } else {
                right = mid
            }
        }
        
        return left
    }
}
