/*
Given an array nums of integers, you can perform operations on the array.

In each operation, you pick any nums[i] and delete it to earn nums[i] points. After, you must delete every element equal to nums[i] - 1 or nums[i] + 1.

You start with 0 points. Return the maximum number of points you can earn by applying such operations.



Example 1:

Input: nums = [3,4,2]
Output: 6
Explanation: Delete 4 to earn 4 points, consequently 3 is also deleted.
Then, delete 2 to earn 2 points.
6 total points are earned.
Example 2:

Input: nums = [2,2,3,3,3,4]
Output: 9
Explanation: Delete 3 to earn 3 points, deleting both 2's and the 4.
Then, delete 3 again to earn 3 points, and 3 again to earn 3 points.
9 total points are earned.


Constraints:

1 <= nums.length <= 2 * 104
1 <= nums[i] <= 104
*/

/*
Solution 2:
DP

- sort nums first,
- use map to store frequency for each num
  * using: max earn point when we pick keys[i]
  * avoid: max earn point when we NOT pick keys[i]
- each time, compare current key with previous key, and update using & avoid
- return max(using, avoid) at the end

Time Complexity: O(n + klogk)
- n == nums.count
- k == keys.count

Space Complexity: O(k)
*/
class Solution {
    func deleteAndEarn(_ nums: [Int]) -> Int {
        var map = [Int: Int]()
        for num in nums {
            map[num, default: 0] += 1
        }

        var keys = map.keys.sorted()
        let n = keys.count
        if n == 1 { return keys[0] * map[keys[0]]! }

        // avoid[i], max earn point when not pick keys[i]
        var avoid = 0

        // using[i], max earn point when pick keys[i]
        var using = map[keys[0]]! * keys[0]

        for i in 1..<n {
            let val = max(avoid, using)
            if keys[i] - keys[i-1] > 1 {
                // previsous key is not adjacent
                using = map[keys[i]]! * keys[i] + val
                avoid = val
            } else {
                using = map[keys[i]]! * keys[i] + avoid
                avoid = val
            }
        }

        return max(avoid, using)
    }
}

/*
Solution 1:
backTrack

TLE
*/
class Solution {
    func deleteAndEarn(_ nums: [Int]) -> Int {
        var maxPoint = 0
        check(nums, 0, &maxPoint)
        return maxPoint
    }

    func check(_ nums: [Int], _ cur: Int, _ maxPoint: inout Int) {
        if nums.isEmpty {
            maxPoint = max(maxPoint, cur)
            return
        }

        var nums = nums
        for i in 0..<nums.count {
            let val = nums[i]
            nums.remove(at: i)
            var next = [Int]()
            for num in nums {
                if num != val-1 && num != val+1 {
                    next.append(num)
                }
            }
            check(next, cur+val, &maxPoint)
            nums.insert(val, at: i)
        }
    }
}