/*
Given an integer array nums, return the number of all the arithmetic subsequences of nums.

A sequence of numbers is called arithmetic if it consists of at least three elements and if the difference between any two consecutive elements is the same.

For example, [1, 3, 5, 7, 9], [7, 7, 7, 7], and [3, -1, -5, -9] are arithmetic sequences.
For example, [1, 1, 2, 5, 7] is not an arithmetic sequence.
A subsequence of an array is a sequence that can be formed by removing some elements (possibly none) of the array.

For example, [2,5,10] is a subsequence of [1,2,1,2,4,1,5,10].
The answer is guaranteed to fit in 32-bit integer.



Example 1:

Input: nums = [2,4,6,8,10]
Output: 7
Explanation: All arithmetic subsequence slices are:
[2,4,6]
[4,6,8]
[6,8,10]
[2,4,6,8]
[4,6,8,10]
[2,4,6,8,10]
[2,6,10]
Example 2:

Input: nums = [7,7,7,7,7]
Output: 16
Explanation: Any subsequence of this array is arithmetic.


Constraints:

1  <= nums.length <= 1000
-231 <= nums[i] <= 231 - 1
*/

/*
Solution 1:
DP

- f[i][d] denotes the number of arithmetic subsequences that ends with A[i] and its common difference is d.
- for all j < i, f[i][A[i] - A[j]] += f[j][A[i] - A[j]].
- Weak arithmetic subsequences are subsequences that consist of at least two elements and if the difference between any two consecutive elements is the same.
    - For any pair i, j (i != j), A[i] and A[j] can always form a weak arithmetic subsequence.
    - If we can append a new element to a weak arithmetic subsequence and keep it arithmetic, then the new subsequence must be an arithmetic subsequence.

- f[i][d] denotes the number of weak arithmetic subsequences that ends with A[i] and its common difference is d.
- for all j < i, f[i][A[i] - A[j]] += (f[j][A[i] - A[j]] + 1).

 how can we get the number of arithmetic subsequences that are not weak?

There are two ways:
- First, we can count the number of pure weak arithmetic subsequences directly. The pure weak arithmetic subsequences are the arithmetic subsequences of length 2, so the number of pure weak arithmetic subsequences should be equal to the number of pairs (i, j), which is (2 n) = n∗(n−1)/2.
- Second, for the summation f[i][A[i] - A[j]] += (f[j][A[i] - A[j]] + 1), f[j][A[i] - A[j]] is the number of existing weak arithmetic subsequences, while 1 is the new subsequence built with A[i] and A[j]. Based on property two, when we are appending new elements to existing weak arithmetic subsequences, we are forming arithmetic subsequences. So the first part, f[j][A[i] - A[j]] is the number of new formed arithmetic subsequences, and can be added to the answer.

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
public:
    int numberOfArithmeticSlices(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> f[n];
        double res = 0;

        for(int i = 0; i < n; i++) {
            for(int j = 0; j < i; j++) {
                double diff = (double)nums[i] - (double)nums[j];
                if (diff > INT_MAX || diff < INT_MIN) { continue; }
                int weakPair = f[i][diff];
                int strongPair = f[j][diff];

                f[i][diff] = weakPair + strongPair + 1;
                res += strongPair;
            }
        }

        return (int)res;
    }
};
