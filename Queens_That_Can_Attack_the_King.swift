/*
On an 8x8 chessboard, there can be multiple Black Queens and one White King.

Given an array of integer coordinates queens that represents the positions of the Black Queens, and a pair of coordinates king that represent the position of the White King, return the coordinates of all the queens (in any order) that can attack the King.



Example 1:



Input: queens = [[0,1],[1,0],[4,0],[0,4],[3,3],[2,4]], king = [0,0]
Output: [[0,1],[1,0],[3,3]]
Explanation:
The queen at [0,1] can attack the king cause they're in the same row.
The queen at [1,0] can attack the king cause they're in the same column.
The queen at [3,3] can attack the king cause they're in the same diagnal.
The queen at [0,4] can't attack the king cause it's blocked by the queen at [0,1].
The queen at [4,0] can't attack the king cause it's blocked by the queen at [1,0].
The queen at [2,4] can't attack the king cause it's not in the same row/column/diagnal as the king.
Example 2:



Input: queens = [[0,0],[1,1],[2,2],[3,4],[3,5],[4,4],[4,5]], king = [3,3]
Output: [[2,2],[3,4],[4,4]]
Example 3:



Input: queens = [[5,6],[7,7],[2,1],[0,7],[1,6],[5,1],[3,7],[0,3],[4,0],[1,2],[6,3],[5,0],[0,4],[2,2],[1,1],[6,4],[5,4],[0,0],[2,6],[4,5],[5,2],[1,4],[7,5],[2,3],[0,5],[4,2],[1,0],[2,7],[0,1],[4,6],[6,1],[0,6],[4,3],[1,7]], king = [3,4]
Output: [[2,3],[1,4],[1,6],[3,7],[4,3],[5,4],[4,5]]


Constraints:

1 <= queens.length <= 63
queens[i].length == 2
0 <= queens[i][j] < 8
king.length == 2
0 <= king[0], king[1] < 8
At most one piece is allowed in a cell.

*/

/*
Solution 1:
hold 8 directional array
for each queen, check if it is in same row/column/diagnal,
and try to update correspond directional array if this queen is closer to King

Time Complexity: O(queen.count)
Space Complexity: O(8)
*/
class Solution {
    func queensAttacktheKing(_ queens: [[Int]], _ king: [Int]) -> [[Int]] {
        // left, right, up, down, upleft, upright, bottomleft, bottomright
        var res = Array(repeating: [Int](), count: 8)
        let kr = king[0]
        let kc = king[1]
        for q in queens {
            let qr = q[0]
            let qc = q[1]

            if qr == kr {
                // same row
                if qc < kc {
                    // left side
                    if res[0].isEmpty || qc > res[0][1] {
                        res[0] = [qr, qc]
                    }
                } else {
                    // right side
                    if res[1].isEmpty || qc < res[1][1] {
                        res[1] = [qr, qc]
                    }
                }
            } else if qc == kc {
                // same col
                if qr < kr {
                    // up side
                    if res[2].isEmpty || qr > res[2][0] {
                        res[2] = [qr, qc]
                    }
                } else {
                    if res[3].isEmpty || qr < res[3][0] {
                        res[3] = [qr, qc]
                    }
                }

            } else if abs(qr-kr) == abs(qc-kc) {
                // same diagnal
                if qr < kr, qc < kc {
                    // upleft
                    if res[4].isEmpty || abs(qr-kr) < abs(res[4][0]-kr) {
                        res[4] = [qr, qc]
                    }
                } else if qr > kr, qc < kc {
                    // upright
                    if res[5].isEmpty || abs(qr-kr) < abs(res[5][0]-kr) {
                        res[5] = [qr, qc]
                    }
                } else if qr < kr, qc > kc {
                    // bottomleft
                    if res[6].isEmpty || abs(qr-kr) < abs(res[6][0]-kr) {
                        res[6] = [qr, qc]
                    }
                } else if qr > kr, qc > kc {
                    // bottomright
                    if res[7].isEmpty || abs(qr-kr) < abs(res[7][0]-kr) {
                        res[7] = [qr, qc]
                    }
                }
            }
        }

        for i in stride(from: 7, through: 0, by: -1) {
            if res[i].isEmpty {
                res.remove(at: i)
            }
        }
        return res
    }
}