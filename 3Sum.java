/*15. 3Sum Add to List
Description  Submission  Solutions
Total Accepted: 191061
Total Submissions: 898348
Difficulty: Medium
Contributors: Admin
Given an array S of n integers, are there elements a, b, c in S such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.

Note: The solution set must not contain duplicate triplets.

For example, given array S = [-1, 0, 1, 2, -1, -4],

A solution set is:
[
  [-1, 0, 1],
  [-1, -1, 2]
]
Hide Company Tags Amazon Microsoft Bloomberg Facebook Adobe Works Applications
Hide Tags Array Two Pointers
Hide Similar Problems (E) Two Sum (M) 3Sum Closest (M) 4Sum (M) 3Sum Smaller
 */






/*
1. sort array
2. 2 sum problem
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> mylist = new ArrayList<>();
        if(nums==null || nums.length==0) return mylist;

        Arrays.sort(nums);
        for(int i = 0; i < nums.length-1; ++i){
            if(i>0 && nums[i]==nums[i-1]) continue;
            //two sum problem
            int low = i+1, high = nums.length-1, sum = 0-nums[i];
            while(low < high){
                if(nums[low] + nums[high] == sum){
                    mylist.add(Arrays.asList(nums[i], nums[low], nums[high]));
                    while(low < high && nums[low] == nums[low+1]) low++;
                    while(low < high && nums[high] == nums[high-1]) high--;
                    low++;
                    high--;
                } else if(nums[low] + nums[high] < sum){
                    low++;
                } else {
                    high--;
                }
            }
        }
        return mylist;
    }
}
