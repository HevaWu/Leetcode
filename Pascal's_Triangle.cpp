/*
Given numRows, generate the first numRows of Pascal's triangle.

For example, given numRows = 5,
Return

[
     [1],
    [1,1],
   [1,2,1],
  [1,3,3,1],
 [1,4,6,4,1]
]
*/

class Solution {
 public:
  vector<vector<int>> generate(int numRows) {
    vector<vector<int>> ntriangle(numRows);

    for (int i = 0; i < numRows; i++) {
      ntriangle[i].resize(i + 1);  // resize the i th element in the ntriangle
      ntriangle[i][0] = 1;
      ntriangle[i][i] = 1;
      for (int j = 1; j < i; j++) {
        ntriangle[i][j] = ntriangle[i - 1][j - 1] + ntriangle[i - 1][j];
      }
    }
    return ntriangle;
  }
};
