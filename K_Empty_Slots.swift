// You have N bulbs in a row numbered from 1 to N. Initially, all the bulbs are turned off. We turn on exactly one bulb everyday until all bulbs are on after N days.

// You are given an array bulbs of length N where bulbs[i] = x means that on the (i+1)th day, we will turn on the bulb at position x where i is 0-indexed and x is 1-indexed.

// Given an integer K, find out the minimum day number such that there exists two turned on bulbs that have exactly K bulbs between them that are all turned off.

// If there isn't such day, return -1.

 

// Example 1:

// Input: 
// bulbs: [1,3,2]
// K: 1
// Output: 2
// Explanation:
// On the first day: bulbs[0] = 1, first bulb is turned on: [1,0,0]
// On the second day: bulbs[1] = 3, third bulb is turned on: [1,0,1]
// On the third day: bulbs[2] = 2, second bulb is turned on: [1,1,1]
// We return 2 because on the second day, there were two on bulbs with one off bulb between them.
// Example 2:

// Input: 
// bulbs: [1,2,3]
// K: 1
// Output: -1
 

// Note:

// 1 <= N <= 20000
// 1 <= bulbs[i] <= N
// bulbs is a permutation of numbers from 1 to N.
// 0 <= K <= 20000

// Solution 1: sliding window
// we have days[x] = i for the time that the flower at position x blooms. We wanted to find candidate intervals [left, right] where days[left], days[right] are the two smallest values in [days[left], days[left+1], ..., days[right]], and right - left = k + 1.
// Notice that these candidate intervals cannot intersect: for example, if the candidate intervals are [left1, right1] and [left2, right2] with left1 < left2 < right1 < right2, then for the first interval to be a candidate, days[left2] > days[right1]; and for the second interval to be a candidate, days[right1] > days[left2], a contradiction.
// That means whenever whether some interval can be a candidate and it fails first at i, indices j < i can't be the start of a candidate interval. This motivates a sliding window approach.
// 
// we construct days.
// Then, for each interval [left, right] (starting with the first available one), we'll check whether it is a candidate: whether days[i] > days[left] and days[i] > days[right] for left < i < right.
// If we fail, then we've found some new minimum days[i] and we should check the new interval [i, i+k+1]. If we succeed, then it's a candidate answer, and we'll check the new interval [right, right+k+1].
// 
// Time and Space Complexity: O(N)O(N).
class Solution {
    func kEmptySlots(_ bulbs: [Int], _ K: Int) -> Int {
        // days[i], in the ith day, days[i] bulb turn on 
        var days = Array(repeating: 0, count: bulbs.count)
        for i in 0..<bulbs.count {
            days[bulbs[i]-1] = i + 1
        }
        
        var num = 20001
        var left = 0
        var right = K + 1
        
        while right < days.count {
            var index = left + 1
            var shouldRestart = false
            while index < right {
                if days[index] < days[left] || days[index] < days[right] {
                    left = index
                    right = index + K + 1
                    shouldRestart = true
                    break
                }
                index += 1
            }
            
            guard !shouldRestart else { continue }
            
            num = min(num, max(days[left], days[right]))
            left = right
            right = left + K + 1
        }
        return num < 20001 ? num : -1
    }
}