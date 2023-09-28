/*
Given an array A of non-negative integers, return an array consisting of all the
even elements of A, followed by all the odd elements of A.

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
 public:
  vector<int> sortArrayByParity(vector<int>& nums) {
    int i = 0;
    int j = nums.size() - 1;
    while (i < j) {
      if (nums[i] % 2 == 1) {
        // odd number, need to find even number to swap
        while (i < j) {
          if (nums[j] % 2 == 0) {
            // swap i and j
            int tmp = nums[i];
            nums[i] = nums[j];
            nums[j] = tmp;
            j -= 1;
            break;
          }
          j -= 1;
        }
      }
      i += 1;
    }
    return nums;
  }
};
