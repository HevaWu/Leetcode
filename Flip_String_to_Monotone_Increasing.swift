/*
A string of '0's and '1's is monotone increasing if it consists of some number of '0's (possibly 0), followed by some number of '1's (also possibly 0.)

We are given a string s of '0's and '1's, and we may flip any '0' to a '1' or a '1' to a '0'.

Return the minimum number of flips to make s monotone increasing.



Example 1:

Input: s = "00110"
Output: 1
Explanation: We flip the last digit to get 00111.
Example 2:

Input: s = "010110"
Output: 2
Explanation: We flip to get 011111, or alternatively 000111.
Example 3:

Input: s = "00011000"
Output: 2
Explanation: We flip to get 00000000.


Note:

1 <= s.length <= 20000
s only consists of '0' and '1' characters.
*/

/*
Solution 4:
constant DP

zero += (c == "0" ? 0 : 1)

zero: flip 1 to zero
one: min(flip 1->0, flip 0->1)
one = min(zero, one+1 - (c == "0" ? 0 : 1))

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func minFlipsMonoIncr(_ s: String) -> Int {
        let n = s.count
        if n == 1 { return 0 }

        var zero = 0
        var one = 0
        for c in s {
            zero += (c == "0" ? 0 : 1)

            // zero: flip 1 to zero
            // one: min(flip 1->0, flip 0->1)
            one = min(zero, one+1 - (c == "0" ? 0 : 1))

            // print(zero, one)
        }

        return one
    }
}

/*
Solution 3:
prefix sum

build sum array first,
then for each i in 0...n,
- in [0..<i] there is sum[i] number of 1, which we can flip them to 0
- in [i....], there is n-i-(sum[n]-sum[i]) number of 0, which we can flip them to 1

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func minFlipsMonoIncr(_ s: String) -> Int {
        let n = s.count
        if n == 1 { return 0 }

        var s = Array(s)

        // sum[i] is sum of s[0..<i]
        var sum = Array(repeating: 0, count: n+1)
        for i in 0..<n {
            sum[i+1] = sum[i] + (s[i] == "0" ? 0 : 1)
        }

        var flip = n+1

        // from 0...n
        for i in 0...n {
            // in [0..<i], there is sum[i] number of 1
            // in [i...], there is n-i-(sum[n]-sum[i]) number of 0
            flip = min(flip, sum[i] + n-i-(sum[n] - sum[i]))
        }
        return flip
    }
}

/*
Solution 2:
optimize solution 1
use constant space

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func minFlipsMonoIncr(_ s: String) -> Int {
        let n = s.count
        if n == 1 { return 0 }

        var s = Array(s)

        var zero = s[0] == "0" ? 0 : 1
        var one: (flip: Int, count: Int) = s[0] == "0" ? (1, 1) : (0, 1)

        for i in 1..<n {
            var temp_zero = 0
            var temp_one: (flip: Int, count: Int) = (0, 0)
            if s[i] == "0" {
                temp_zero = min(zero, one.flip + one.count)

                if zero < one.flip {
                    temp_one = (1+zero, 1)
                } else {
                    temp_one = (1+one.flip, one.count + 1)
                }
            } else {
                temp_zero = 1 + min(zero, one.flip + one.count)

                if zero < one.flip {
                    temp_one = (zero, 1)
                } else {
                    temp_one = (one.flip, one.count+1)
                }
            }

            zero = temp_zero
            one = temp_one
        }

        // print(zero, one)
        return min(zero, one.flip)
    }
}

/*
Solution 1:
DP

- zero[i] min flip with ith char is "0"
- one[i] min flip with ith char is "1"

- if ith is "0"
    - update zero[i]
        - last is zero, keep zero[i-1] flip
        - last is one, one[i-1].flip + one[i-1].count
    - update one[i]
        - last is zero, 1 + zero[i-1] flip
        - last is one, 1 + one[i-1] flip
- if ith is "1"
    - update zero[i]
        - last is zero, 1 + zero[i-1]
        - last is one, 1 + one[i-1].flip + one[i-1].count
    - update one
        - last is zero, zero[i-1]
        - last is one, one[i-1].flip

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func minFlipsMonoIncr(_ s: String) -> Int {
        let n = s.count
        if n == 1 { return 0 }

        var s = Array(s)

        // zero[i] min flip with ith char is "0"
        var zero = Array(repeating: 0, count: n)

        // one[i] min flip with ith char is "1"
        var one = Array(repeating: (flip: 0, count: 0), count: n)

        zero[0] = s[0] == "0" ? 0 : 1
        one[0] = s[0] == "0" ? (1, 1) : (0, 1)

        for i in 1..<n {
            if s[i] == "0" {
                // last is zero, keep zero[i-1] flip
                // last is one, flip previous one to zero
                zero[i] = min(zero[i-1], one[i-1].flip + one[i-1].count)

                // to make ith as 1
                // last is zero, keep zero[i-1] flip, +1 to flip 0 to 1
                // last is one, keep one[i-1] flip, +1 to flip 0 to 1
                if zero[i-1] < one[i-1].flip {
                    one[i].flip = 1 + zero[i-1]
                    one[i].count = 1
                } else {
                    one[i].flip = 1 + one[i-1].flip
                    one[i].count = one[i-1].count + 1
                }
            } else {
                // to make ith as 0
                // last is zero, + zero[i-1] flip, +1 to flip 1 to 0,
                // last is one, flip previous one to zero, +1 to flip 1 to 0,
                zero[i] = 1 + min(zero[i-1], one[i-1].flip + one[i-1].count)

                // to make ith as 1
                // last is zero, count = 1, keep zero[i-1] flip
                // last is one, count = 1+one[i-1].count, keep one[i-1] flip
                if zero[i-1] < one[i-1].flip {
                    one[i].flip = zero[i-1]
                    one[i].count = 1
                } else {
                    one[i].flip = one[i-1].flip
                    one[i].count = one[i-1].count + 1
                }
            }
        }

        // print(zero, one)
        return min(zero[n-1], one[n-1].flip)
    }
}