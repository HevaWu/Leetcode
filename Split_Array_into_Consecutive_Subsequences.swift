// Given an array nums sorted in ascending order, return true if and only if you can split it into 1 or more subsequences such that each subsequence consists of consecutive integers and has length at least 3.

 

// Example 1:


// Input: [1,2,3,3,4,5]
// Output: True
// Explanation:
// You can split them into two consecutive subsequences : 
// 1, 2, 3
// 3, 4, 5

// Example 2:

// Input: [1,2,3,3,4,4,5,5]
// Output: True
// Explanation:
// You can split them into two consecutive subsequences : 
// 1, 2, 3, 4, 5
// 3, 4, 5

// Example 3:

// Input: [1,2,3,4,4,5]
// Output: False
 

// Constraints:

// 1 <= nums.length <= 10000

// consecutive 连续的

// Solution 1: 
// For each group of numbers, say the number is x and there are count of them. Furthermore, say prev, prev_count is the previous integer encountered and it's count.
// Then, in general there are abs(count - prev_count) events that will happen: if count > prev_count then we will add this many t's to starts; and if count < prev_count then we will attempt to pair starts.popleft() with t-1.
// More specifically, when we have finished a consecutive group, we will have prev_count endings; and when we are in a consecutive group, we may have count - prev_count starts or prev_count - count endings.
// For example, when nums = [1,2,3,3,4,5], then the starts are at [1, 3] and the endings are at [3, 5]. As our algorithm progresses:
// When t = 1, count = 1: starts = [1]
// When t = 2, count = 1: starts = [1]
// When t = 3, count = 2: starts = [1, 3]
// When t = 4, count = 1: starts = [3], since prev_count - count = 1 we process one closing event, which is accepted as t-1 >= starts.popleft() + 2.
// When t = 5, count = 1: starts = [3]
// And at the end, we process prev_count more closing events nums[-1].
// 
// Time Complexity: O(N)O(N), where NN is the length of nums. We iterate over the array and every event is added or popped to starts at most once.
// Space Complexity: O(N)O(N), the size of starts.
class Solution {
    func isPossible(_ nums: [Int]) -> Bool {
        var pre: Int? = nil
        var preCount = 0
        
        var start = [Int]()
        var currStart = 0
        
        for i in 0..<nums.count {
            if i == nums.count-1 || nums[i+1] != nums[i] {
                var count = i-currStart+1
                
                if pre != nil && nums[i]-pre! != 1 {
                    while preCount > 0 {
                        if pre! < start.removeLast() + 2 {
                            return false
                        }
                        preCount -= 1
                    }
                    // help add start later
                    pre = nil
                }
                
                if pre == nil || nums[i]-pre! == 1 {
                    while preCount > count {
                        preCount -= 1
                        if nums[i]-1 < start.removeLast() + 2 {
                            return false
                        }
                    }
                    while preCount < count {
                        start.insert(nums[i], at: 0)
                        preCount += 1
                    }
                }
                
                pre = nums[i]
                preCount = count
                currStart = i + 1
            }
        }
        
        while preCount > 0 {
            if nums[nums.count-1] < start.removeLast() + 2 { return false }
            preCount -= 1
        }
        return true
    }
}

// Solution 2: greedy
// Call a chain a sequence of 3 or more consecutive numbers.
// Considering numbers x from left to right, if x can be added to a current chain, it's at least as good to add x to that chain first, rather than to start a new chain.
// Why? If we started with numbers x and greater from the beginning, the shorter chains starting from x could be concatenated with the chains ending before x, possibly helping us if there was a "chain" from x that was only length 1 or 2.
// 
// Say we have a count of each number, and let tails[x] be the number of chains ending right before x.
// Now let's process each number. If there's a chain ending before x, then add it to that chain. Otherwise, if we can start a new chain, do so.
// It's worth noting that our solution can be amended to take only O(1)O(1) additional space, since we could do our counts similar to Approach #1, and we only need to know the last 3 counts at a time.
// 
// Time Complexity: O(N)O(N), where NN is the length of nums. We iterate over the array.
// Space Complexity: O(N)O(N), the size of count and tails.
class Solution {
    func isPossible(_ nums: [Int]) -> Bool {
        var countMap = [Int: Int]()
        // control last number of sub arrays
        // number of chains ending right before x
        var tailMap = [Int: Int]()
        
        for num in nums {
            countMap[num, default: 0] += 1
        }
        
        for num in nums {
            if countMap[num]! == 0 {
                continue
            } else if tailMap[num, default: 0] > 0 {
                // can append to a chain
                countMap[num]! -= 1
                tailMap[num]! -= 1
                tailMap[num+1, default: 0] += 1
            } else if countMap[num+1, default: 0] > 0, countMap[num+2, default: 0] > 0 {
                // append to the new chain
                countMap[num]! -= 1
                countMap[num+1]! -= 1
                countMap[num+2]! -= 1
                tailMap[num+3, default: 0] += 1
            } else {
                return false
            }
        }
        return true
    }
}



