/*
Given an integer array nums of 2n integers, group these integers into n pairs (a1, b1), (a2, b2), ..., (an, bn) such that the sum of min(ai, bi) for all i is maximized. Return the maximized sum.

 

Example 1:

Input: nums = [1,4,3,2]
Output: 4
Explanation: All possible pairings (ignoring the ordering of elements) are:
1. (1, 4), (2, 3) -> min(1, 4) + min(2, 3) = 1 + 2 = 3
2. (1, 3), (2, 4) -> min(1, 3) + min(2, 4) = 1 + 2 = 3
3. (1, 2), (3, 4) -> min(1, 2) + min(3, 4) = 1 + 3 = 4
So the maximum possible sum is 4.
Example 2:

Input: nums = [6,2,6,5,1,2]
Output: 9
Explanation: The optimal pairing is (2, 1), (2, 5), (6, 6). min(2, 1) + min(2, 5) + min(6, 6) = 1 + 2 + 6 = 9.
 

Constraints:

1 <= n <= 104
nums.length == 2 * n
-104 <= nums[i] <= 104
*/

/*
Solution 2

Since the range of elements in the given array is limited, we can make use of a hashmap arrarr, such that arr[i] stores the frequency of occurence of (i-10000)^{th} element. This subtraction is done so as to be able to map the numbers in the range -10000 ≤ i ≤ -1 onto the hashmap.

Thus, now instead of sorting the array's elements, we can directly traverse the hashmap in an ascending order. But, any element could also occur multiple times in the given array. We need to take this factor into account.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func arrayPairSum(_ nums: [Int]) -> Int {
        var arr = Array(repeating: 0, count: 20001)
        
        var lim = 10000
        for num in nums {
            arr[num+lim] += 1
        }
        
        var d = 0
        var res = 0
        
        for i in -10000...10000 {
            res += (arr[i + lim] + 1 - d ) / 2 * i
            d = (2 + arr[i + lim] - d) % 2
        }
        
        return res
    }
}

/*
Solution 1
sort array first
1,2,3,4,...,n
then always pick even index (this will always be min of pair)

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func arrayPairSum(_ nums: [Int]) -> Int {
        var nums = nums.sorted()
        var res = 0
        var i = 0
        while i < nums.count {
            res += nums[i]
            i += 2
        }
        return res
    }
}