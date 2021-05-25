/*
Given two non-negative integers, num1 and num2 represented as string, return the sum of num1 and num2 as a string.

You must solve the problem without using any built-in library for handling large integers (such as BigInteger). You must also not convert the inputs to integers directly.



Example 1:

Input: num1 = "11", num2 = "123"
Output: "134"
Example 2:

Input: num1 = "456", num2 = "77"
Output: "533"
Example 3:

Input: num1 = "0", num2 = "0"
Output: "0"


Constraints:

1 <= num1.length, num2.length <= 104
num1 and num2 consist of only digits.
num1 and num2 don't have any leading zeros except for the zero itself.

*/

/*
Solution 1:
convert each num to intArr first,
then add num to intArr
then final convert intArr to string

Time Complexity: O(max(n1, n2))
Space Complexity: O(n1 + n2)
*/
class Solution {
    func addStrings(_ num1: String, _ num2: String) -> String {
        var num1 = num1.map { $0.wholeNumberValue! }
        var num2 = num2.map { $0.wholeNumberValue! }

        let n1 = num1.count
        let n2 = num2.count

        var i1 = n1-1
        var i2 = n2-1

        var addArr = [Int]()
        var cur = 0
        while i1 >= 0, i2 >= 0 {
            cur += num1[i1] + num2[i2]
            addArr.insert(cur % 10, at: 0)
            cur /= 10
            i1 -= 1
            i2 -= 1
        }

        while i1 >= 0 {
            cur += num1[i1]
            addArr.insert(cur % 10, at: 0)
            cur /= 10
            i1 -= 1
        }

        while i2 >= 0 {
            cur += num2[i2]
            addArr.insert(cur % 10, at: 0)
            cur /= 10
            i2 -= 1
        }

        if cur != 0 {
            addArr.insert(cur, at: 0)
        }

        var str = String()
        for num in addArr {
            str.append(String(num))
        }
        return str
    }
}