/*
Given an array A of non-negative integers, return an array consisting of all the even elements of A, followed by all the odd elements of A.

You may return any answer array that satisfies this condition.



Example 1:

Input: [3,1,2,4]
Output: [2,4,3,1]
The outputs [4,2,3,1], [2,4,1,3], and [4,2,1,3] would also be accepted.


Note:

1 <= A.length <= 5000
0 <= A[i] <= 5000
*/

/*
Solution 1
2 pointer

make sure even < odd
if find an odd number at res[even], swap(odd, even)

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public int[] sortArrayByParity(int[] nums) {
        int odd = nums.length - 1;
        int even = 0;
        while (even < odd) {
            while (even < odd && nums[even] % 2 == 0) {
                even += 1;
            }
            while (even < odd && nums[odd] % 2 == 1) {
                odd -= 1;
            }

            int temp = nums[even];
            nums[even] = nums[odd];
            nums[odd] = temp;
        }
        return nums;
    }
}
