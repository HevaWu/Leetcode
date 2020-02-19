// You are given an integer array nums and you have to return a new counts array. The counts array has the property where counts[i] is the number of smaller elements to the right of nums[i].

// Example:

// Input: [5,2,6,1]
// Output: [2,1,1,0] 
// Explanation:
// To the right of 5 there are 2 smaller elements (2 and 1).
// To the right of 2 there is only 1 smaller element (1).
// To the right of 6 there is 1 smaller element (1).
// To the right of 1 there is 0 smaller element.

// Solution 1: brute force
// for each element, search remain array
// 
// Time complexity: O(n^2)
// Space complexity: O(1)
class Solution {
    func countSmaller(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [Int]() }
        
        var counts = [Int]()
        for i in nums.indices {
            let num = nums[i]
            var temp = 0
            var j = i + 1
            while j < nums.count {
                if nums[j] < num {
                    temp += 1
                }
                j += 1
            }
            counts.append(temp)
        }
        return counts
    }
}

// Solution 2: Binary Tree
// use binary tree to check the small count
// left always < node < right
// count --> the node have same value
// smallCount --> this node left children
// 
// Time complexity: O(nlogn)
// Space complexity: O(logn) <- tree size
class Solution {
    func countSmaller(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [Int]() }
        
        var counts = Array(repeating: 0, count: nums.count)  
        var root: TreeNode? = nil
        for i in nums.indices.reversed() {
            insert(&root, nums[i], i, &counts, 0)
        }
        return counts
    }
    
    private func insert(_ node: inout TreeNode?, _ val: Int, _ index: Int, _ counts: inout [Int], _ preSmallCount: Int) -> TreeNode? {
        if node == nil {
            node = TreeNode(val: val)
            counts[index] = preSmallCount
        } else if node!.val == val {
            node!.count += 1
            counts[index] = preSmallCount + node!.smallCount
        } else if node!.val < val {
            node!.right = insert(&node!.right, val, index, &counts, preSmallCount+node!.smallCount+node!.count)
        } else {
            node!.smallCount += 1
            node!.left = insert(&node!.left, val, index, &counts, preSmallCount)
        }
        return node
    }
}

class TreeNode {
    var left: TreeNode?
    var right: TreeNode?
    
    // node value 
    var val = 0
    
    // number which have same value node
    var count = 1 
    
    // number of left children(smaller value)
    var smallCount = 0
    
    init(val: Int) {
        self.val = val
    }
}