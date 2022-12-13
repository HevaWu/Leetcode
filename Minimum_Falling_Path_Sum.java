/*
Given an n x n array of integers matrix, return the minimum sum of any falling path through matrix.

A falling path starts at any element in the first row and chooses the element in the next row that is either directly below or diagonally left/right. Specifically, the next element from position (row, col) will be (row + 1, col - 1), (row + 1, col), or (row + 1, col + 1).



Example 1:


Input: matrix = [[2,1,3],[6,5,4],[7,8,9]]
Output: 13
Explanation: There are two falling paths with a minimum sum as shown.
Example 2:


Input: matrix = [[-19,57],[-40,-5]]
Output: -59
Explanation: The falling path with a minimum sum is shown.


Constraints:

n == matrix.length == matrix[i].length
1 <= n <= 100
-100 <= matrix[i][j] <= 100
*/

/*
Solution 1:
DP
check each row one by one
for each row checking , row[j] means current minimum falling path

Time Complexity: O(mn)
Space Complexity: O(n)
*/
class Solution {
    public int minFallingPathSum(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;

        int[] line = matrix[0];
        for(int i = 1; i < m; i++) {
            int[] temp = Arrays.copyOf(line, n);
            for(int j = 0; j < n; j++) {
                line[j] = matrix[i][j] + Math.min(
                    j-1 >= 0 ? temp[j-1] : 10000,
                    Math.min(temp[j], j+1 < n ? temp[j+1] : 10000)
                );
            }
        }

        int minSum = line[0];
        for(int j = 1; j < n; j++) {
            minSum = Math.min(minSum, line[j]);
        }
        return minSum;
    }
}
