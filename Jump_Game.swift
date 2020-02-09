// Given an array of non-negative integers, you are initially positioned at the first index of the array.

// Each element in the array represents your maximum jump length at that position.

// Determine if you are able to reach the last index.

// Example 1:

// Input: [2,3,1,1,4]
// Output: true
// Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
// Example 2:

// Input: [3,2,1,0,4]
// Output: false
// Explanation: You will always arrive at index 3 no matter what. Its maximum
//              jump length is 0, which makes it impossible to reach the last index.

// Hint:
// This is dynamic programming question
// There are 4 ways to solve it:
// - Start with the recursive backtracking solution
// - Optimize by using a memoization table (top-down[2] dynamic programming)
// - Remove the need for recursion (bottom-up dynamic programming)
// - Apply final tricks to reduce the time / memory complexity

// Solution 1: Backtracking
// This is the inefficient solution where we try every single jump pattern that takes us from the first position to the last. We start from the first position and jump to every index that is reachable. We repeat the process until last index is reached. When stuck, backtrack.
// 
// Time complexity : O(2^n) There are 2^n (upper bound) ways of jumping from the first position to the last, where nn is the length of array nums. For a complete proof, please refer to Appendix A.
// Space complexity : O(n). Recursion requires additional memory for the stack frames.
class Solution {
    func canJump(_ nums: [Int]) -> Bool {
        guard !nums.isEmpty else { return true }
        return canJump(nums, at: 0)
    }
    
    func canJump(_ nums: [Int], at index: Int) -> Bool {
        guard index < nums.count-1 else { return true }
        guard nums[index] != 0 else { return false }
        
        for i in 1...nums[index] {
            if canJump(nums, at: index + i) { 
                return true
            }
        }
        return false
    }
}

// Solution 2: Dynamic Programming Top Down
// Add Mode of this array, 
// itially, all elements of the canJumpArr are UNKNOWN, except for the last one, which is (trivially) GOOD (it can reach itself)
// Modify the backtracking algorithm such that the recursive step first checks if the index is known (GOOD / BAD)
// If it is known then return True / False
// Otherwise perform the backtracking steps as before
// Once we determine the value of the current index, we store it in the canJumpArr
// 
// Time complexity : O(n^2). For every element in the array, say i, we are looking at the next nums[i] elements to its right aiming to find a GOOD index. nums[i] can be at most n, where n is the length of array nums.
// Space complexity : O(2n) = O(n). First n originates from recursion. Second n comes from the usage of the canJumpArr.
class Solution {
    enum Mode {
        case good
        case bad
        case unknown
    }
    
    var canJumpArr: [Mode] = []
    
    func canJump(_ nums: [Int]) -> Bool {
        guard !nums.isEmpty else { return true }
        canJumpArr = Array(repeating: Mode.unknown, count: nums.count)
        canJumpArr[nums.count-1] = .good
        return canJump(nums, at: 0)
    }
    
    func canJump(_ nums: [Int], at index: Int) -> Bool {
        guard index < nums.count-1 else { return true }
        guard canJumpArr[index] == .unknown else { return canJumpArr[index] == .good ? true : false}
        guard nums[index] != 0 else { return false }
        
        for i in (1...nums[index]).reversed() {
            if canJump(nums, at: index + i) { 
                canJumpArr[index] = .good
                return true
            }
        }
        canJumpArr[index] = .bad
        return false
    }
}

// Solution 3: Dynamic Programming Bottom-up
// Top-down to bottom-up conversion is done by eliminating recursion. In practice, this achieves better performance as we no longer have the method stack overhead and might even benefit from some caching. More importantly, this step opens up possibilities for future optimization. The recursion is usually eliminated by trying to reverse the order of the steps from the top-down approach.
// The observation to make here is that we only ever jump to the right. This means that if we start from the right of the array, every time we will query a position to our right, that position has already be determined as being GOOD or BAD. This means we don't need to recurse anymore, as we will always hit the canJumpArr.
// 
// Time Complexity: O(n^2). For every element in the array, say i, we are looking at the next nums[i] elements to its right aiming to find a GOOD index. nums[i] can be at most nn, where nn is the length of array nums.
// Space complexity : O(n). This comes from the usage of the canJumpArr.
class Solution {
    enum Mode {
        case good
        case bad
        case unknown
    }
        
    func canJump(_ nums: [Int]) -> Bool {
        guard !nums.isEmpty else { return true }
        var canJumpArr = Array(repeating: Mode.unknown, count: nums.count)
        canJumpArr[nums.count-1] = .good
        for i in (0..<nums.count-1).reversed() {
            let maxJump = min(i + nums[i], nums.count - 1)
            var j = i+1
            while j <= maxJump {
                if canJumpArr[j] == .good {
                    canJumpArr[i] = .good
                    break
                }
            }
        }
        
        return canJumpArr[0] == .good
    }
}

// Solution 4: Greedy
// Once we have our code in the bottom-up state, we can make one final, important observation. From a given position, when we try to see if we can jump to a GOOD position, we only ever use one - the first one (see the break statement). In other words, the left-most one. If we keep track of this left-most GOOD position as a separate variable, we can avoid searching for it in the array. Not only that, but we can stop using the array altogether.
// Iterating right-to-left, for each position we check if there is a potential jump that reaches a GOOD index (currPosition + nums[currPosition] >= leftmostGoodIndex). If we can reach a GOOD index, then our position is itself GOOD. Also, this new GOOD position will be the new leftmost GOOD index. Iteration continues until the beginning of the array. If first position is a GOOD index then we can reach the last index from the first position.
// To illustrate this scenario, we will use the diagram below, for input array nums = [9, 4, 2, 1, 0, 2, 0]. We write G for GOOD, B for BAD and U for UNKNOWN. Let's assume we have iterated all the way to position 0 and we need to decide if index 0 is GOOD. Since index 1 was determined to be GOOD, it is enough to jump there and then be sure we can eventually reach index 6. It does not matter that nums[0] is big enough to jump all the way to the last index. All we need is one way.
// Index	0	1	2	3	4	5	6
// nums		9	4	2	1	0	2	0
// memo		U	G	B	B	B	G	G
// 
// Time complexity : O(n). We are doing a single pass through the nums array, hence nn steps, where nn is the length of array nums.
// Space complexity : O(1). We are not using any extra memory.
class Solution {
    func canJump(_ nums: [Int]) -> Bool {
        guard !nums.isEmpty else { return true }
        var finalPos = nums.count - 1
        for i in (0..<nums.count).reversed() {
            if i+nums[i] >= finalPos {
                finalPos = i
            }
        }
        return finalPos == 0
    }
}