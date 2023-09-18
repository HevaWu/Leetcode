/*
Given a m * n matrix mat of ones (representing soldiers) and zeros (representing
civilians), return the indexes of the k weakest rows in the matrix ordered from
the weakest to the strongest.

A row i is weaker than row j, if the number of soldiers in row i is less than
the number of soldiers in row j, or they have the same number of soldiers but i
is less than j. Soldiers are always stand in the frontier of a row, that is,
always ones may appear first and then zeros.



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
Solution 2:
iterate by column once find 0 in the mat, put current row into weakest rows

Time Complexity: O(mn)
Space Complexity: O(k + m)
*/
class Solution {
 public:
  vector<int> kWeakestRows(vector<vector<int>>& mat, int k) {
    vector<int> arr(k, 0);
    int index = 0;
    int m = mat.size();
    int n = mat[0].size();
    // record the rows which already put into weakest rows
    vector<int> visited(m, false);
    for (int j = 0; j < n; j++) {
      for (int i = 0; i < m; i++) {
        if (!visited[i] && mat[i][j] == 0) {
          visited[i] = true;
          arr[index] = i;
          index += 1;
          if (index == k) {
            return arr;
          }
        }
      }
    }
    // put all soldiers array into weakest rows
    for (int i = 0; i < m; i++) {
      if (!visited[i]) {
        arr[index] = i;
        index += 1;
        if (index == k) {
          break;
        }
      }
    }
    return arr;
  }
};
