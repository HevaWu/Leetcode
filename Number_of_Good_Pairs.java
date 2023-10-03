/*
Given an array of integers nums.

A pair (i,j) is called good if nums[i] == nums[j] and i < j.

Return the number of good pairs.



Example 1:

Input: nums = [1,2,3,1,1,3]
Output: 4
Explanation: There are 4 good pairs (0,3), (0,4), (3,4), (2,5) 0-indexed.
Example 2:

Input: nums = [1,1,1,1]
Output: 6
Explanation: Each pair in the array are good.
Example 3:

Input: nums = [1,2,3]
Output: 0


Constraints:

1 <= nums.length <= 100
1 <= nums[i] <= 100

*/

/*
Solution 1:
map

key is num, val is number of elements in nums which is == num
check (k,v), if v > 1, we can build pair, v*(v-1) / 2

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public int numIdenticalPairs(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> map = new HashMap<>();
        for (int num : nums) {
            map.put(num, map.getOrDefault(num, 0)+1);
        }

        int pair = 0;
        for (Map.Entry<Integer, Integer> entry: map.entrySet()) {
            int val = entry.getValue();
            if (val > 1) {
                pair += (val * (val-1)/2);
            }
        }
        return pair;
    }
}
