/*
Given an array of integers target. From a starting array, A consisting of all 1's, you may perform the following procedure :

let x be the sum of all elements currently in your array.
choose index i, such that 0 <= i < target.size and set the value of A at index i to x.
You may repeat this procedure as many times as needed.
Return True if it is possible to construct the target array from A otherwise return False.



Example 1:

Input: target = [9,3,5]
Output: true
Explanation: Start with [1, 1, 1]
[1, 1, 1], sum = 3 choose index 1
[1, 3, 1], sum = 5 choose index 2
[1, 3, 5], sum = 9 choose index 0
[9, 3, 5] Done
Example 2:

Input: target = [1,1,1,2]
Output: false
Explanation: Impossible to create target array from [1,1,1,1].
Example 3:

Input: target = [8,5]
Output: true


Constraints:

N == target.length
1 <= target.length <= 5 * 10^4
1 <= target[i] <= 10^9
*/

/*
Solution 1:
Time Limit Exceeded

Idea:
- Given that the sum is strictly increasing, the largest element in the target must be formed in the last step by adding the total sum in the previous step. Thus, we can simulate the process in a reversed way.
- Subtract the largest with the rest of the array, and put the new element into the array. Repeat until all elements become one

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func isPossible(_ target: [Int]) -> Bool {
        let n = target.count
        if n == 1 { return target[0] == 1 }

        var sum = 0
        var sortedArr = [Int]()
        for i in 0..<n {
            sum += target[i]
            insert(target[i], &sortedArr)
        }

        while true {
            let largest = sortedArr.removeLast()
            sum -= largest

            if sum == 1 || largest == 1 {
                return true
            }

            // make sure largest alwasy larger than remain sum
            // otherwise, it is impossible to make largest from remaining sum
            if largest < sum || sum == 0 || largest % sum == 0 {
                return false
            }

            // replace "largest" with "remain"
            let remain = largest % sum
            sum += remain
            insert(remain, &sortedArr)
        }

        return false
    }

    func insert(_ target: Int, _ nums: inout [Int]) {
        if nums.isEmpty {
            nums.append(target)
            return
        }

        var left = 0
        var right = nums.count-1
        while left < right {
            let mid = left + (right-left)/2
            if nums[mid] < target {
                left = mid+1
            } else {
                right = mid-1
            }
        }

        nums.insert(target, at: (nums[left] < target ? left+1 : left))
    }
}