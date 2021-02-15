/*
Given a m * n matrix mat of ones (representing soldiers) and zeros (representing civilians), return the indexes of the k weakest rows in the matrix ordered from the weakest to the strongest.

A row i is weaker than row j, if the number of soldiers in row i is less than the number of soldiers in row j, or they have the same number of soldiers but i is less than j. Soldiers are always stand in the frontier of a row, that is, always ones may appear first and then zeros.

 

Example 1:

Input: mat = 
[[1,1,0,0,0],
 [1,1,1,1,0],
 [1,0,0,0,0],
 [1,1,0,0,0],
 [1,1,1,1,1]], 
k = 3
Output: [2,0,3]
Explanation: 
The number of soldiers for each row is: 
row 0 -> 2 
row 1 -> 4 
row 2 -> 1 
row 3 -> 2 
row 4 -> 5 
Rows ordered from the weakest to the strongest are [2,0,3,1,4]
Example 2:

Input: mat = 
[[1,0,0,0],
 [1,1,1,1],
 [1,0,0,0],
 [1,0,0,0]], 
k = 2
Output: [0,2]
Explanation: 
The number of soldiers for each row is: 
row 0 -> 1 
row 1 -> 4 
row 2 -> 1 
row 3 -> 1 
Rows ordered from the weakest to the strongest are [0,2,3,1]
 

Constraints:

m == mat.length
n == mat[i].length
2 <= n, m <= 100
1 <= k <= m
matrix[i][j] is either 0 or 1.
*/

/*
Solution 1
1. binary search to find each row soldiers count
2. sort soldiers array by element first, then offset

Time Complexity: O(mlogn + mlogm)
Space Complexity: O(m)
*/
class Solution {
    func kWeakestRows(_ mat: [[Int]], _ k: Int) -> [Int] {
        let m = mat.count
        let n = mat[0].count
        
        let soldiers = Array(0..<m).map {
            countSoldier(mat[$0])
        }
        
        var sorted = soldiers.enumerated()
        .sorted { (first, second) -> Bool in
            return first.element == second.element
                ? first.offset < second.offset
                : first.element < second.element
        }
        .map { $0.offset }
        
        return Array(sorted[0..<k])
    }
    
    // arr will be first 1, then zero
    // binary search last one
    func countSoldier(_ arr: [Int]) -> Int {
        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] == 1 {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return arr[left] == 1 ? left+1 : left
    }
}