/*73. Set Matrix Zeroes   QuestionEditorial Solution  My Submissions
Total Accepted: 84070
Total Submissions: 241033
Difficulty: Medium
Contributors: Admin
Given a m x n matrix, if an element is 0, set its entire row and column to 0. Do it in place.

click to show follow up.

Follow up:
Did you use extra space?
A straight forward solution using O(mn) space is probably a bad idea.
A simple improvement uses O(m + n) space, but still not the best solution.
Could you devise a constant space solution?

Subscribe to see which companies asked this question

Hide Tags Array
Hide Similar Problems (M) Game of Life
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*O(1) space
if there is a node is 0; set its corresponding (i,0)(0,j) as 0
use col to record if the (i,0) is already 0*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public void setZeroes(int[][] matrix) {
        if(matrix==null || matrix.length==0 || matrix[0].length==0) return ;

        int m = matrix.length;
        int n = matrix[0].length;
        int col = 1; //record if there is element in (i,0) is 0
        for(int i = 0; i < m; ++i){
            if(matrix[i][0]==0) col = 0;
            for(int j = 1; j < n; ++j){
                if(matrix[i][j]==0){
                    //find the element is 0, mark it position
                    matrix[i][0] = 0;
                    matrix[0][j] = 0;
                }
            }
        }

        //change the matrix cols and rows one time
        for(int i = m-1; i >= 0; --i){ //change from the end of the matrix
            for(int j = n-1; j >= 1; --j){// end at 1, we will check this at the end
                if(matrix[i][0]==0 || matrix[0][j]==0){
                    matrix[i][j] = 0;
                }
            }
            if(col==0){ //check the first col
                matrix[i][0] = 0;
            }
        }
    }
}
