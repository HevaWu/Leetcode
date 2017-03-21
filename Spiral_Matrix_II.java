/*59. Spiral Matrix II Add to List
Description  Submission  Solutions
Total Accepted: 74340
Total Submissions: 193550
Difficulty: Medium
Contributors: Admin
Given an integer n, generate a square matrix filled with elements from 1 to n2 in spiral order.

For example,
Given n = 3,

You should return the following matrix:
[
 [ 1, 2, 3 ],
 [ 8, 9, 4 ],
 [ 7, 6, 5 ]
]
Hide Tags Array
Hide Similar Problems (M) Spiral Matrix
 */






/*
(3 ms/ 21 test)
four index
int right = 0;
int down = 0;
int left = spiral[0].length-1;
int up = spiral.length-1;
use num to help count the number should be in spiral
int num = 1;
according to the order, right down left up
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int[][] generateMatrix(int n) {
        int[][] spiral = new int[n][n];
        if(n==0) return spiral;

        int num = 1;
        int right = 0;
        int down = 0;
        int left = spiral[0].length-1;
        int up = spiral.length-1;

        while(left>=right && up>=down){
            for(int i = right; i <= left; ++i){
                spiral[down][i] = num;
                num++;
            }
            down++;

            for(int i = down; i <= up; ++i){
                spiral[i][left] = num;
                num++;
            }
            left--;

            if(down<=up){
                for(int i = left; i >= right; --i){
                    spiral[up][i] = num;
                    num++;
                }
                up--;
            }

            if(right<=left){
                for(int i = up; i >= down; --i){
                    spiral[i][right] = num;
                    num++;
                }
                right++;
            }
        }
        return spiral;
    }
}
