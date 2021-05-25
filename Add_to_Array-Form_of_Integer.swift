/*
The array-form of an integer num is an array representing its digits in left to right order.

For example, for num = 1321, the array form is [1,3,2,1].
Given num, the array-form of an integer, and an integer k, return the array-form of the integer num + k.



Example 1:

Input: num = [1,2,0,0], k = 34
Output: [1,2,3,4]
Explanation: 1200 + 34 = 1234
Example 2:

Input: num = [2,7,4], k = 181
Output: [4,5,5]
Explanation: 274 + 181 = 455
Example 3:

Input: num = [2,1,5], k = 806
Output: [1,0,2,1]
Explanation: 215 + 806 = 1021
Example 4:

Input: num = [9,9,9,9,9,9,9,9,9,9], k = 1
Output: [1,0,0,0,0,0,0,0,0,0,0]
Explanation: 9999999999 + 1 = 10000000000


Constraints:

1 <= num.length <= 104
0 <= num[i] <= 9
num does not contain any leading zeros except for the zero itself.
1 <= k <= 104
*/

/*
Solution 2:
optimize solution 1
instead of change k everytime,
directly assign k as cur init value

Continuing the example of 123 + 912, we start with [1, 2, 3+912]. Then we perform the addition 3+912, leaving 915. The 5 stays as the digit, while we 'carry' 910 into the next column which becomes 91.

We repeat this process with [1, 2+91, 5]. We have 93, where 3 stays and 90 is carried over as 9. Again, we have [1+9, 3, 5] which transforms into [1, 0, 3, 5].

Time Complexity: O(max(n, log_10 k))
Space Complexity: O(1)
*/
class Solution {
    func addToArrayForm(_ num: [Int], _ k: Int) -> [Int] {
        let n = num.count
        var num = num

        var i = n-1
        var cur = k

        while i >= 0 {
            cur += num[i]
            num[i] = cur % 10
            cur /= 10
            i -= 1
        }

        while cur != 0 {
            num.insert(cur%10, at: 0)
            cur /= 10
        }

        return num
    }
}

/*
Solution 1:
iterate from end of num

Time Complexity: O(max(n, logk))
Space Complexity: O(1)
*/
class Solution {
    func addToArrayForm(_ num: [Int], _ k: Int) -> [Int] {
        let n = num.count
        var num = num

        var i = n-1
        var k = k
        var cur = 0

        while i >= 0 {
            cur += num[i]
            // check this inside while i loop
            // ex: [9,9,9,9,9,9,9,9,9,9] 1
            if k != 0 {
                cur += k%10
                k /= 10
            }
            num[i] = cur % 10
            cur /= 10
            i -= 1
        }

        // check k, in case we miss any remaining k, ex: [0] 23
        while k != 0 {
            cur += k%10
            k /= 10

            num.insert(cur%10, at: 0)
            cur /= 10
        }

        if cur != 0 {
            num.insert(cur, at: 0)
        }
        return num
    }
}