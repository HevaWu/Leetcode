/*120. Triangle
Description  Submission  Solutions  Add to List
Total Accepted: 94001
Total Submissions: 287650
Difficulty: Medium
Contributors: Admin
Given a triangle, find the minimum path sum from top to bottom. Each step you may move to adjacent numbers on the row below.

For example, given the following triangle
[
     [2],
    [3,4],
   [6,5,7],
  [4,1,8,3]
]
The minimum path sum from top to bottom is 11 (i.e., 2 + 3 + 5 + 1 = 11).

Note:
Bonus point if you are able to do this using only O(n) extra space, where n is the total number of rows in the triangle.

Hide Tags Array Dynamic Programming
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*Bottom-up DP
space O(n)
in k th row:
path[k][i] = min(path[k+1][i], path[k+1][i+1]) + triangle[k][i]
simply set the path as a 1D array, and each time iteratively update itself
path[i] = min(path[i], path[k+1]) + triangle[k][i]
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int minimumTotal(List<List<Integer>> triangle) {
        int len = triangle.get(triangle.size()-1).size();
        int[] path = new int[len+1];
        for(int i = triangle.size(); i > 0; --i) //row, for the last row, extend the row + 1, only need i . 0
            for(int j = 0; j < i; ++j){ //col, only need j < i is enough,
                path[j] = Math.min(path[j], path[j+1])+triangle.get(i-1).get(j);
            }
        }
        return path[0];
    }
}

