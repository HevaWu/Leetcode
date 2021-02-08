/*
Given a non-negative integer numRows, generate the first numRows of Pascal's triangle.


In Pascal's triangle, each number is the sum of the two numbers directly above it.

Example:

Input: 5
Output:
[
     [1],
    [1,1],
   [1,2,1],
  [1,3,3,1],
 [1,4,6,4,1]
]
*/

/*
Solution 1

keep pre to store previous array

Time Complexity: O(numRows^2)
Space Complexity: O(numRows)
*/
class Solution {
    func generate(_ numRows: Int) -> [[Int]] {
        guard numRows > 0 else { return [] }
        if numRows == 1 { return [[1]] }
        
        var res: [[Int]] = [[1]]
        var pre = [1]
        for i in 1..<numRows {
            let temp = pre
            for k in 0..<(pre.count-1) {
                pre[k+1] = temp[k] + temp[k+1]
            }
            pre.append(1)
            
            res.append(pre)
        }
        
        return res
    }
}