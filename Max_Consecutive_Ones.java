/*485. Max Consecutive Ones Add to List
Description  Submission  Solutions
Total Accepted: 20519
Total Submissions: 37221
Difficulty: Easy
Contributors: Stomach_ache
Given a binary array, find the maximum number of consecutive 1s in this array.

Example 1:
Input: [1,1,0,1,1,1]
Output: 3
Explanation: The first two digits or the last three digits are consecutive 1s.
    The maximum number of consecutive 1s is 3.
Note:

The input array will only contain 0 and 1.
The length of input array is a positive integer and will not exceed 10,000
Hide Company Tags Google
Hide Tags Array
Hide Similar Problems (M) Max Consecutive Ones II
*/






/*
O(n)
once we check current num is 1, add it to current "temp", and compare it with the maximum "count"
at the end return count
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int findMaxConsecutiveOnes(int[] nums) {
        if(nums.length == 0) return 0;
        int count = 0; //the maximum consecutive ones
        int temp = 0; //help checking current consecutive ones
        for(int num: nums){
            count = Math.max(count, temp = num==1 ? ++temp : 0); //use ++temp
        }
        return count; //check current temp and the count, find the max one
    }
}
