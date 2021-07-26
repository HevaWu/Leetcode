/*
Given an array nums of distinct positive integers, return the number of tuples (a, b, c, d) such that a * b = c * d where a, b, c, and d are elements of nums, and a != b != c != d.



Example 1:

Input: nums = [2,3,4,6]
Output: 8
Explanation: There are 8 valid tuples:
(2,6,3,4) , (2,6,4,3) , (6,2,3,4) , (6,2,4,3)
(3,4,2,6) , (4,3,2,6) , (3,4,6,2) , (4,3,6,2)
Example 2:

Input: nums = [1,2,4,5,10]
Output: 16
Explanation: There are 16 valids tuples:
(1,10,2,5) , (1,10,5,2) , (10,1,2,5) , (10,1,5,2)
(2,5,1,10) , (2,5,10,1) , (5,2,1,10) , (5,2,10,1)
(2,10,4,5) , (2,10,5,4) , (10,2,4,5) , (10,2,4,5)
(4,5,2,10) , (4,5,10,2) , (5,4,2,10) , (5,4,10,2)
Example 3:

Input: nums = [2,3,4,6,8,12]
Output: 40
Example 4:

Input: nums = [2,3,5,7]
Output: 0


Constraints:

1 <= nums.length <= 1000
1 <= nums[i] <= 104
All elements in nums are distinct.

Hint:
Note that all of the integers are distinct. This means that each time a product is formed it must be formed by two unique integers.
Count the frequency of each product of 2 distinct numbers. Then calculate the permutations formed.
*/

/*
Solution 1:

count freq of each product of 2 distinct number, same them into map,
then calculate the permutation

once we find 2 pairs, there will be 8 possible arrangements

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func tupleSameProduct(_ nums: [Int]) -> Int {
        let n = nums.count

        // key is product, val is how many pair of element is this product val
        var product = [Int: Int]()

        for i in 0..<(n-1) {
            for j in (i+1)..<n {
                product[nums[i] * nums[j], default: 0] += 1
            }
        }

        // get permulation
        // once find 2 pairs, there are 8 possibilities
        var res = 0
        for val in product.values {
            if val >= 2 {
                res += val * (val-1) / 2 * 8
            }
        }
        return res
    }
}