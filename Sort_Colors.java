/*
Given an array nums with n objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue.

We will use the integers 0, 1, and 2 to represent the color red, white, and blue, respectively.



Example 1:

Input: nums = [2,0,2,1,1,0]
Output: [0,0,1,1,2,2]
Example 2:

Input: nums = [2,0,1]
Output: [0,1,2]
Example 3:

Input: nums = [0]
Output: [0]
Example 4:

Input: nums = [1]
Output: [1]


Constraints:

n == nums.length
1 <= n <= 300
nums[i] is 0, 1, or 2.


Follow up:

Could you solve this problem without using the library's sort function?
Could you come up with a one-pass algorithm using only O(1) constant space?
*/

/*
Solution 2
one pass

use index to control current checked element
left record 0
right record 2

Time Complexity: O(n)
Space Complexity: O(1)
*/


class Solution {
    public void sortColors(int[] nums) {
        int left = 0;
        int right = nums.length - 1;
        int index = 0;

        while (index <= right) {
            if (nums[index] == 0 && index > left) {
                int temp = nums[index];
                nums[index] = nums[left];
                nums[left] = temp;
                left += 1;
            } else if (nums[index] == 2 && index < right) {
                int temp = nums[index];
                nums[index] = nums[right];
                nums[right] = temp;
                right -= 1;
            } else {
                index += 1;
            }
        }
    }
}


public class Solution {
    public void sortColors(int[] nums) {
        int start = 0, end = nums.length-1;
        for(int i = 0; i <= end; i++){
            while(nums[i]==2 && i<end){
                int temp = nums[i];
                nums[i] = nums[end];
                nums[end] = temp;
                end--;
            }
            while(nums[i]==0 && i>start) {
                int temp = nums[i];
                nums[i] = nums[start];
                nums[start] = temp;
                start++;
            }
        }
    }

}