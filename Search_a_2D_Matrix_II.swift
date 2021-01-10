/*
Write an efficient algorithm that searches for a target value in an m x n integer matrix. The matrix has the following properties:

Integers in each row are sorted in ascending from left to right.
Integers in each column are sorted in ascending from top to bottom.
 

Example 1:


Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 5
Output: true
Example 2:


Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 20
Output: false
 

Constraints:

m == matrix.length
n == matrix[i].length
1 <= n, m <= 300
-109 <= matix[i][j] <= 109
All the integers in each row are sorted in ascending order.
All the integers in each column are sorted in ascending order.
-109 <= target <= 109
*/

/*
Solution 2:
start from top right corner

j = n-1
i = 0
cur = matrix[i][j]
- if cur == target, return true
- if cur < target, ignore i-th row, i = i+1
- if cur > target, ignore j-th col, j = j-1

Time Complexity: O(n^2)
Space Complexity: O(1)
*/
class Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {   
        var i = 0
        var j = matrix[0].count-1
        while i < matrix.count , j >= 0 {
            let cur = matrix[i][j]
            
            if cur == target {
                return true
            } else if cur > target {
                j -= 1
            } else {
                i += 1
            }
        }
        
        return false
    }
}

/*
Solution 1:
divide and conquer

- use pivot to help search top right and bottom left part

1. find i which satisfy matrix[i-1][pivot] < target < matrix[i][pivot]
2. recursively search matrix[r1...i][pivot...c2] and matrix[i...r2][c1...pivot]

need to note:
- be careful to check if pivot is out of index
- use visited to mark if pivot col is already searched

Time Complexity: O(2 * n * logn * logm)
- m is matrix.count
- n is matrix[0].count
*/
class Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let m = matrix.count
        let n = matrix[0].count
        
        // memo searched col
        var visited = Set<Int>()
        
        // return if matrix[r1...r2][c1...c2] contains target
        func _search(_ r1: Int, _ r2: Int, _ c1: Int, _ c2: Int) -> Bool {
            // print(r1, r2, c1, c2)
            guard r1 >= 0, r1 < m, r2 >= 0, r2 < m, 
            c1 >= 0, c1 < n, c2 >= 0, c2 < n else { 
                return false 
            }
            
            var pivot = (c1+c2)/2
            if visited.contains(pivot) { 
                pivot += 1
                guard pivot <= c2, !visited.contains(pivot) else {
                    return false
                }
            }
            visited.insert(pivot)
            
            var i = r1
            while i <= r2 {
                if matrix[i][pivot] == target {
                    return true
                }
                if matrix[i][pivot] > target {
                    break
                }
                i += 1
            }
            
            // print("Pivot", pivot, i)
            if i > r2 {
                // only check right part would be enough
                return _search(r1, r2, pivot, c2)
            } else if i == r1 {
                // only check left part would be enough
                return _search(r1, r2, c1, pivot)
            } else {
                // search top-right matrix & bottom-left matrix
                return _search(r1, i, pivot, c2) || _search(i, r2, c1, pivot)
            }
        }
        
        return _search(0, m-1, 0, n-1)
    }
}