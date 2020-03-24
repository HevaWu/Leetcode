// Given an array w of positive integers, where w[i] describes the weight of index i, write a function pickIndex which randomly picks an index in proportion to its weight.

// Note:

// 1 <= w.length <= 10000
// 1 <= w[i] <= 10^5
// pickIndex will be called at most 10000 times.
// Example 1:

// Input: 
// ["Solution","pickIndex"]
// [[[1]],[]]
// Output: [null,0]
// Example 2:

// Input: 
// ["Solution","pickIndex","pickIndex","pickIndex","pickIndex","pickIndex"]
// [[[1,3]],[],[],[],[],[]]
// Output: [null,0,1,1,1,0]
// Explanation of Input Syntax:

// The input is two lists: the subroutines called and their arguments. Solution's constructor has one argument, the array w. pickIndex has no arguments. Arguments are always wrapped with a list, even if there aren't any.

// Solution 1: prefix & binary search
// Compute the prefix sum array pp, where p[x] = \sum_\limits{i=0}^{x}w[i].
// Generate a random integer \text{targ}targ in the range [0, \text{tot})[0,tot).
// Use binary search to find the index xx where xx is the lowest index such that \text{targ} < p[x]targ<p[x].
// For some index ii, all integers vv where p[i] - w[i] \leq v < p[i]p[i]−w[i]≤v<p[i] map to this index. Therefore, indexes will be sampled proportionally to the index weights.
// 
// Time Complexity: O(N)O(N) preprocessing. O(\log(N))O(log(N)) \text{pickIndex}pickIndex.
// Space Complexity: O(N)O(N)
class Solution {
    var sumArr = [Int]()
    var total = 0
    
    init(_ w: [Int]) {
        for i in 0..<w.count {
            total += w[i]
            sumArr.append(total)
        }
    }
    
    func pickIndex() -> Int {
        var target = Int.random(in: 0..<total)
    
        // binary search random total
        var left = 0
        var right = sumArr.count - 1
        while left != right {
            var mid = (left + right) / 2
            if sumArr[mid] <= target {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(w)
 * let ret_1: Int = obj.pickIndex()
 */