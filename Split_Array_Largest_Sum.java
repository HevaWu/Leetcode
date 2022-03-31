/*
Given an array which consists of non-negative integers and an integer m, you can split the array into m non-empty continuous subarrays. Write an algorithm to minimize the largest sum among these m subarrays.

Note:
If n is the length of array, assume the following constraints are satisfied:

1 ≤ n ≤ 1000
1 ≤ m ≤ min(50, n)
Examples:

Input:
nums = [7,2,5,10,8]
m = 2

Output:
18

Explanation:
There are four ways to split nums into two subarrays.
The best way is to split it into [7,2,5] and [10,8],
where the largest sum among the two subarrays is only 18.
*/


/*
Solution 2: binary search & greedy
We can use Binary search to find the value x0. Keeping a value mid = (left + right) / 2. If F(mid) is false, then we will search the range [mid + 1, right]; If F(mid) is true, then we will search [left, mid - 1].
For a given x, we can get the answer of F(x) using a greedy approach. Using an accumulator sum to store the sum of the current processing subarray and a counter cnt to count the number of existing subarrays. We will process the elements in the array one by one. For each element num, if sum + num <= x, it means we can add num to the current subarray without exceeding the limit. Otherwise, we need to make a cut here, start a new subarray with the current element num. This leads to an increment in the number of subarrays.
After we have finished the whole process, we need to compare the value cnt to the size limit of subarrays m. If cnt <= m, it means we can find a splitting method that ensures the maximum largest subarray sum will not exceed x. Otherwise, F(x) should be false.

Time complexity : O(n * log(sum of array))O(n∗log(sumofarray)). The binary search costs O(log(sum of array))O(log(sumofarray)), where sum of array is the sum of elements in nums. For each computation of F(x), the time complexity is O(n)O(n) since we only need to go through the whole array.
Space complexity : O(n)O(n). Same as the Brute Force approach. We only need the space to store the array.
*/
class Solution {
    public int splitArray(int[] nums, int m) {
        int low = 0;
        int high = 0;
        for(int num: nums) {
            high += num;
            low = Math.max(low, num);
        }

        while (low < high) {
            int mid = low + (high - low) / 2;

            int cur = 0;
            int box = 1;
            for(int num: nums) {
                cur += num;
                if (cur > mid) {
                    box += 1;
                    cur = num;

                    if (box > m) {
                        break;
                    }
                }
            }

            if (box <= m) {
                high = mid;
            } else {
                low = mid+1;
            }
        }
        return low;
    }
}
