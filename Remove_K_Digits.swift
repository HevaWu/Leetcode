/*
Given string num representing a non-negative integer num, and an integer k, return the smallest possible integer after removing k digits from num.



Example 1:

Input: num = "1432219", k = 3
Output: "1219"
Explanation: Remove the three digits 4, 3, and 2 to form the new number 1219 which is the smallest.
Example 2:

Input: num = "10200", k = 1
Output: "200"
Explanation: Remove the leading 1 and the number is 200. Note that the output must not contain leading zeroes.
Example 3:

Input: num = "10", k = 2
Output: "0"
Explanation: Remove all the digits from the number and it is left with nothing which is 0.


Constraints:

1 <= k <= num.length <= 105
num consists of only digits.
num does not have any leading zeros except for the zero itself.
*/

/*
Solution 1;
use "remain" to keep the size of the ret string
start from the begin of string, if current int smaller than former int, pop former character
out, push current in
after pushing, resize to shorten the size to "remain" size
then remove the first 0

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func removeKdigits(_ num: String, _ k: Int) -> String {
        var remain = num.count - k
        var num = Array(num)
        var ret = Array(repeating: Character("*"), count: remain)
        var index = 0
        for i in 0..<num.count {
            while num.count-i > remain - index, index > 0, ret[index-1] > num[i] {
                index -= 1
            }
            if index < remain {
                ret[index] = num[i]
                index += 1
            }
        }
        index = 0
        while index < remain, ret[index] == Character("0") {
            index += 1
        }
        var s = String(ret[index...])
        return s.count == 0 ? "0" : s
    }
}
