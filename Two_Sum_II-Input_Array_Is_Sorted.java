/*
Given an array of integers that is already sorted in ascending order, find two numbers such that they add up to a specific target number.

The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2.

Note:

Your returned answers (both index1 and index2) are not zero-based.
You may assume that each input would have exactly one solution and you may not use the same element twice.


Example 1:

Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore index1 = 1, index2 = 2.
Example 2:

Input: numbers = [2,3,4], target = 6
Output: [1,3]
Example 3:

Input: numbers = [-1,0], target = -1
Output: [1,2]


Constraints:

2 <= nums.length <= 3 * 104
-1000 <= nums[i] <= 1000
nums is sorted in increasing order.
-1000 <= target <= 1000
*/

/*
Solution 1:
Binary Search

since it is already sorted, we use two pointers
 one at start, and another one start from the end
 each time move two pointers
 if larger than target, move the back pointer
 if less than target, move the forward poitner

Time Complexity: O(logn)
Space Complexity: O(1)
*/
public class Solution {
    public int[] twoSum(int[] numbers, int target) {
        int left = 0;
        int right = numbers.length - 1;

        while(left <= right){
            int sum = numbers[left] + numbers[right];
            if(sum > target){
                //move the right pointer to make sum smaller
                right--;
            } else if (sum < target){
                left++;
            } else {
                //sum == target
                break;
            }
        }
        return new int[]{left+1, right+1};
    }
}
