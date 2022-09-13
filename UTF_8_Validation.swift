/*
Given an integer array data representing the data, return whether it is a valid UTF-8 encoding (i.e. it translates to a sequence of valid UTF-8 encoded characters).

A character in UTF8 can be from 1 to 4 bytes long, subjected to the following rules:

For a 1-byte character, the first bit is a 0, followed by its Unicode code.
For an n-bytes character, the first n bits are all one's, the n + 1 bit is 0, followed by n - 1 bytes with the most significant 2 bits being 10.
This is how the UTF-8 encoding would work:

     Number of Bytes   |        UTF-8 Octet Sequence
                       |              (binary)
   --------------------+-----------------------------------------
            1          |   0xxxxxxx
            2          |   110xxxxx 10xxxxxx
            3          |   1110xxxx 10xxxxxx 10xxxxxx
            4          |   11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
x denotes a bit in the binary form of a byte that may be either 0 or 1.

Note: The input is an array of integers. Only the least significant 8 bits of each integer is used to store the data. This means each integer represents only 1 byte of data.



Example 1:

Input: data = [197,130,1]
Output: true
Explanation: data represents the octet sequence: 11000101 10000010 00000001.
It is a valid utf-8 encoding for a 2-bytes character followed by a 1-byte character.
Example 2:

Input: data = [235,140,4]
Output: false
Explanation: data represented the octet sequence: 11101011 10001100 00000100.
The first 3 bits are all one's and the 4th bit is 0 means it is a 3-bytes character.
The next byte is a continuation byte which starts with 10 and that's correct.
But the second continuation byte does not start with 10, so it is invalid.


Constraints:

1 <= data.length <= 2 * 104
0 <= data[i] <= 255
*/

/*
Solution 2:
digit checking
because it will only have 1-4 bytes possibilities

Time Complexity: O(n)
- n is data.count
Space Complexity: O(1)
*/
class Solution {
    func validUtf8(_ data: [Int]) -> Bool {
        var cur = 0

        for num in data {
            if cur == 0 {
                if (num >> 5) == 0b110 {
                    cur = 1
                } else if (num >> 4) == 0b1110 {
                    cur = 2
                } else if (num >> 3 == 0b11110) {
                    cur = 3
                } else {
                    // it should be 1 bytes, otherwise return false
                    if (num >> 7) != 0 {
                         return false
                    }
                }
            } else {
                // current is some bytes
                if (num >> 6) != 0b10 {
                    return false
                }
                cur -= 1
            }
        }

        return cur == 0
    }
}

/*
Solution 1:
use getLeading to help count the leading 1 in 8bit number
then for each number, check if it is follow the UTF8 rules
1. only  1-4 bytes
2. for 1 byte, can be leading with 0
3. for n bytes, should be leading with n 1's, and n-1 10's

Time Complexity: O(n)
- n is data.count
Space Complexity: O(1)
*/
class Solution {
    func validUtf8(_ data: [Int]) -> Bool {
        // current bytes number,
        // ex: 3 bytes sequence will have cur as 3
        var cur = 0

        // help checking if this digit byte follow UTF8 rules
        var digit = 0

        for num in data {
            let leading = getLeading(num)
            if leading > 4 {
                // valid UTF8 can be 1-4 byte long
                return false
            }
            if cur == 0 {
                if leading == 0 {
                    // 1 byte sequence
                    // should be fine
                    continue
                } else {
                    // update current bytes
                    cur = leading
                    digit = leading
                }
            } else {
                // expect this digit is cur's pending digit
                if leading == 1 {
                    if digit == 1 { return false }

                    // this digit is follow UTF8 rule
                    digit -= 1
                    if digit == 1 {
                        // current cur bytes is follow the rule
                        // reset cur, digit for next check
                        cur = 0
                        digit = 0
                    }
                } else {
                    // current digit is not finish,
                    // but the leading is not follow 10 format
                    return false
                }
            }
        }

        return cur == 0
    }

    // return the leading 1 in integer
    func getLeading(_ num: Int) -> Int {
        var val = 1<<7
        var leading = 0
        while val >= 0, num & val != 0 {
            leading += 1
            val >>= 1
        }

        return leading
    }
}
