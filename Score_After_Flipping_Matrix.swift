import UIKit

/*
 Score After Flipping Matrix

 We have a two dimensional matrix A where each value is 0 or 1.

 A move consists of choosing any row or column, and toggling each value in that row or column: changing all 0s to 1s, and all 1s to 0s.

 After making any number of moves, every row of this matrix is interpreted as a binary number, and the score of the matrix is the sum of these numbers.

 Return the highest possible score.

 Example 1:

 Input: [[0,0,1,1],[1,0,1,0],[1,1,0,0]]
 Output: 39
 Explanation:
 Toggled to [[1,1,1,1],[1,0,0,1],[1,1,1,1]].
 0b1111 + 0b1001 + 0b1111 = 15 + 9 + 15 = 39


 Note:

 1 <= A.length <= 20
 1 <= A[0].length <= 20
 A[i][j] is 0 or 1.

 ---------------------------------------------------------------------------

 Idea:
 1. check each row's 1st number, if it is 0, toggle this row, the toggled binary array number must larger than the original one
 2. check current dictionary's column sum, if col sum is less than row/2, toggle column
 3. calculate current dictionary's decimal number

 m rows
 n cols
 O(mn)
 */

class Solution {
    func matrixScore(_ A: [[Int]]) -> Int {
        var toggledA = A

        let rows: Int = A.count
        let cols: Int = A[0].count

        var colSum: [Int] = [Int](repeating: 0, count: cols)
        for index in 0..<A.count {
            if A[index][0] == 0 {
                // toggled binary number must larger than the original one
                toggledA = toggle(toggledA, isToggleRow: true, index: index)
            }
            colSum = sumArr(colSum, toggledA[index])
        }

        for index in 0..<colSum.count {
            // check if current col number is less than half of rows
            // should toggle current column
            if colSum[index] <= rows / 2 {
                // toggle column
                toggledA = toggle(toggledA, isToggleRow: false, index: index)
            }
        }

        print(toggledA)
        return numInDic(toggledA)
    }

    // toggle index row or column
    func toggle(_ dic: [[Int]], isToggleRow: Bool, index: Int) -> [[Int]] {
        var result: [[Int]] = dic

        if isToggleRow {
            // toggel index row
            for i in 0..<dic[0].count {
                result[index][i] = 1 - result[index][i]
            }
        } else {
            // toggle index column
            for j in 0..<dic.count {
                result[j][index] = 1 - result[j][index]
            }
        }

        return result
    }

    // sum 2 arrays
    func sumArr(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
        guard arr1.count == arr2.count else { return [] }
        var result: [Int] = arr1
        for index in 0..<arr2.count {
            result[index] += arr2[index]
        }
        return result
    }

    // transfer binary number arr to an decimal numeration integer
    func numInArr(_ arr: [Int]) -> Int {
        var result: Int = 0
        for index in 0..<arr.count {
            result = result + arr[index] * Int(pow(2, Double(arr.count - index - 1)))
        }
        return result
    }

    // calculate dictionary decimal numeration integer
    func numInDic(_ dic: [[Int]]) -> Int {
        var result: Int = 0
        for index in 0..<dic.count {
            result += numInArr(dic[index])
        }
        return result
    }
}
