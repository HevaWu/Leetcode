/*
The n-queens puzzle is the problem of placing n queens on an n x n chessboard such that no two queens attack each other.

Given an integer n, return the number of distinct solutions to the n-queens puzzle.



Example 1:


Input: n = 4
Output: 2
Explanation: There are two distinct solutions to the 4-queens puzzle as shown.
Example 2:

Input: n = 1
Output: 1


Constraints:

1 <= n <= 9
*/

/*
Solution 2:
Optimize solution 1 by moving count out of for loop
*/
class Solution {
    int n = 0;
    int res = 0;
    Set<Integer> visitedC = new HashSet<>();
    Set<Integer> visitedHill = new HashSet<>();
    Set<Integer> visitedDale = new HashSet<>();

    public int totalNQueens(int n) {
        this.n = n;
        check(0);
        return res;
    }

    public void check(int row) {
        if (row == this.n) {
            this.res += 1;
            return;
        }

        for(int col = 0; col < n; col++) {
            if (this.visitedC.contains(col)) { continue; }
            int dale = row-col;
            if (this.visitedDale.contains(dale)) { continue; }
            int hill = col+row;
            if (this.visitedHill.contains(hill)) { continue; }

            this.visitedC.add(col);
            this.visitedDale.add(dale);
            this.visitedHill.add(hill);

            check(row+1);

            this.visitedC.remove(col);
            this.visitedDale.remove(dale);
            this.visitedHill.remove(hill);
        }
    }
}