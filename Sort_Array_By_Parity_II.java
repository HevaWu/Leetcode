/*
Given an array of integers nums, half of the integers in nums are odd, and the other half are even.

Sort the array so that whenever nums[i] is odd, i is odd, and whenever nums[i] is even, i is even.

Return any answer array that satisfies this condition.



Example 1:

Input: nums = [4,2,5,7]
Output: [4,5,2,7]
Explanation: [4,7,2,5], [2,5,4,7], [2,7,4,5] would also have been accepted.
Example 2:

Input: nums = [2,3]
Output: [2,3]


Constraints:

2 <= nums.length <= 2 * 104
nums.length is even.
Half of the integers in nums are even.
0 <= nums[i] <= 1000


Follow Up: Could you solve it in-place?
*/

/*
Solution 2:
For each even i, let's make A[i] even. To do it, we will draft an element from the odd slice. We pass j through the odd slice until we find an even element, then swap. Our invariant is maintained, so the algorithm is correct.

Time Complexity: O(n)
Space Complexity: O(1)
 */
class Solution {
    public int[] sortArrayByParityII(int[] nums) {
        int n = nums.length;

        int j = 1;
        for (int i = 0; i < n; i += 2) {
            if (nums[i] % 2 == 1) {
                while (nums[j] % 2 == 1) {
                    j += 2;
                }

                int temp = nums[i];
                nums[i] = nums[j];
                nums[j] = temp;
            }
        }
        return nums;
    }
}

/*
Solution 1:
use even, odd stack to store current pending for shift index
- even stack: save pending for shift index of even number
- odd stack: save pending for shift index of odd number

Time Complexity: O(n)
Space Complexity: O(n/2)
*/
class Solution {
    public int[] sortArrayByParityII(int[] nums) {
        int n = nums.length;

        List<Integer> odd = new ArrayList<Integer>();
        List<Integer> even = new ArrayList<Integer>();

        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                if (nums[i] % 2 == 0) {
                    continue;
                } else {
                    if (odd.isEmpty()) {
                        even.add(i);
                    } else {
                        int j = odd.remove(0);
                        int temp = nums[i];
                        nums[i] = nums[j];
                        nums[j] = temp;
                    }
                }
            } else {
                if (nums[i] % 2 == 1) {
                    continue;
                } else {
                    if (even.isEmpty()) {
                        odd.add(i);
                    } else {
                        int j = even.remove(0);
                        int temp = nums[i];
                        nums[i] = nums[j];
                        nums[j] = temp;
                    }
                }
            }
        }

        return nums;
    }
}