// Return the length of the shortest, non-empty, contiguous subarray of A with sum at least K.

// If there is no non-empty subarray with sum at least K, return -1.

 

// Example 1:

// Input: A = [1], K = 1
// Output: 1
// Example 2:

// Input: A = [1,2], K = 4
// Output: -1
// Example 3:

// Input: A = [2,-1,2], K = 3
// Output: 3
 

// Note:

// 1 <= A.length <= 50000
// -10 ^ 5 <= A[i] <= 10 ^ 5
// 1 <= K <= 10 ^ 9

// Solution 1: sliding window
// We can rephrase this as a problem about the prefix sums of A. Let P[i] = A[0] + A[1] + ... + A[i-1]. We want the smallest y-x such that y > x and P[y] - P[x] >= K.
// Motivated by that equation, let opt(y) be the largest x such that P[x] <= P[y] - K. We need two key observations:
// If x1 < x2 and P[x2] <= P[x1], then opt(y) can never be x1, as if P[x1] <= P[y] - K, then P[x2] <= P[x1] <= P[y] - K but y - x2 is smaller. This implies that our candidates x for opt(y) will have increasing values of P[x].
// If opt(y1) = x, then we do not need to consider this x again. For if we find some y2 > y1 with opt(y2) = x, then it represents an answer of y2 - x which is worse (larger) than y1 - x.
// 
// Maintain a "monoqueue" of indices of P: a deque of indices x_0, x_1, ... such that P[x_0], P[x_1], ... is increasing.
// When adding a new index y, we'll pop x_i from the end of the deque so that P[x_0], P[x_1], ..., P[y] will be increasing.
// If P[y] >= P[x_0] + K, then (as previously described), we don't need to consider this x_0 again, and we can pop it from the front of the deque.
// 
// Time complexity: O(n)
// Space complexity: O(n)
class Solution {
    func shortestSubarray(_ A: [Int], _ K: Int) -> Int {
        guard !A.isEmpty else { return -1 }
        
        let n = A.count
        var sum = Array(repeating: 0, count: n+1)
        for i in 0..<n {
            sum[i+1] = sum[i] + A[i]
        }
		// var sum = A.reduce(into: [0]) { res, cur in
        //     res.append(cur + res.last!)
        // }
        
        var len = A.count + 1
        var list = [Int]()
        
        for i in 0..<sum.count {
            while !list.isEmpty, sum[i] <= sum[list.last!] {
                list.removeLast()
            }
            while !list.isEmpty, sum[i] >= sum[list.first!] + K {
                len = min(len, i - list.removeFirst())
            }
            list.append(i)
        }
        
        return len < A.count+1 ? len : -1
    }
}