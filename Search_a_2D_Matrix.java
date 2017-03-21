/*74. Search a 2D Matrix   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 108912
Total Submissions: 306581
Difficulty: Medium
Contributors: Admin
Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:

Integers in each row are sorted from left to right.
The first integer of each row is greater than the last integer of the previous row.
For example,

Consider the following matrix:

[
  [1,   3,  5,  7],
  [10, 11, 16, 20],
  [23, 30, 34, 50]
]
Given target = 3, return true.

Hide Tags Array Binary Search
Hide Similar Problems (M) Search a 2D Matrix II
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*Binary Search
Solution 1 is faster than Solution 2

Solution 1:
time log(m)*log(n)
1. binary search each row, find the row this element should be in
	which means matrix[mid][0] <= target <= matrix[mid][n-1] (matrix[].length = n)
2. binary search current row, find if this element is exist in this row

Solution 2:
time log(mn)
1. change 2D to 1D, there is total m * n elements
2. binary search this 1D array, then change mid to 2D
	row = mid / n;
	col = mid % n;
	binary search until the end
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public boolean searchMatrix(int[][] matrix, int target) {
        if(matrix.length <= 0 || matrix[0].length <= 0) return false;

        int m = matrix.length;
        int n = matrix[0].length;
        int low = 0;
        int high = m;
        while(low <= high-1){ // remember <= and -1
            int mid = (low+high)/2;
            //System.out.println(low + " " + high);
            if(matrix[mid][0] > target){
                high = mid;
            } else { //matrix[mid][0] <= target
                //System.out.println("Do???");
                if(matrix[mid][n-1] < target){
                    low = mid + 1; // remember + 1
                } else { //matrix[mid][n-1] >= target, at this time, target should be at row mid, search this row
                    //System.out.println("DO this ? ");
                    int low2 = 0;
                    int high2 = n;
                    //System.out.println(low2 + " " + high2);
                    while(low2 <= high2-1){
                        int mid2 = (low2+high2)/2;
                        if(matrix[mid][mid2] < target){
                            low2 = mid2+1; //remember + 1
                        } else if(matrix[mid][mid2] > target){
                            high2 = mid2;
                        } else { //matrix[mid][mid2] == target
                            return true;
                        }
                    }
                    return false; //should be in this line, if not, break the loop and return false
                }
            }
        }
        return false;
    }
}


//Solution 2
public class Solution {
    public boolean searchMatrix(int[][] matrix, int target) {
        if(matrix.length <= 0 || matrix[0].length <= 0) return false;

        int m = matrix.length;
        int n = matrix[0].length;

        int low = 0;
        int high = m * n; //change 2D to 1D
        while(low <= high - 1){
            int mid = (low + high) / 2;
            //change 1D to 2D
            int row = mid / n;
            int col = mid % n;
            if(matrix[row][col] == target){
                return true;
            } else if(matrix[row][col] < target){
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return false;
    }
}

