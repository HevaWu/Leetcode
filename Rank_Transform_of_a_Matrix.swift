/*
Given an m x n matrix, return a new matrix answer where answer[row][col] is the rank of matrix[row][col].

The rank is an integer that represents how large an element is compared to other elements. It is calculated using the following rules:

The rank is an integer starting from 1.
If two elements p and q are in the same row or column, then:
If p < q then rank(p) < rank(q)
If p == q then rank(p) == rank(q)
If p > q then rank(p) > rank(q)
The rank should be as small as possible.
It is guaranteed that answer is unique under the given rules.



Example 1:


Input: matrix = [[1,2],[3,4]]
Output: [[1,2],[2,3]]
Explanation:
The rank of matrix[0][0] is 1 because it is the smallest integer in its row and column.
The rank of matrix[0][1] is 2 because matrix[0][1] > matrix[0][0] and matrix[0][0] is rank 1.
The rank of matrix[1][0] is 2 because matrix[1][0] > matrix[0][0] and matrix[0][0] is rank 1.
The rank of matrix[1][1] is 3 because matrix[1][1] > matrix[0][1], matrix[1][1] > matrix[1][0], and both matrix[0][1] and matrix[1][0] are rank 2.
Example 2:


Input: matrix = [[7,7],[7,7]]
Output: [[1,1],[1,1]]
Example 3:


Input: matrix = [[20,-21,14],[-19,4,19],[22,-47,24],[-19,4,19]]
Output: [[4,2,3],[1,3,4],[5,1,6],[1,3,4]]
Example 4:


Input: matrix = [[7,3,6],[1,4,5],[9,8,2]]
Output: [[5,1,4],[1,2,3],[6,3,1]]


Constraints:

m == matrix.length
n == matrix[i].length
1 <= m, n <= 500
-109 <= matrix[row][col] <= 109

*/

/*
Solution 1:
Sort the cells by value and process them in increasing order.

apply union find by row and col,
find the maximum rank of elements sharing the same row or col.
Then we update the the rank.

Time Complexity: O(NNlog(MN))
- (Time O(mn*(m +n)) actually for using a deep copy, but this can be optimised by using hashmap)
Space Complexity: O(MN)
*/
class Solution {
    func matrixRankTransform(_ matrix: [[Int]]) -> [[Int]] {
        let m = matrix.count
        let n = matrix[0].count

        var map = [Int: [(r: Int, c: Int)]]()
        for i in 0..<m {
            for j in 0..<n {
                map[matrix[i][j], default: [(r: Int, c: Int)]()].append((i, j))
            }
        }

        // sort element
        var sortedKey = map.keys.sorted()

        var uf = UF(m+n)
        var rank = Array(repeating: 0, count: m+n)
        var matrix = matrix

        for k in sortedKey {
            guard let list = map[k] else { continue }

            var uf = UF(m+n)
            var temp = rank

            for (r, c) in list {
                var (ur, uc) = uf.union(r, c+m)
                // find uc one
                temp[uc] = max(temp[uc], temp[ur])
            }

            for (r, c) in list {
                let val = temp[uf.find(r)] + 1
                rank[r] = val
                rank[c + m] = val
                matrix[r][c] = val
            }
        }

        return matrix
    }
}

class UF {
    var parent: [Int]
    init(_ n: Int) {
        parent = Array(0..<n)
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func union(_ x: Int, _ y: Int) -> (r: Int, c: Int) {
        let px = find(x)
        let py = find(y)
        if px != py {
            parent[px] = py
        }
        return (px, py)
    }
}