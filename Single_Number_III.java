/*
Given an integer array nums, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once. You can return the answer in any order.

You must write an algorithm that runs in linear runtime complexity and uses only constant extra space.



Example 1:

Input: nums = [1,2,1,3,2,5]
Output: [3,5]
Explanation:  [5, 3] is also a valid answer.
Example 2:

Input: nums = [-1,0]
Output: [-1,0]
Example 3:

Input: nums = [0,1]
Output: [1,0]


Constraints:

2 <= nums.length <= 3 * 104
-231 <= nums[i] <= 231 - 1
Each integer in nums will appear twice, only two integers will appear once.
*/

/*linear runtime compexity O(n)
constant extra space complexity O(1)
1. using XOR operation, get the result of two elements XOR, there must be a bit'1' in the XOR result, find any set bit, eg. choose the rightmost set bit
2. divide into two groups, one has this bit set, one did not have, using XOR in each group,
we can find two elements*/
public class Solution {
    public int[] singleNumber(int[] nums) {
        int[] ret = new int[2];
        int diffBit = 0;
        for(int n:nums){
            diffBit ^= n;
        }

        diffBit &= ~(diffBit-1);

        for(int n:nums){
            if((diffBit&n)==0) ret[0] ^= n;
            else ret[1] ^= n;
        }

        return ret;
    }
}