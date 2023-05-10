/*
Given a positive integer n, generate an n x n matrix filled with elements from 1
to n2 in spiral order.



Example 1:


Input: n = 3
Output: [[1,2,3],[8,9,4],[7,6,5]]
Example 2:

Input: n = 1
Output: [[1]]


Constraints:

1 <= n <= 20
*/

/*
Solution 1:
build matrix element one by one
use dir to help define the direction of each element
0 right, 1 down, 2 left, 3 up

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
 public:
  vector<vector<int>> generateMatrix(int n) {
    int r1 = 0;
    int r2 = n - 1;
    int c1 = 0;
    int c2 = n - 1;
    int num = 1;
    vector<vector<int>> matrix(n, vector<int>(n));
    while (r1 <= r2 && c1 <= c2) {
      for (int j = c1; j <= c2; j++) {
        matrix[r1][j] = num;
        num += 1;
      }
      if (r1 < r2) {
        for (int i = r1 + 1; i <= r2; i++) {
          matrix[i][c2] = num;
          num += 1;
        }
      }
      if (r1 < r2 && c1 < c2) {
        for (int j = c2 - 1; j >= c1; j--) {
          matrix[r2][j] = num;
          num += 1;
        }
        for (int i = r2 - 1; i >= r1 + 1; i--) {
          matrix[i][c1] = num;
          num += 1;
        }
      }
      r1 += 1;
      r2 -= 1;
      c1 += 1;
      c2 -= 1;
    }
    return matrix;
  }
};
