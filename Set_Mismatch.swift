/*
You have a set of integers s, which originally contains all the numbers from 1 to n. Unfortunately, due to some error, one of the numbers in s got duplicated to another number in the set, which results in repetition of one number and loss of another number.

You are given an integer array nums representing the data status of this set after the error.

Find the number that occurs twice and the number that is missing and return them in the form of an array.

 

Example 1:

Input: nums = [1,2,2,4]
Output: [2,3]
Example 2:

Input: nums = [1,1]
Output: [1,2]
 

Constraints:

2 <= nums.length <= 104
1 <= nums[i] <= 104
*/

/*
Solution 3:

Before we dive into the solution to this problem, let's consider a simple problem. Consider an array with n-1n−1 elements containing numbers from 11 to nn with one number missing out of them. Now, how to we find out this missing element. One of the solutions is to take the XOR of all the elements of this array with all the numbers from 11 to nn. By doing so, we get the required missing number. This works because XORing a number with itself results in a 0 result. Thus, only the number which is missing can't get cancelled with this XORing.

Now, using this idea as the base, let's take it a step forward and use it for the current problem. By taking the XOR of all the elements of the given numsnums array with all the numbers from 11 to nn, we will get a result, xorxor, as x^yx 
y
 . Here, xx and yy refer to the repeated and the missing term in the given numsnums array. This happens on the same grounds as in the first problem discussed above.

Now, in the resultant xorxor, we'll get a 1 in the binary representation only at those bit positions which have a 1 in one out of the numbers xx and yy, and a 0 at the same bit position in the other one. In the current solution, we consider the rightmost bit which is 1 in the xorxor, although any bit would work. Let's say, this position is called the rightmostbitrightmostbit.

If we divide the elements of the given numsnums array into two parts such that the first set contains the elements which have a 1 at the rightmostbitrightmostbit position and the second set contains the elements having a 0 at the same position, we'll get one out of xx or yy in one set and the other one in the second set. Now, our problem has reduced somewhat to the simple problem discussed above.

To solve this reduced problem, we can find out the elements from 11 to nn and consider them as a part of the previous sets only, with the allocation of the set depending on a 1 or 0 at the righmostbitrighmostbit position.

Now, if we do the XOR of all the elements of the first set, all the elements will result in an XOR of 0, due to cancellation of the similar terms in both numsnums and the numbers (1:n)(1:n), except one term, which is either xx or yy.

For the other term, we can do the XOR of all the elements in the second set as well.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func findErrorNums(_ nums: [Int]) -> [Int] { 
        let n = nums.count
        
        var xor = 0
        for i in 0..<n {
            xor ^= (i+1)
            xor ^= nums[i]
        }
        
        var rightmostbit = xor & ~(xor-1)
        var xor1 = 0
        var xor0 = 0
        
        for i in 0..<n {
            if (nums[i] & rightmostbit) != 0 {
                xor1 ^= nums[i]
            } else {
                xor0 ^= nums[i]
            }
            
            if ((i+1) & rightmostbit) != 0 {
                xor1 ^= (i+1)
            } else {
                xor0 ^= (i+1)
            }
        }
        
        for num in nums {
            if num == xor0 {
                return [xor0, xor1]
            }
        }
        
        return [xor1, xor0]
    }
}

/*
Solution 2
use constant space

array element will be 1...n
we can use it as nums index

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func findErrorNums(_ nums: [Int]) -> [Int] {        
        var nums = nums
        
        var repetition: Int = 0
        var missing: Int = 0
        
        for num in nums {
            let index = abs(num)-1
            if nums[index] < 0 {
                repetition = num
            } else {
                nums[index] = -nums[index]
            }
        }
        
        for i in 0..<nums.count {
            if nums[i] > 0 {
                missing = i+1
                break
            }
        }
        return [repetition, missing]
    }
}

/*
Solution 1:
set 

iteratively checking if num is repetition nums

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func findErrorNums(_ nums: [Int]) -> [Int] {
        var set: Set<Int> = Set(1...nums.count)
        var repetition: Int = 0
        for num in nums {
            if !set.contains(num) {
                repetition = num
            } else {
                set.remove(num)
            }
        }
        return [repetition, set.first!]
    }
}