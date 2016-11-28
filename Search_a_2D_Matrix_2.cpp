/*240. Search a 2D Matrix II   QuestionEditorial Solution  My Submissions
Total Accepted: 52803 Total Submissions: 142942 Difficulty: Medium Contributors: Admin
Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:

Integers in each row are sorted in ascending from left to right.
Integers in each column are sorted in ascending from top to bottom.
For example,

Consider the following matrix:

[
  [1,   4,  7, 11, 15],
  [2,   5,  8, 12, 19],
  [3,   6,  9, 16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]
Given target = 5, return true.

Given target = 20, return false.

Hide Company Tags Amazon Google Apple
Hide Tags Binary Search Divide and Conquer
Hide Similar Problems (M) Search a 2D Matrix
*/



/*O(m+n) time
 rule out one row or one column each time
start from the top right corner,
if the target is greater than the value in current position, it cannot be in this row, row++
if the target is less than the value in current position, 
	the target cannot in the entire column, col--*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    bool searchMatrix(vector<vector<int>>& matrix, int target) {
        if(matrix.size()==0 || matrix[0].size()==0) return false;
        
        int row = 0;
        int col = matrix[0].size()-1; 
        while(col>=0 && row<matrix.size()){
            if(target==matrix[row][col]){
                return true;
            } else if(target > matrix[row][col]){
                row++;
            } else if (target < matrix[row][col]){
                col--;
            }
        }
        return false;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean searchMatrix(int[][] matrix, int target) {
        if(matrix==null || matrix.length==0 || matrix[0].length<1) return false;
        
        //start from the top right of the matrix
        int row = 0;
        int col = matrix[0].length-1;
        while(col>=0 && row<matrix.length){
            if(target == matrix[row][col]){
                return true; //find the target
            } else if(target > matrix[row][col]){
                row++; //this row cannot have target value, since sorted
            } else if(target < matrix[row][col]){
                col--; //this col cannot have target value, since sorted
            }
        }
        return false; //if cannot find target in the matrix
    }
}
