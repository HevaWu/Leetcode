// Let's call an array A a mountain if the following properties hold:

// A.length >= 3
// There exists some 0 < i < A.length - 1 such that A[0] < A[1] < ... A[i-1] < A[i] > A[i+1] > ... > A[A.length - 1]
// Given an array that is definitely a mountain, return any i such that A[0] < A[1] < ... A[i-1] < A[i] > A[i+1] > ... > A[A.length - 1].

// Example 1:

// Input: [0,1,0]
// Output: 1
// Example 2:

// Input: [0,2,1,0]
// Output: 1
// Note:

// 3 <= A.length <= 10000
// 0 <= A[i] <= 10^6
// A is a mountain, as defined above.

// Solution 1: linear scan
// 
// Time complexity: O(n)
// Space complexity: O(1)
class Solution {
    func peakIndexInMountainArray(_ A: [Int]) -> Int {
        var peak = 0
        while A[peak] < A[peak+1] {
            peak += 1
        }
        return peak
    }
}

// Solution 1: binary search
// 
// Time complexity: O(logn)
// Space complexty: O(1)
class Solution {
    func peakIndexInMountainArray(_ A: [Int]) -> Int {
        var left = 0
        var right = A.count-1
        var pivot = 0
        while left < right {
            pivot = (left+right)/2
            if A[pivot] < A[pivot+1] {
                // peak at the pivot right side
                left = pivot + 1
            } else {
                // peak at the pivot left side
                right = pivot
            }
        }
        return left
    }
}