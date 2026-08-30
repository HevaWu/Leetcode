/*
You are given a 0-indexed array of distinct integers nums.

There is an element in nums that has the lowest value and an element that has the highest value. We call them the minimum and maximum respectively. Your goal is to remove both these elements from the array.

A deletion is defined as either removing an element from the front of the array or removing an element from the back of the array.

Return the minimum number of deletions it would take to remove both the minimum and maximum element from the array.



Example 1:

Input: nums = [2,10,7,5,4,1,8,6]
Output: 5
Explanation:
The minimum element in the array is nums[5], which is 1.
The maximum element in the array is nums[1], which is 10.
We can remove both the minimum and maximum by removing 2 elements from the front and 3 elements from the back.
This results in 2 + 3 = 5 deletions, which is the minimum number possible.
Example 2:

Input: nums = [0,-4,19,1,8,-2,-3,5]
Output: 3
Explanation:
The minimum element in the array is nums[1], which is -4.
The maximum element in the array is nums[2], which is 19.
We can remove both the minimum and maximum by removing 3 elements from the front.
This results in only 3 deletions, which is the minimum number possible.
Example 3:

Input: nums = [101]
Output: 1
Explanation:
There is only one element in the array, which makes it both the minimum and maximum element.
We can remove it with 1 deletion.


Constraints:

1 <= nums.length <= 105
-105 <= nums[i] <= 105
The integers in nums are distinct.
*/

/*
Solution 1:
Iterate array to find the minVal index and maxVal index
check all 4 possibility to take either front or back

Time Complexity: O(n)
*/
class Solution {
    func minimumDeletions(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 1 { return 1 }
        if n == 2 { return 2 }
        var minIndex = 0
        var maxIndex = 0
        var minVal = nums[0]
        var maxVal = nums[0]

        for i in 0..<n {
            if nums[i] < minVal {
                minIndex = i
                minVal = nums[i]
            }
            if nums[i] > maxVal {
                maxIndex = i
                maxVal = nums[i]
            }
        }
        // print(minIndex, maxIndex)
        return min(
            min(
                // both take from front
                max(minIndex, maxIndex)+1,
                // both take from back
                max(n-minIndex, n-maxIndex)
            ),
            min(
                // take min from front, max from back
                minIndex+1+(n-maxIndex),
                // take min from back, max from front
                (n-minIndex)+maxIndex+1
            )
        )
    }
}
