/*
283. Move Zeroes Add to List
Description  Submission  Solutions
Total Accepted: 161781
Total Submissions: 334288
Difficulty: Easy
Contributors: Admin
Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.

For example, given nums = [0, 1, 0, 3, 12], after calling your function, nums should be [1, 3, 12, 0, 0].

Note:
You must do this in-place without making a copy of the array.
Minimize the total number of operations.
Credits:
Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

Hide Company Tags Bloomberg Facebook
Hide Tags Array Two Pointers
Hide Similar Problems (E) Remove Element
*/




////////////////////////////////////////////////////////////////////////////////////////////////
///C++
class Solution {
public:
    void moveZeroes(vector<int>& nums) {
        int j = 0;
        for(int i = 0; i < nums.size(); i++){
            if(nums[i] != 0)
                nums[j++] = nums[i];
        }
        for(;j < nums.size(); j++)
            nums[j]=0;
    }
};





/*
use two pointers
i --- point to the original nums
j --- point to the un-zero nums
 */

////////////////////////////////////////////////////////////////////////////////////////////////
///Java
public class Solution {
    public void moveZeroes(int[] nums) {
        if(nums.length == 0) return;
        int j = 0;
        for(int i = 0; i < nums.length; ++i){
            if(nums[i] != 0){
                nums[j++] = nums[i];
            }
        }

        //set the end of array as zero
        while(j < nums.length){
            nums[j++] = 0;
        }
    }
}
