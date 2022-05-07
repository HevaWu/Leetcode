/*
Given an array of n integers nums, a 132 pattern is a subsequence of three integers nums[i], nums[j] and nums[k] such that i < j < k and nums[i] < nums[k] < nums[j].

Return true if there is a 132 pattern in nums, otherwise, return false.



Example 1:

Input: nums = [1,2,3,4]
Output: false
Explanation: There is no 132 pattern in the sequence.
Example 2:

Input: nums = [3,1,4,2]
Output: true
Explanation: There is a 132 pattern in the sequence: [1, 4, 2].
Example 3:

Input: nums = [-1,3,2,0]
Output: true
Explanation: There are three 132 patterns in the sequence: [-1, 3, 2], [-1, 3, 0] and [-1, 2, 0].


Constraints:

n == nums.length
1 <= n <= 2 * 105
-109 <= nums[i] <= 109
*/

/*
Solution 1:
Stack

from end to begin,
use stack to keep recording current largest and smallest element
then see if current element is smallest one or not

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public boolean find132pattern(int[] nums) {
        int n = nums.length;
        if (n < 3) { return false; }

        int k = Integer.MIN_VALUE;
        Stack<Integer> s = new Stack<>();

        for (int i = n-1; i >= 0; i--) {
            if (nums[i] < k) { return true; }
            while (s.size() > 0 && s.peek() < nums[i]) {
                k = s.pop();
            }
            s.push(nums[i]);
        }
        return false;
    }
}