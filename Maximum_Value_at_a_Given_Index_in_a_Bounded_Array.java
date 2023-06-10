/*
You are given three positive integers: n, index, and maxSum. You want to construct an array nums (0-indexed) that satisfies the following conditions:

nums.length == n
nums[i] is a positive integer where 0 <= i < n.
abs(nums[i] - nums[i+1]) <= 1 where 0 <= i < n-1.
The sum of all the elements of nums does not exceed maxSum.
nums[index] is maximized.
Return nums[index] of the constructed array.

Note that abs(x) equals x if x >= 0, and -x otherwise.



Example 1:

Input: n = 4, index = 2,  maxSum = 6
Output: 2
Explanation: nums = [1,2,2,1] is one array that satisfies all the conditions.
There are no arrays that satisfy all the conditions and have nums[2] == 3, so 2 is the maximum nums[2].
Example 2:

Input: n = 6, index = 1,  maxSum = 10
Output: 3


Constraints:

1 <= n <= maxSum <= 109
0 <= index < n

*/

/*
Solution 1:
binary search to find proper values
- binary search bound is [0...maxSum]

check if set nums[index] as val can build maxSum array or not
- find minimum possible value in left side
--> left part, index element
--> if val-index >= 1, means val-1, val-2, ... val-index, calculate summation
--> if val-index < 1, means val-1, val-2, ... , 1, 1, 1, 1, calculate summation
- find minimum possible value in right side
--> right part, (n-index-1) element
--> if val-(n-index-1) >= 1, means val-1, val-2, ... val-index, calculate summation
--> if val-(n-index-1) < 1, means val-1, val-2, ... , 1, 1, 1, 1, calculate summation

Time Complexity: O(log(maxSum))
Space Complexity: O(1)
*/
class Solution {
    public int maxValue(int n, int index, int maxSum) {
        if (n == 1) { return maxSum; }
        int l = 1;
        int r = maxSum;
        while (l+1 < r) {
            int mid = l + (r-l)/2;
            if (canFind(mid, n, index, maxSum)) {
                l = mid;
            } else {
                r = mid;
            }
        }
        return l;
    }

    public boolean canFind(int val, int n, int index, int maxSum) {
        long minLeft = val - index >= 1
        ? ((long)index * (long)(val - 1 + val - index)) / 2
        : ((long)val * (long)(val - 1)) / 2 + (index - val + 1);

        long minRight = val - (n-index-1) >= 1
        ? ((long)(n-index-1) * (long)(val - 1 + val - (n-index-1)))/2
        : ((long)val * (long)(val - 1)) / 2 + (n-index-val);

        if (minLeft + minRight <= maxSum - val) {
            return true;
        } else {
            return false;
        }
    }
}
