/*
You are given an array of integers nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.

Return the max sliding window.

 

Example 1:

Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [3,3,5,5,6,7]
Explanation: 
Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
Example 2:

Input: nums = [1], k = 1
Output: [1]
Example 3:

Input: nums = [1,-1], k = 1
Output: [1,-1]
Example 4:

Input: nums = [9,11], k = 2
Output: [11]
Example 5:

Input: nums = [4,-2], k = 2
Output: [4]
 

Constraints:

1 <= nums.length <= 105
-104 <= nums[i] <= 104
1 <= k <= nums.length
*/

/*
Solution 2:

Idea -
    
	Can we do better to improve the algorithm?

	Yes, we can split the array into blocks. Each block is of size k, the last block would contain the rest of elements that couldn't fit into k (n % k). This gives us two situations, the first element i and last element j for a window can be placed completely inside a block, or it CAN NOT. We then use DP to solve this problem. 

	First situation is simple to solve. We can maintain an array `left`, where left[i] is the max element from the beginning of the block (let's say the index block_start) to index i. Direction of this array is from left to right.

	To resolve the second situation, we use another array `right`. where right[i] is the max element from the end of block (index block_end per say) to index i. Direction would be from right to left.

	The two arrays together give us all the information about window elements. If we consider a sliding window from index i to j. By definition, right[i] is a maximum element for all window elements in the leftside block; left[j] is a maximum element for all window elements in the rightside block. Hence, the maximum element in the current sliding window is max(right[i], left[j]).

For Example: A = [2,1,3,4,6,3,8,9,10,12,56], w=4

partition the array in blocks of size w=4. The last block may have less then w.
2, 1, 3, 4 | 6, 3, 8, 9 | 10, 12, 56|

Traverse the list from start to end and calculate max_so_far. Reset max after each block boundary (of w elements).
left_max[] = 2, 2, 3, 4 | 6, 6, 8, 9 | 10, 12, 56

Similarly calculate max in future by traversing from end to start.
right_max[] = 4, 4, 4, 4 | 9, 9, 9, 9 | 56, 56, 56

now, sliding max at each position i in current window, sliding-max(i) = max{right_max(i), left_max(i+w-1)}
sliding_max = 4, 6, 6, 8, 9, 10, 12, 56

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        if k == 1 { return nums }
        
        let n = nums.count
        
        var left = Array(repeating: 0, count: n)
        var right = Array(repeating: 0, count: n)
        left[0] = nums[0]
        right[n-1] = nums[n-1]
        
        for i in 1..<n {
            if i % k == 0 {
                left[i] = nums[i]
            } else {
                left[i] = max(left[i-1], nums[i])
            }
            
            let j = n-i-1
            if (j+1) % k == 0 {
                right[j] = nums[j]
            } else {
                right[j] = max(right[j+1], nums[j])
            }
        }
        
        var window = [Int]()
        for i in 0...(n-k) {
            window.append(max(left[i+k-1], right[i]))
        }
        
        return window
    }
}

/*
Solution 1:
always store k window elements in a sorted queue[k]

Time Complexity: O(n * log k)
Space Complexity: O(k)
*/
class Solution {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        if k == 1 { return nums }
        
        let n = nums.count
        
        var queue = [nums[0]]
        for i in 1..<k {
            insert(nums[i], in: &queue)
        }
        
        // returned max sliding window
        var window: [Int] = [queue.last!]
        
        if k == n { return window }
        
        for i in k..<n {
            remove(nums[i-k], in: &queue)
            insert(nums[i], in: &queue)
            window.append(queue.last!)
        }
        return window
    }
    
    func insert(_ num: Int, in arr: inout [Int]) {
        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] < num {
                left = mid+1
            } else {
                right = mid
            }
        }
        
        if arr[left] < num {
            left += 1
        }
        arr.insert(num, at: left)
    }
    
    func remove(_ num: Int, in arr: inout [Int]) {
        var left = 0
        var right = arr.count-1
        while left <= right {
            let mid = left+(right-left)/2
            if arr[mid] == num { 
                arr.remove(at: mid)
                return
            } else if arr[mid] < num {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
    }
}