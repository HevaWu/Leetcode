/*
We have an array nums of integers, and an array queries of queries.

For the i-th query val = queries[i][0], index = queries[i][1], we add val to nums[index].  Then, the answer to the i-th query is the sum of the even values of A.

(Here, the given index = queries[i][1] is a 0-based index, and each query permanently modifies the array nums.)

Return the answer to all queries.  Your answer array should have answer[i] as the answer to the i-th query.



Example 1:

Input: nums = [1,2,3,4], queries = [[1,0],[-3,1],[-4,0],[2,3]]
Output: [8,6,2,4]
Explanation:
At the beginning, the array is [1,2,3,4].
After adding 1 to nums[0], the array is [2,2,3,4], and the sum of even values is 2 + 2 + 4 = 8.
After adding -3 to nums[1], the array is [2,-1,3,4], and the sum of even values is 2 + 4 = 6.
After adding -4 to nums[0], the array is [-2,-1,3,4], and the sum of even values is -2 + 4 = 2.
After adding 2 to nums[3], the array is [-2,-1,3,6], and the sum of even values is -2 + 6 = 4.


Note:

1 <= nums.length <= 10000
-10000 <= nums[i] <= 10000
1 <= queries.length <= 10000
-10000 <= queries[i][0] <= 10000
0 <= queries[i][1] < nums.length
*/

/*
Solution 1:
iterate array, keep evenSum as record

Time Complexity: O(n + m)
Space Complexity: O(n)
*/
class Solution {
    func sumEvenAfterQueries(_ nums: [Int], _ queries: [[Int]]) -> [Int] {
        var evenSum = 0
        for num in nums {
            if num % 2 == 0 {
                evenSum += num
            }
        }

        var nums = nums
        return queries.map { q -> Int in
            let index = q[1]
            let val = q[0]

            let original = nums[index]
            let newVal = nums[index] + val
            if original % 2 == 0 {
                evenSum -= original
            }
            if newVal % 2 == 0 {
                evenSum += newVal
            }

            nums[index] = newVal
            return evenSum
        }
    }
}