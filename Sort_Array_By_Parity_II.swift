/*
Given an array of integers nums, half of the integers in nums are odd, and the other half are even.

Sort the array so that whenever nums[i] is odd, i is odd, and whenever nums[i] is even, i is even.

Return any answer array that satisfies this condition.



Example 1:

Input: nums = [4,2,5,7]
Output: [4,5,2,7]
Explanation: [4,7,2,5], [2,5,4,7], [2,7,4,5] would also have been accepted.
Example 2:

Input: nums = [2,3]
Output: [2,3]


Constraints:

2 <= nums.length <= 2 * 104
nums.length is even.
Half of the integers in nums are even.
0 <= nums[i] <= 1000


Follow Up: Could you solve it in-place?
*/

/*
Solution 2:
For each even i, let's make A[i] even. To do it, we will draft an element from the odd slice. We pass j through the odd slice until we find an even element, then swap. Our invariant is maintained, so the algorithm is correct.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func sortArrayByParityII(_ nums: [Int]) -> [Int] {
        var nums = nums
        let n = nums.count
        var j = 1
        for i in stride(from: 0, to: n, by: 2) {
            if nums[i] % 2 == 1 {
                while j < n, nums[j] % 2 == 1 {
                    j += 2
                }
                nums.swapAt(i, j)
            }
        }
        return nums
    }
}

/*
Solution 1:
use even, odd stack to store current pending for shift index
- even stack: save pending for shift index of even number
- odd stack: save pending for shift index of odd number

Time Complexity: O(n)
Space Complexity: O(n/2)
*/
class Solution {
    func sortArrayByParityII(_ nums: [Int]) -> [Int] {
        var nums = nums
        let n = nums.count

        // index stack to record pending waiting for shift index
        var odd = [Int]()
        var even = [Int]()
        for i in 0..<n {
            if i % 2 == 0 {
                if nums[i] % 2 == 0 {
                    continue
                } else {
                    // find odd number in even index
                    if odd.isEmpty {
                        even.append(i)
                    } else {
                        // shift with pending odd index
                        nums.swapAt(odd.removeLast(), i)
                    }
                }
            } else {
                if nums[i] % 2 == 1 {
                    continue
                } else {
                    if even.isEmpty {
                        odd.append(i)
                    } else {
                        nums.swapAt(even.removeLast(), i)
                    }
                }
            }
        }

        return nums
    }
}