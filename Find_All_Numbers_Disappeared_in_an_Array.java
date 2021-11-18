/*
Given an array nums of n integers where nums[i] is in the range [1, n], return an array of all the integers in the range [1, n] that do not appear in nums.



Example 1:

Input: nums = [4,3,2,7,8,2,3,1]
Output: [5,6]
Example 2:

Input: nums = [1,1]
Output: [2]


Constraints:

n == nums.length
1 <= n <= 105
1 <= nums[i] <= n


Follow up: Could you do it without extra space and in O(n) runtime? You may assume the returned list does not count as extra space.
*/

/*
Soluton 1:
nums[i] is in 1...n
we can use nums[i] as index
1. go through nums, if index nums[i] appeared, convert nums[i] as -nums[i]
2. go through nums again, if nums[i] > 0, append i into res

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    public List<Integer> findDisappearedNumbers(int[] nums) {
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            int index = Math.abs(nums[i])-1;
            nums[index] = -Math.abs(nums[index]);
        }

        List<Integer> res = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (nums[i] > 0) {
                res.add(i+1);
            }
        }
        return res;
    }
}