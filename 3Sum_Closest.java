/*16. 3Sum Closest Add to List
Description  Submission  Solutions
Total Accepted: 116293
Total Submissions: 379047
Difficulty: Medium
Contributors: Admin
Given an array S of n integers, find three integers in S such that the sum is closest to a given number, target. Return the sum of the three integers. You may assume that each input would have exactly one solution.

    For example, given array S = {-1 2 1 -4}, and target = 1.

    The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
Hide Company Tags Bloomberg
Hide Tags Array Two Pointers
Hide Similar Problems (M) 3Sum (M) 3Sum Smaller
 */






/*
1. sort array
2. 3 sum to solve question
    each time check if current sum is closer than closeSum
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int threeSumClosest(int[] nums, int target) {
        if(nums==null || nums.length==0) return 0;
        Arrays.sort(nums);
        int closeSum = nums[0] + nums[1] + nums[2];
        for(int i = 0; i < nums.length-2; ++i){
            int low = i+1;
            int high = nums.length-1;
            while(low < high){
                int sum = nums[i] + nums[low] + nums[high];
                if(sum > target){
                    high--;
                } else {
                    low++;
                }
                if(Math.abs(sum-target) < Math.abs(closeSum-target)) closeSum = sum;
            }
        }
        return closeSum;
    }
}
