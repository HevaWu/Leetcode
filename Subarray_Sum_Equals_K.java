/*
Given an array of integers nums and an integer k, return the total number of continuous subarrays whose sum equals to k.



Example 1:

Input: nums = [1,1,1], k = 2
Output: 2
Example 2:

Input: nums = [1,2,3], k = 3
Output: 2


Constraints:

1 <= nums.length <= 2 * 104
-1000 <= nums[i] <= 1000
-107 <= k <= 107

*/

/*
Solution 2:
map, store [sum-k: count]

[sum_i, number of occurrences of sum_i]

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public int subarraySum(int[] nums, int k) {
        int n = nums.length;
        // [sum-k: count]
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, 1);
        int sum = 0;
        int count = 0;
        for(int i = 0; i < n; i++) {
            sum += nums[i];
            if (map.containsKey(sum-k)) {
               count += map.get(sum-k);
            }
            map.put(sum, map.getOrDefault(sum, 0) + 1);
        }
        return count;
    }
}