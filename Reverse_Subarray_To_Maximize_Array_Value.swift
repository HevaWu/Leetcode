/*
You are given an integer array nums. The value of this array is defined as the sum of |nums[i]-nums[i+1]| for all 0 <= i < nums.length-1.

You are allowed to select any subarray of the given array and reverse it. You can perform this operation only once.

Find maximum possible value of the final array.



Example 1:

Input: nums = [2,3,1,5,4]
Output: 10
Explanation: By reversing the subarray [3,1,5] the array becomes [2,5,1,3,4] whose value is 10.
Example 2:

Input: nums = [2,4,9,24,2,1,10]
Output: 68


Constraints:

1 <= nums.length <= 3*10^4
-10^5 <= nums[i] <= 10^5
*/

/*
Solution 2:
Assume the list is : x, y, ..., a, [b, ..., c], d, ..., and we are going to reverse [b, ..., c]. We are now going to look at how the value will change after reversion.

It will only have two situations: interval [min(a,b), max(a,b)]intersects with [min(c,d), max(c,d)] or not.

interval [min(a,b), max(a,b)] does intersect with [min(c,d), max(c,d)].

Note that the reversion will not change abs(nums[i] - nums[i+1]), except for a, b, c, and d. Hence the amount of total value change is -[abs(a-b)+abs(c-d)] + [abs(a-c)+abs(b-d)]
Now try to draw them in the graph. There will be two patterns of graph. Let's check the first one.image
The two red lines represent abs(a-b) and abs(c-d). The blue and green lines represent two possible results for [abs(a-c)+abs(b-d)]. Therefore, the total change is the difference of the total length of red lines and blue/green lines. Note that in this situation the total change can not be positive. So we will not reverse [b, ..., c] in this situation.

For another pattern:
image

Simiarly, we also will not reverse [b, ..., c] in this situation.

interval [min(a,b), max(a,b)] does not intersect with [min(c,d), max(c,d)].
Similarly, total value change is still -[abs(a-b)+abs(c-d)]+[abs(a-c)+abs(b-d)]. Now try to draw them.image
As same as above, the two red lines represent abs(a-b) and abs(c-d). The blue and green lines represent two possible results for [abs(a-c)+abs(b-d)]. Notice that the total lengths of the blue lines and green lines are the same. In this situation, the total change is the difference of the total length of red lines and blue/green lines, which is two times the length of the yellow line.

Therefore, we only need to find the maximum length of the yellow line, and then times 2 and plus the original value.

Notice length of the yellow line = min(c,d) - max(a,b), we only need to find out max(min(c,d) for any c,d) and min(max(a,b) for any a,b)). An iteration is enough.

Don't forget the boundary situation where b is nums[0] or c is nums[n-1]. Just another iteration will do.
*/
class Solution {
    func maxValueAfterReverse(_ nums: [Int]) -> Int {
        let n = nums.count
        var current = 0
        for i in 0..<(n-1) {
            current += abs(nums[i] - nums[i+1])
        }

        var maxAB = Int.min
        var minAB = Int.max
        for a in 0..<(n-1) {
            maxAB = max(maxAB, min(nums[a], nums[a+1]))
            minAB = min(minAB, max(nums[a], nums[a+1]))
        }
        var diff = max(0, (maxAB - minAB) * 2)

        // for boundary
        for i in 0..<(n-1) {
            // subarray stars at 0
            diff = max(diff, abs(nums[0] - nums[i+1]) - abs(nums[i] - nums[i+1]))
            // subarry ends at n-1
            diff = max(diff, abs(nums[i] - nums[n-1]) - abs(nums[i] - nums[i+1]))
        }
        return current + diff
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func maxValueAfterReverse(_ nums: [Int]) -> Int {
        var current = 0
        let n = nums.count

        for i in 0..<(n-1) {
            current += abs(nums[i] - nums[i+1])
        }

        var diff = 0
        for i in 0..<(n-1) {
            for j in (i+1)..<n {
                if i == 0, j < n-1 {
                    diff = max(diff, abs(nums[0] - nums[j+1]) - abs(nums[j] - nums[j+1]))
                } else if j == n-1, i > 0 {
                    diff = max(diff, abs(nums[i-1] - nums[j]) - abs(nums[i-1] - nums[i]))
                } else if i > 0, j < n-1 {
                    // i...j
                    // i-1,i,  j,j+1
                    // i-1,j,  i,j+1
                    diff = max(
                        diff,
                        abs(nums[i-1] - nums[j]) + abs(nums[i] - nums[j+1])
                        - (abs(nums[i-1] - nums[i]) + abs(nums[j] - nums[j+1]))
                    )
                    // print("ij", diff)
                }
                // print(diff, i, j)
            }
        }

        // print(current, diff)
        return current + diff
    }
}