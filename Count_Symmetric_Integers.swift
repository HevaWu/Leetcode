/*
You are given two positive integers low and high.

An integer x consisting of 2 * n digits is symmetric if the sum of the first n digits of x is equal to the sum of the last n digits of x. Numbers with an odd number of digits are never symmetric.

Return the number of symmetric integers in the range [low, high].



Example 1:

Input: low = 1, high = 100
Output: 9
Explanation: There are 9 symmetric integers between 1 and 100: 11, 22, 33, 44, 55, 66, 77, 88, and 99.
Example 2:

Input: low = 1200, high = 1230
Output: 4
Explanation: There are 4 symmetric integers between 1200 and 1230: 1203, 1212, 1221, and 1230.


Constraints:

1 <= low <= high <= 104
*/


/*
Solution 2:
Iterate number, separate by two digits or four digits, then compare

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func countSymmetricIntegers(_ low: Int, _ high: Int) -> Int {
        var count = 0
        for num in low...high {
            if num < 100 {
                // two digits
                if num % 11 == 0 {
                    count += 1
                }
            } else if num >= 1000, num < 10000 {
                // four digits
                var left = num / 1000 + (num % 1000) / 100
                var right = (num % 100) / 10 + num % 10
                if left == right {
                    count += 1
                }
                // print(left, right)
            }
        }
        return count
    }
}

/*
Solution 1:
Iterate all numbers between low and high
Then check symmetric or not

Time Complexity: O(n)
- n is number count between low and high
Space Complexity: O(1)
*/
class Solution {
    func countSymmetricIntegers(_ low: Int, _ high: Int) -> Int {
        var count = 0
        for num in low...high {
            if isSymmetric(num) {
                count += 1
            }
        }
        return count
    }

    func isSymmetric(_ num: Int) -> Bool {
        var numArr = getNumArr(num)
        let n = numArr.count
        if n % 2 != 0 { return false }
        // compare first half(0..<n/2) and second half(n/2..<n)
        var firstHalf = sumFromArr(numArr, 0, n/2)
        var secondHalf = sumFromArr(numArr, n/2, n)
        return firstHalf == secondHalf
    }

    func getNumArr(_ num: Int) -> [Int] {
        var res = [Int]()
        var num = num
        while num != 0 {
            res.insert(num%10, at: 0)
            num /= 10
        }
        return res
    }

    func sumFromArr(_ numArr: [Int], _ s: Int, _ e: Int) -> Int {
        var res = 0
        for i in s..<e {
            res += numArr[i]
        }
        return res
    }
}
