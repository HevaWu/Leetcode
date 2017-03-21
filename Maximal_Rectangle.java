/*85. Maximal Rectangle   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 57045
Total Submissions: 218464
Difficulty: Hard
Contributors: Admin
Given a 2D binary matrix filled with 0's and 1's, find the largest rectangle containing only 1's and return its area.

For example, given the following matrix:

1 0 1 0 0
1 0 1 1 1
1 1 1 1 1
1 0 0 1 0
Return 6.
Hide Company Tags Facebook
Hide Tags Array Hash Table Stack Dynamic Programming
Hide Similar Problems (H) Largest Rectangle in Histogram (M) Maximal Square
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*Dynamic Programming
O(n^2) time
use 3 variables, left(i,j), right(i,j), height(i,j)
left(i,j) = max(left(i-1,j), cur_left), cur_left can be determined from the current row
right(i,j) = min(right(i-1,j), cur_right), cur_right can be determined from the current row
height(i,j) = height(i-1,j) + 1, if matrix[i][j]=='1';
height(i,j) = 0, if matrix[i][j]=='0'
at the end, compute the area of current position*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int maximalRectangle(char[][] matrix) {
        if(matrix.length==0 || matrix[0].length==0) return 0;
        int m = matrix.length;
        int n = matrix[0].length;
        int[] left = new int[n];  //init 0
        int[] right = new int[n];
        int[] height = new int[n]; //init 0

        for(int j = 0; j < n; ++j){ //init n
            right[j] = n;
        }

        int area = 0; //return area

        for(int i = 0; i < m; ++i){
            int curLeft = 0;
            int curRight = n;

            for(int j = 0; j < n; ++j){
                if(matrix[i][j] == '1'){
                    height[j]++;  //check height
                    left[j] = Math.max(curLeft, left[j]); //check left
                } else {
                    height[j] = 0;
                    left[j] = 0;
                    curLeft = j+1; //update curLeft as j + 1
                }
            }

            for(int j = n-1; j >= 0; --j){
                if(matrix[i][j] == '1'){ //check right
                    right[j] = Math.min(curRight, right[j]);
                } else {
                    right[j] = n;
                    curRight = j;
                }
            }

            for(int j = 0; j < n; ++j){ //get the max rectangle Area
                area = Math.max(area, (right[j]-left[j])*height[j]);
            }
        }

        return area;
    }
}

