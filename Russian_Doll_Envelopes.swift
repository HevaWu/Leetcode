// You have a number of envelopes with widths and heights given as a pair of integers (w, h). One envelope can fit into another if and only if both the width and height of one envelope is greater than the width and height of the other envelope.

// What is the maximum number of envelopes can you Russian doll? (put one inside other)

// Note:
// Rotation is not allowed.

// Example:

// Input: [[5,4],[6,4],[6,7],[2,3]]
// Output: 3 
// Explanation: The maximum number of envelopes you can Russian doll is 3 ([2,3] => [5,4] => [6,7]).

// Solution 1: sort + 
// We answer the question from the intuition by sorting. Let's pretend that we found the best arrangement of envelopes. We know that each envelope must be increasing in w, thus our best arrangement has to be a subsequence of all our envelopes sorted on w.
// After we sort our envelopes, we can simply find the length of the longest increasing subsequence on the second dimension (h). Note that we use a clever trick to solve some edge cases:
// Consider an input [[1, 3], [1, 4], [1, 5], [2, 3]]. If we simply sort and extract the second dimension we get [3, 4, 5, 3], which implies that we can fit three envelopes (3, 4, 5). The problem is that we can only fit one envelope, since envelopes that are equal in the first dimension can't be put into each other.
// In order fix this, we don't just sort increasing in the first dimension - we also sort decreasing on the second dimension, so two envelopes that are equal in the first dimension can never be in the same increasing subsequence.
// Now when we sort and extract the second element from the input we get [5, 4, 3, 3], which correctly reflects an LIS of one.
// 
// Time complexity : O(N \log N)O(NlogN), where NN is the length of the input. Both sorting the array and finding the LIS happen in O(N \log N)O(NlogN)
// Space complexity : O(N)O(N). Our lis function requires an array dp which goes up to size NN. Also the sorting algorithm we use may also take additional space.
class Solution {
    func maxEnvelopes(_ envelopes: [[Int]]) -> Int {
        guard !envelopes.isEmpty else { return 0 }
        
        var envelopes = envelopes.sorted(by: { first, second -> Bool in
            return first[0] < second[0] || (first[0] == second[0] && first[1] > second[1])
        })

        var hightDim = [Int]()
        for e in envelopes {
            hightDim.append(e[1])
        }
        return LIS(hightDim)
    }
    
    // longest increasing subsequence problem
    func LIS(_ nums: [Int]) -> Int {
        // dp[i] is the smallest element that ends an increasing subsequence of length i+1 
        var dp = Array(repeating: 0, count: nums.count)
        var len = 0
        for i in 0..<nums.count {
            var temp = binarySearch(dp, 0, len, nums[i])
            dp[temp] = nums[i]
            if temp == len {
                len += 1
            }
        }
        return len
    }
    
    func binarySearch(_ arr: [Int], _ start: Int, _ end: Int, _ target: Int) -> Int {
        var start = start
        var end = end
        while start < end {
            var mid = (start + end)/2
            if arr[mid] == target {
                return mid
            }
            if arr[mid] < target {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return start
    }
}