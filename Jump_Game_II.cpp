/*
Given an array of non-negative integers nums, you are initially positioned at
the first index of the array.

Each element in the array represents your maximum jump length at that position.

Your goal is to reach the last index in the minimum number of jumps.

You can assume that you can always reach the last index.



Example 1:

Input: nums = [2,3,1,1,4]
Output: 2
Explanation: The minimum number of jumps to reach the last index is 2. Jump 1
step from index 0 to 1, then 3 steps to the last index. Example 2:

Input: nums = [2,3,0,1,4]
Output: 2


Constraints:

1 <= nums.length <= 1000
0 <= nums[i] <= 105
*/

/*
Solution 2:
greedy

memo farthest point we can jump
use curJump to help checking if we can increase jumps

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
 public:
  int jump(vector<int>& nums) {
    int curJump = 0;
    int far = 0;
    int jumps = 0;
    int n = nums.size();
    // NOTE: n-1 here to not count n-1 jump into final
    for (int i = 0; i < n - 1; i++) {
      far = max(far, i + nums[i]);
      if (curJump == i) {
        jumps += 1;
        curJump = far;
      }
    }
    return jumps;
  }
};
