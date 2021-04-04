/*
You are given an array nums that consists of positive integers.

The GCD of a sequence of numbers is defined as the greatest integer that divides all the numbers in the sequence evenly.

For example, the GCD of the sequence [4,6,16] is 2.
A subsequence of an array is a sequence that can be formed by removing some elements (possibly none) of the array.

For example, [2,5,10] is a subsequence of [1,2,1,2,4,1,5,10].
Return the number of different GCDs among all non-empty subsequences of nums.



Example 1:


Input: nums = [6,10,3]
Output: 5
Explanation: The figure shows all the non-empty subsequences and their GCDs.
The different GCDs are 6, 10, 3, 2, and 1.
Example 2:

Input: nums = [5,15,40,5,6]
Output: 7


Constraints:

1 <= nums.length <= 105
1 <= nums[i] <= 2 * 105
*/

/*
Solution 2:

test every number from 1...200001 to see if it can be a valid gcd

Time Complexity: O(n * logn)
*/
class Solution {
    func countDifferentSubsequenceGCDs(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 1 { return 1 }

        let size = 200001
        var factor = Array(repeating: false, count: size)
        for num in nums {
            factor[num] = true
        }

        var valid = 0
        for i in 1..<size {
            var f = 0

            // check all number with factor i
            var x = i
            while f != i, x < size{
                if factor[x] {
                    f = getGCD(f, x)
                }
                x += i
            }

            // factor i can be common gcd in nums
            if f == i {
                valid += 1
            }
        }

        return valid
    }

    // get gcd of a, b
    func getGCD(_ a: Int, _ b: Int) -> Int {
        var t = 0
        var a = a
        var b = b
        while b != 0 {
            t = a
            a = b
            b = t % b
        }

        return a
    }
}

/*
Solution 1:
Time limit exceeded

- for each number, check its gcd with previous list

Time Complexity: O(2^n)
Space Complexity: O(n)
*/
class Solution {
    func countDifferentSubsequenceGCDs(_ nums: [Int]) -> Int {
        var nums = Array(Set(nums))

        let n = nums.count
        if n == 1 { return 1 }

        var gcd = Set<Int>()
        gcd.insert(nums[0])

        for i in 1..<n {
            if gcd.contains(nums[i]) { continue }

            for f in gcd {
                gcd.insert(getGCD(f, nums[i]))
            }
            // this number itself should be a single GCD
            gcd.insert(nums[i])
        }

        // print(gcd)
        return gcd.count
    }

    func getGCD(_ a: Int, _ b: Int) -> Int {
        print(a, b)
        var t = 0
        var a = a
        var b = b
        while b != 0 {
            t = a
            a = b
            b = t % b
        }
        return a
    }
}