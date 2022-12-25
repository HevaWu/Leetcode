/*
You are given an integer array nums of length n, and an integer array queries of
length m.

Return an array answer of length m where answer[i] is the maximum size of a
subsequence that you can take from nums such that the sum of its elements is
less than or equal to queries[i].

A subsequence is an array that can be derived from another array by deleting
some or no elements without changing the order of the remaining elements.



Example 1:

Input: nums = [4,5,2,1], queries = [3,10,21]
Output: [2,3,4]
Explanation: We answer the queries as follows:
- The subsequence [2,1] has a sum less than or equal to 3. It can be proven that
2 is the maximum size of such a subsequence, so answer[0] = 2.
- The subsequence [4,5,1] has a sum less than or equal to 10. It can be proven
that 3 is the maximum size of such a subsequence, so answer[1] = 3.
- The subsequence [4,5,2,1] has a sum less than or equal to 21. It can be proven
that 4 is the maximum size of such a subsequence, so answer[2] = 4. Example 2:

Input: nums = [2,3,4,5], queries = [1]
Output: [0]
Explanation: The empty subsequence is the only subsequence that has a sum less
than or equal to 1, so answer[0] = 0.


Constraints:

n == nums.length
m == queries.length
1 <= n, m <= 1000
1 <= nums[i], queries[i] <= 106
*/

/*
Solution 1:
sort array
then use binary search to find largest sum <= each query
since array is sorted by increasing order, greedy find the result

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
 public:
  vector<int> answerQueries(vector<int>& nums, vector<int>& queries) {
    int n = nums.size();
    sort(nums.begin(), nums.end(),
         [](int num1, int num2) -> bool { return num1 < num2; });

    // sumArr[i] is sum of nums[0..<i]
    vector<int> sumArr(n + 1, 0);
    for (int i = 0; i < n; i++) {
      sumArr[i + 1] = sumArr[i] + nums[i];
    }

    int m = queries.size();
    vector<int> res(m, 0);

    for (int i = 0; i < m; i++) {
      int target = queries[i];
      if (sumArr[0] > target) {
        res[i] = 0;
        continue;
      }
      if (sumArr[n] <= target) {
        res[i] = n;
        continue;
      }

      // binary search find the element <= target
      int l = 0;
      int r = n;
      while (l < r) {
        int mid = l + (r - l) / 2;
        if (sumArr[mid] <= target) {
          l = mid + 1;
        } else {
          r = mid;
        }
      }
      res[i] = sumArr[l] <= target ? l : l - 1;
    }
    return res;
  }
};
