/*
You have a number of envelopes with widths and heights given as a pair of integers (w, h). One envelope can fit into another if and only if both the width and height of one envelope is greater than the width and height of the other envelope.

What is the maximum number of envelopes can you Russian doll? (put one inside other)

Note:
Rotation is not allowed.

Example:

Input: [[5,4],[6,4],[6,7],[2,3]]
Output: 3
Explanation: The maximum number of envelopes you can Russian doll is 3 ([2,3] => [5,4] => [6,7]).
*/

/*
Solution 1: sort +
We answer the question from the intuition by sorting. Let's pretend that we found the best arrangement of envelopes. We know that each envelope must be increasing in w, thus our best arrangement has to be a subsequence of all our envelopes sorted on w.
After we sort our envelopes, we can simply find the length of the longest increasing subsequence on the second dimension (h). Note that we use a clever trick to solve some edge cases:
Consider an input [[1, 3], [1, 4], [1, 5], [2, 3]]. If we simply sort and extract the second dimension we get [3, 4, 5, 3], which implies that we can fit three envelopes (3, 4, 5). The problem is that we can only fit one envelope, since envelopes that are equal in the first dimension can't be put into each other.
In order fix this, we don't just sort increasing in the first dimension - we also sort decreasing on the second dimension, so two envelopes that are equal in the first dimension can never be in the same increasing subsequence.
Now when we sort and extract the second element from the input we get [5, 4, 3, 3], which correctly reflects an LIS of one.
//
Time complexity : O(NlogN), where N is the length of the input. Both sorting the array and finding the LIS happen in O(NlogN)
Space complexity : O(N). Our lis function requires an array dp which goes up to size N. Also the sorting algorithm we use may also take additional space.
*/
class Solution {
    public int maxEnvelopes(int[][] envelopes) {
        // sort by ascending width, descending height
        Arrays.sort(envelopes, (e1, e2) -> {
           return e1[0] == e2[0]
               ? Integer.compare(e2[1], e1[1])
               : Integer.compare(e1[0], e2[0]);
        });

        int n = envelopes.length;
        int[] height = new int[n];
        for(int i = 0; i < n; i++) {
            height[i] = envelopes[i][1];
        }
        return LIS(height);
    }

    public int LIS(int[] height) {
        int n = height.length;
        int[] dp = new int[n];
        int len = 0;
        for(int i = 0; i < n; i++) {
            int index = binarySearch(dp, 0, len, height[i]);
            dp[index] = height[i];
            if (index == len) {
                len += 1;
            }
        }
        return len;
    }

    public int binarySearch(int[] arr, int s, int e, int target) {
        while (s < e) {
            int mid = s + (e-s)/2;
            if (arr[mid] < target) {
                s = mid+1;
            } else {
                e = mid;
            }
        }
        return s;
    }
}