/*
Given a sorted array, remove the duplicates in place such that each element appear only once and return the new length.

Do not allocate extra space for another array, you must do this in place with constant memory.

For example,
Given input array nums = [1,1,2],

Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively. It doesn't matter what you leave beyond the new length.
*/

class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        if(!nums.size() ) return nums.size();
        int nlen = 1;
        for(int i = 0; i < nums.size()-1; i++)
        {
            if(nums[i]!=nums[i+1]) 
            {
                nums[nlen++] = nums[i+1];
            }
        }
        return nlen;
    }
};