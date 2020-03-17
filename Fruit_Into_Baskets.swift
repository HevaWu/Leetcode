// In a row of trees, the i-th tree produces fruit with type tree[i].

// You start at any tree of your choice, then repeatedly perform the following steps:

// Add one piece of fruit from this tree to your baskets.  If you cannot, stop.
// Move to the next tree to the right of the current tree.  If there is no tree to the right, stop.
// Note that you do not have any choice after the initial choice of starting tree: you must perform step 1, then step 2, then back to step 1, then step 2, and so on until you stop.

// You have two baskets, and each basket can carry any quantity of fruit, but you want each basket to only carry one type of fruit each.

// What is the total amount of fruit you can collect with this procedure?

 

// Example 1:

// Input: [1,2,1]
// Output: 3
// Explanation: We can collect [1,2,1].
// Example 2:

// Input: [0,1,2,2]
// Output: 3
// Explanation: We can collect [1,2,2].
// If we started at the first tree, we would only collect [0, 1].
// Example 3:

// Input: [1,2,3,2,2]
// Output: 4
// Explanation: We can collect [2,3,2,2].
// If we started at the first tree, we would only collect [1, 2].
// Example 4:

// Input: [3,3,3,1,2,1,1,2,3,3,4]
// Output: 5
// Explanation: We can collect [1,2,1,1,2].
// If we started at the first tree or the eighth tree, we would only collect 4 fruits.
 

// Note:

// 1 <= tree.length <= 40000
// 0 <= tree[i] < tree.length

// Solution 1: Sliding window
// As in Approach 1, we want the longest subarray with at most two different "types" (values of tree[i]). Call these subarrays valid.
// Say we consider all valid subarrays that end at index j. There must be one with the smallest possible starting index i: lets say opt(j) = i.
// Now the key idea is that opt(j) is a monotone increasing function. This is because any subarray of a valid subarray is valid.
// 
// Let's perform a sliding window, keeping the loop invariant that i will be the smallest index for which [i, j] is a valid subarray.
// We'll maintain count, the count of all the elements in the subarray. This allows us to quickly query whether there are 3 types in the subarray or not.
// 
// Time complexity: O(n)
// Space complexity: O(1)
class Solution {
    func totalFruit(_ tree: [Int]) -> Int {
        guard !tree.isEmpty else { return 0 }
        
        var total = 0 
        var first = -1
        var second = -1
        var temp = 0
        var lastSwitch = 0
        
        for i in 0..<tree.count {
            if tree[i] == first || tree[i] == second {
                if i > 0, tree[i-1] != tree[i] {
                    lastSwitch = i
                }
                continue
            }
            
            if first == -1 {
                first = tree[i]
                lastSwitch = i
                continue
            }
            
            if second == -1 {
                second = tree[i]
                lastSwitch = i
                continue
            }
            
            total = max(total, i - temp)
            first = tree[i-1]
            second = tree[i]
            temp = lastSwitch
            lastSwitch = i
        }
        return max(total, tree.count - temp)
    }
}
