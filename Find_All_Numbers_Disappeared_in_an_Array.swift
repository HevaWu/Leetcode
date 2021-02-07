/*
Given an array of integers where 1 ≤ a[i] ≤ n (n = size of array), some elements appear twice and others appear once.

Find all the elements of [1, n] inclusive that do not appear in this array.

Could you do it without extra space and in O(n) runtime? You may assume the returned list does not count as extra space.

Example:

Input:
[4,3,2,7,8,2,3,1]

Output:
[5,6]

Hint 1
This is a really easy problem if you decide to use additional memory. For those trying to write an initial solution using additional memory, think counters!

Hint 2
However, the trick really is to not use any additional space than what is already available to use. Sometimes, multiple passes over the input array help find the solution. However, there's an interesting piece of information in this problem that makes it easy to re-use the input array itself for the solution.

Hint 3:
The problem specifies that the numbers in the array will be in the range [1, n] where n is the number of elements in the array. Can we use this information and modify the array in-place somehow to find what we need?
*/

/*
Soluton 2:
nums[i] is in 1...n
we can use nums[i] as index
1. go through nums, if index nums[i] appeared, convert nums[i] as -nums[i]
2. go through nums again, if nums[i] > 0, append i into res

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [] }
        
        var nums = nums
        var res = [Int]()
        
        let n = nums.count
        for i in 0..<n {
            // - 1 to match array index
            let index = abs(nums[i]) - 1
            if nums[index] > 0 {
                nums[index] = -nums[index]
            }
        }
        
        for i in 0..<n where nums[i] > 0 {
            res.append(i+1)
        }
        
        return res
    }
}

/*
Solution 1:
sort array
then find missing one

Time Complexity: O(nlogn)
Space Complexity: O(1)
*/
class Solution {
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        guard !nums.isEmpty else { return [] }
        
        var nums = nums.sorted()
        var res = [Int]()
        let n = nums.count
        
        if nums[0] != 1 {
            for j in 1..<nums[0] {
                res.append(j)
            }
        }
        var pre = nums[0]
        
        for i in 1..<n {
            if nums[i]-pre > 1 {
                for j in (pre+1)..<nums[i] {
                    res.append(j)
                }
            }
            pre = nums[i]
        }
        
        if pre != n {
            for j in (pre+1)...n {
                res.append(j)
            }
        }
        return res
    }
}