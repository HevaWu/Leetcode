/*
Given an integer array nums and an integer k, return true if nums has a
continuous subarray of size at least two whose elements sum up to a multiple of
k, or false otherwise.

An integer x is a multiple of k if there exists an integer n such that x = n *
k. 0 is always a multiple of k.



Example 1:

Input: nums = [23,2,4,6,7], k = 6
Output: true
Explanation: [2, 4] is a continuous subarray of size 2 whose elements sum up
to 6. Example 2:

Input: nums = [23,2,6,4,7], k = 6
Output: true
Explanation: [23, 2, 6, 4, 7] is an continuous subarray of size 5 whose elements
sum up to 42. 42 is a multiple of 6 because 42 = 7 * 6 and 7 is an integer.
Example 3:

Input: nums = [23,2,6,4,7], k = 13
Output: false


Constraints:

1 <= nums.length <= 105
0 <= nums[i] <= 109
0 <= sum(nums[i]) <= 231 - 1
1 <= k <= 231 - 1
*/

/*
Solution 2:
check sum and remainder

(a+(n*x))%x is same as (a%x)

For e.g. in case of the array [23,2,6,4,7] the running sum is [23,25,31,35,42]
and the remainders are [5,1,1,5,0]. We got remainder 5 at index 0 and at
index 3. That means, in between these two indexes we must have added a number
which is multiple of the k.

Time Complexity: O(n)
Space Complexity: O(k)
*/
class Solution {
 public:
  bool checkSubarraySum(vector<int>& nums, int k) {
    unordered_map<int, int> remainder;
    remainder[0] = -1;

    int sum = 0;
    for (int i = 0; i < nums.size(); i++) {
      sum = (sum + nums[i]) % k;
      if (remainder.count(sum)) {
        if (i - remainder[sum] > 1) {
          return true;
        }
      } else {
        remainder[sum] = i;
      }
    }
    return false;
  }
};
