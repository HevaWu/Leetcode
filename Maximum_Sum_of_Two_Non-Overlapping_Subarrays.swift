// Given an array A of non-negative integers, return the maximum sum of elements in two non-overlapping (contiguous) subarrays, which have lengths L and M.  (For clarification, the L-length subarray could occur before or after the M-length subarray.)

// Formally, return the largest V for which V = (A[i] + A[i+1] + ... + A[i+L-1]) + (A[j] + A[j+1] + ... + A[j+M-1]) and either:

// 0 <= i < i + L - 1 < j < j + M - 1 < A.length, or
// 0 <= j < j + M - 1 < i < i + L - 1 < A.length.
 

// Example 1:

// Input: A = [0,6,5,2,2,5,1,9,4], L = 1, M = 2
// Output: 20
// Explanation: One choice of subarrays is [9] with length 1, and [6,5] with length 2.
// Example 2:

// Input: A = [3,8,1,3,2,1,8,9,0], L = 3, M = 2
// Output: 29
// Explanation: One choice of subarrays is [3,8,1] with length 3, and [8,9] with length 2.
// Example 3:

// Input: A = [2,1,5,6,0,9,5,0,3,8], L = 4, M = 3
// Output: 31
// Explanation: One choice of subarrays is [5,6,0,9] with length 4, and [3,8] with length 3.
 

// Note:

// L >= 1
// M >= 1
// L + M <= A.length <= 1000
// 0 <= A[i] <= 1000

// hint
// We can use prefix sums to calculate any subarray sum quickly. For each L length subarray, find the best possible M length subarray that occurs before and after it.

// Solution 1:
// build sum array,
// check if we could set M at pre-half or last-half
// 
// Time complexity: O(n+LM)
// Space complexity: O(n)
class Solution {
    func maxSumTwoNoOverlap(_ A: [Int], _ L: Int, _ M: Int) -> Int {
        guard !A.isEmpty, L+M <= A.count else { return 0 }
        
        let n = A.count
        var sumA = Array(repeating: 0, count: n+1)
        for i in 0..<n {
            sumA[i+1] = sumA[i] + A[i]
        }
        
        var sum = 0
        for i in 0...n-L {
            guard i >= M || n-(i+L) >= M else { 
                // cannot pick M array, skip
                continue 
            }
            
            let tempL = sumA[i+L] - sumA[i]
            if i >= M {
                // pick M in 0 to i
                for j in 0...i-M {
                    sum = max(sum, tempL + sumA[j+M] - sumA[j])
                }
            } 
            
            if n-(i+L) >= M {
                // pick M in i+L to n
                for j in 0...n-(i+L+M) {
                    sum = max(sum, tempL + sumA[i+L+j+M] - sumA[i+L+j])
                }
            }
        }
        return sum
    }
}

// Solution 2:
// Lsum, sum of the last L elements
// Msum, sum of the last M elements
// Lmax, max sum of contiguous L elements before the last M elements.
// Mmax, max sum of contiguous M elements before the last L elements/
// 
// Time complexity: O(n)
// Space complexity: O(1)
class Solution {
    func maxSumTwoNoOverlap(_ A: [Int], _ L: Int, _ M: Int) -> Int {
        guard !A.isEmpty else { return 0 }
        let n = A.count
        
        // sum the array
        var A = A
        for i in 1..<n {
            A[i] = A[i-1] + A[i]
        }
        
        var len = A[L+M-1]
        var Lmax = A[L-1]
        var Mmax = A[M-1]
        for i in L+M..<n {
            Lmax = max(Lmax, A[i-M] - A[i-(L+M)])
            Mmax = max(Mmax, A[i-L] - A[i-(L+M)])
            len = max(
                len, 
                max(Lmax+A[i] - A[i-M], Mmax+A[i] - A[i-L])
            )
        }
        return len
    }
}