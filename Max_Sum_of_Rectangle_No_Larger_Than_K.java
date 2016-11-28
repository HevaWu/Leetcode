/*363. Max Sum of Rectangle No Larger Than K   QuestionEditorial Solution  My Submissions
Total Accepted: 7347 Total Submissions: 23587 Difficulty: Hard Contributors: Admin
Given a non-empty 2D matrix matrix and an integer k, find the max sum of a rectangle in the matrix such that its sum is no larger than k.

Example:
Given matrix = [
  [1,  0, 1],
  [0, -2, 3]
]
k = 2
The answer is 2. Because the sum of rectangle [[0, 1], [-2, 3]] is 2 and 2 is the max number no larger than k (k = 2).

Note:
The rectangle inside the matrix must have an area > 0.
What if the number of rows is much larger than the number of columns?
Credits:
Special thanks to @fujiaozhu for adding this problem and creating all test cases.

Subscribe to see which companies asked this question

Hide Tags Binary Search Dynamic Programming Queue
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
2D Kadane's algorithm + 1D maxSum problem with sum limit k
2D subarray sum solution

suppose rows larger than cols,
start from left to right,
	1. each time, record the current rowSum
	2. for each rowSum, find the max sum less than k
		through find the smallest num in the set, which is greater or equal to currSum-k, if it exist, ret = max(ret, currSum-num)
		each time, push currSum into TreeSet
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int maxSumSubmatrix(int[][] matrix, int k) {
        if(matrix==null || matrix.length==0 || matrix[0].length==0) return 0;

        int m = matrix.length;
        int n = matrix[0].length;

        int ret = countSum(matrix, k, m, n);

        return ret;
    }

    public int countSum(int[][] matrix, int k, int m, int n){
        int ret = Integer.MIN_VALUE; //init min value
        //outer loop should use smaller axis
        //now we assume we have more rows than cols, therefore outer loop will be based on cols
        for(int left = 0; left < n; ++left){
             //array that accumulate sums for each row from left to right
            int[] rowSum = new int[m];
            for(int right = left; right < n; ++right){
                //update sums[] to include values in curr right col
                for(int up = 0; up < m; ++up){
                    rowSum[up] += matrix[up][right];
                }

                //we use TreeSet to help us find the rectangle with maxSum <= k with O(logN) time
                TreeSet<Integer> myset = new TreeSet<>();
                int currSum = 0;
                myset.add(0); //add 0 to cover the single row case

                for(int r:rowSum){
                    currSum += r;
                    //we use sum subtraction (curSum - sum) to get the subarray with sum <= k
                    //therefore we need to look for the smallest num >= currSum - k
                    Integer num = myset.ceiling(currSum - k); //use Integer here
                    if(num!=null) ret = Math.max(ret, currSum-num);
                    myset.add(currSum); //add currSum
                }
            }
        }
        return ret;
    }
}
