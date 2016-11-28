/*308. Range Sum Query 2D - Mutable  QuestionEditorial Solution  My Submissions
Total Accepted: 6744
Total Submissions: 32753
Difficulty: Hard
Given a 2D matrix matrix, find the sum of the elements inside the rectangle defined by its upper left corner (row1, col1) and lower right corner (row2, col2).

Range Sum Query 2D
The above rectangle (with the red border) is defined by (row1, col1) = (2, 1) and (row2, col2) = (4, 3), which contains sum = 8.

Example:
Given matrix = [
  [3, 0, 1, 4, 2],
  [5, 6, 3, 2, 1],
  [1, 2, 0, 1, 5],
  [4, 1, 0, 1, 7],
  [1, 0, 3, 0, 5]
]

sumRegion(2, 1, 4, 3) -> 8
update(3, 2, 2)
sumRegion(2, 1, 4, 3) -> 10
Note:
The matrix is only modifiable by the update function.
You may assume the number of calls to update and sumRegion function is distributed evenly.
You may assume that row1 ≤ row2 and col1 ≤ col2.
Hide Company Tags Google
Hide Tags Binary Indexed Tree Segment Tree
Hide Similar Problems (M) Range Sum Query 2D - Immutable (M) Range Sum Query - Mutable
*/



/* n is the size of matrix, m is the size of matrix[0]
time complexity: update: O(n)
				 sumRegion: O(m)
use another matrix to record the sums of column
when count sumRegion just derectly "-" the former sum
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class NumMatrix {
    private:
    vector<vector<int> > matrix;
    vector<vector<int> > sumCol;
    
public:
    NumMatrix(vector<vector<int>> &matrix) {
        if(matrix.size()==0 || matrix[0].size()==0) return;
        
        this->matrix = matrix;
        
        int n = matrix.size();
        int m = matrix[0].size();
        sumCol = vector<vector<int>>(n+1, vector<int>(m,0));
        
        for(int i = 1; i <= n; ++i){
            for(int j = 0; j < m; ++j){
                sumCol[i][j] = sumCol[i-1][j] + matrix[i-1][j]; //remember i-1
            }
        }
        
    }

    void update(int row, int col, int val) {
        for(int i = row+1; i < sumCol.size(); ++i){  //remember start from row+1
            sumCol[i][col] = sumCol[i][col] - matrix[row][col] + val;
        }
        
        matrix[row][col] = val;
    }

    int sumRegion(int row1, int col1, int row2, int col2) {
        int ret = 0;
        
        for(int i = col1; i <= col2; ++i){
            ret += sumCol[row2+1][i] - sumCol[row1][i];  //remember +1
        }
        
        return ret;
    }
};


// Your NumMatrix object will be instantiated and called as such:
// NumMatrix numMatrix(matrix);
// numMatrix.sumRegion(0, 1, 2, 3);
// numMatrix.update(1, 1, 10);
// numMatrix.sumRegion(1, 2, 3, 4);




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class NumMatrix {
    int[][] matrix;
    int[][] sumCol;
    

    public NumMatrix(int[][] matrix) {
        if(matrix==null || matrix.length==0 || matrix[0].length==0) return;
        
        this.matrix = matrix;//remember pass the matrix value
        
        int n = matrix.length;
        int m = matrix[0].length;
        sumCol = new int[n+1][m];
        for(int i = 1; i <= n; ++i){
            for(int j = 0; j < m; ++j){
                sumCol[i][j] = sumCol[i-1][j] + matrix[i-1][j];
            }
        }
    }

    public void update(int row, int col, int val) {
        for(int i = row+1; i < sumCol.length; ++i){ //row +1
            sumCol[i][col] += val - matrix[row][col];
        }
        
        matrix[row][col] = val;
    }

    public int sumRegion(int row1, int col1, int row2, int col2) {
        int ret = 0;
        
        for(int i = col1; i <= col2; ++i){
            ret += sumCol[row2+1][i] - sumCol[row1][i];
        }
        
        return ret;
    }
}


// Your NumMatrix object will be instantiated and called as such:
// NumMatrix numMatrix = new NumMatrix(matrix);
// numMatrix.sumRegion(0, 1, 2, 3);
// numMatrix.update(1, 1, 10);
// numMatrix.sumRegion(1, 2, 3, 4);
