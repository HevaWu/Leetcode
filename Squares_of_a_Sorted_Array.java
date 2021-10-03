/*
Given an integer array nums sorted in non-decreasing order, return an array of the squares of each number sorted in non-decreasing order.



Example 1:

Input: nums = [-4,-1,0,3,10]
Output: [0,1,9,16,100]
Explanation: After squaring, the array becomes [16,1,0,9,100].
After sorting, it becomes [0,1,9,16,100].
Example 2:

Input: nums = [-7,-3,2,3,11]
Output: [4,9,9,49,121]


Constraints:

1 <= nums.length <= 104
-104 <= nums[i] <= 104
nums is sorted in non-decreasing order.


Follow up: Squaring each element and sorting the new array is very trivial, could you find an O(n) solution using a different approach?
*/

/*
Solution 1:
find the first positive index first: i
then according to it find the non-positive index: left

compare nums[left]*nums[left] and nums[right]*nums[right]
push the smaller one into res array

Time Complexity:
O(n)
*/
class Solution {
    public int[] sortedSquares(int[] nums) {
        int n = nums.length;

        int i = 0;
        while (i < n && nums[i] < 0) {
            i += 1;
        }

        List<Integer> res = new ArrayList<>();

        int left = i-1;
        int right = i;
        while (left >= 0 || right < n) {
            int pick = 0;
            if (left >= 0 && right < n) {
                if (Math.abs(nums[left]) < Math.abs(nums[right])) {
                    pick = nums[left] * nums[left];
                    left -= 1;
                } else {
                    pick = nums[right] * nums[right];
                    right += 1;
                }
            } else if (left >= 0) {
                pick = nums[left] * nums[left];
                left -= 1;
            } else {
                pick = nums[right] * nums[right];
                    right += 1;
            }

            res.add(pick);
        }

        return res.stream().mapToInt(Integer::intValue).toArray();
    }
}
