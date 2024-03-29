/*
Given an integer rowIndex, return the rowIndexth row of the Pascal's triangle.

Notice that the row index starts from 0.


In Pascal's triangle, each number is the sum of the two numbers directly above it.

Follow up:

Could you optimize your algorithm to use only O(k) extra space?



Example 1:

Input: rowIndex = 3
Output: [1,3,3,1]
Example 2:

Input: rowIndex = 0
Output: [1]
Example 3:

Input: rowIndex = 1
Output: [1,1]


Constraints:

0 <= rowIndex <= 33

*/

/*
Solution 2:
Iterative

build tri array
Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func getRow(_ rowIndex: Int) -> [Int] {
        if rowIndex == 0 { return [1] }
        var tri = Array(repeating: [Int](), count: rowIndex+1)
        tri[0] = [1]
        for i in 1...rowIndex {
            tri[i] = Array(repeating: 1, count: i+1)
            for j in 1..<i {
                tri[i][j] = tri[i-1][j-1] + tri[i-1][j]
            }
            tri[i][i] = 1
        }
        return tri[rowIndex]
    }
}

/*
Solution 1:
recursive

after getting pre, cur is only append the 2 last sum

Time Complexity: O(n!) it needs to count pre 2 numbers sum
Space Complexity: O(n!)
*/
class Solution {
    func getRow(_ rowIndex: Int) -> [Int] {
        if rowIndex == 0 { return [1] }
        var cur = [1]
        let pre = getRow(rowIndex-1)
        for i in 1..<pre.count {
            cur.append(pre[i] + pre[i-1])
        }
        cur.append(1)
        return cur
    }
}
