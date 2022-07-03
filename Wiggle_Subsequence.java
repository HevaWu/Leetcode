/*
Given an integer array nums, return the length of the longest wiggle sequence.

A wiggle sequence is a sequence where the differences between successive numbers strictly alternate between positive and negative. The first difference (if one exists) may be either positive or negative. A sequence with fewer than two elements is trivially a wiggle sequence.

For example, [1, 7, 4, 9, 2, 5] is a wiggle sequence because the differences (6, -3, 5, -7, 3) are alternately positive and negative.
In contrast, [1, 4, 7, 2, 5] and [1, 7, 4, 5, 5] are not wiggle sequences, the first because its first two differences are positive and the second because its last difference is zero.
A subsequence is obtained by deleting some elements (eventually, also zero) from the original sequence, leaving the remaining elements in their original order.



Example 1:

Input: nums = [1,7,4,9,2,5]
Output: 6
Explanation: The entire sequence is a wiggle sequence.
Example 2:

Input: nums = [1,17,5,10,13,15,10,5,16,8]
Output: 7
Explanation: There are several subsequences that achieve this length. One is [1,17,10,13,10,16,8].
Example 3:

Input: nums = [1,2,3,4,5,6,7,8,9]
Output: 2


Constraints:

1 <= nums.length <= 1000
0 <= nums[i] <= 1000


Follow up: Could you solve this in O(n) time?
*/


/*
mark a variable larger to check if the next element should larger than current element
1,7,8,4,5,2
1, larger mark: true, 7  list:1,7
7, larger mark: false, 8 list: 1,8   change the list
8, larger mark: false, 4 list:1,8,4
to each element, check if this element is satisfy larger mark, if it is, push into the list
else, update the last element in the list
we can directly update the original nums array
*/
public class Solution {
    public int wiggleMaxLength(int[] nums) {
        if(nums.length==0 || nums.length==1) return nums.length;

        int k = 1;//check if the first element is equal to the next one
        while(k<nums.length-1 && nums[k]==nums[k-1]){
            k++;
        }

        if(k == nums.length-1) return 1;

        int ret = 2;
        boolean larger = nums[k]>nums[k-1];
        for(int i = k+1; i < nums.length; ++i){
            if(larger && nums[i]<nums[i-1]){
                nums[ret] = nums[i];
                ret++;
                larger = !larger;
            } else if(!larger && nums[i]>nums[i-1]){
                nums[ret] = nums[i];
                ret++;
                larger = !larger;
            } else {
                nums[ret-1] = nums[i];
            }
        }

        // for(int i = 0; i < ret; ++i){
        //     System.out.print(nums[i] + " ");
        // }

        return ret;
    }
}
