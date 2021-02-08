/*
Given a matrix of M x N elements (M rows, N columns), return all elements of the matrix in diagonal order as shown in the below image.

 

Example:

Input:
[
 [ 1, 2, 3 ],
 [ 4, 5, 6 ],
 [ 7, 8, 9 ]
]

Output:  [1,2,4,7,5,3,6,8,9]

Explanation:

 

Note:

The total number of elements of the given matrix will not exceed 10,000.
*/

/*
Solution 3:

- initialize boolean isUp to check if current diagonal is up or down
- we will only go through m*n times
- for up diagonal, next should be [i-1, j+1]
- for down diagonal, next would be [i+1, j-1]
tail = [i, j]
if direction == up, then {
   if [i, j + 1] is within bounds, then {
       next_head = [i, j + 1]
   } else { 
       next_head = [i + 1, j]
   }
} else {
   if [i + 1, j] is within bounds, then {
       next_head = [i + 1, j]
   } else { 
       next_head = [i, j + 1]
   }
}

Time Complexity: O(mn)
Space Complexity: O(1)
*/
class Solution {
    func findDiagonalOrder(_ matrix: [[Int]]) -> [Int] {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return [] }
        
        let m = matrix.count
        let n = matrix[0].count
        
        var r = 0
        var c = 0
        
        var res = [Int]()
        // [i,j] -> [i-1, j-1] going up
        // [i,j] -> [i+1, j+1] going down
        var isUp = true
        
        for i in 0..<m*n {
            res.append(matrix[r][c])
            
            let nr = r + (isUp ? -1 : 1)
            let nc = c + (isUp ? 1 : -1)
            if nr >= 0, nr < m, nc >= 0, nc < n {
                r = nr
                c = nc
            } else {
                if isUp {
                    r += (c == n-1) ? 1 : 0  
                    c += (c < n-1) ? 1 : 0
                } else {
                    c += (r == m-1) ? 1 : 0
                    r += (r < m-1) ? 1 : 0
                }
                
                isUp = !isUp
            }
        }
        
        return res
    }
}

/*
Solution 2:
clear some code
*/
class Solution {
    func findDiagonalOrder(_ matrix: [[Int]]) -> [Int] {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return [] }
        
        let m = matrix.count
        let n = matrix[0].count
        
        var res = [Int]()
        var isUp = false
        
        // 0...(m-1 + n-1)
        for k in 0...(m+n-2) {
            for i in 0...k {
                let r = isUp ? i : k-i
                let c = isUp ? k-i : i
                guard r < m, c < n else { continue }
                res.append(matrix[r][c])
            }
            
            isUp = !isUp
        }
        
        return res
    }
}

/*
Solution 1
add one flag to control traverse order

Time Complexity: O(m^2*n^2)
Space Complexity: O(mn)
*/
class Solution {
    func findDiagonalOrder(_ matrix: [[Int]]) -> [Int] {
        guard !matrix.isEmpty, !matrix[0].isEmpty else { return [] }
        
        let m = matrix.count
        let n = matrix[0].count
        
        var res = [Int]()
        var isUp = false
        
        // 0...(m-1 + n-1)
        for k in 0...(m+n-2) {
            if isUp {
                for i in 0...k {
                    let j = k-i
                    guard i < m, j < n else { continue }
                    res.append(matrix[i][j])
                }
            } else {
                for j in 0...k {
                    let i = k-j
                    guard i < m, j < n else { continue }
                    res.append(matrix[i][j])
                }
            }
            
            isUp = !isUp
        }
        
        return res
    }
}