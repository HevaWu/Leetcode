/*
Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

Symbol       Value
I             1
V             5
X             10
L             50
C             100
D             500
M             1000
For example, 2 is written as II in Roman numeral, just two one's added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

I can be placed before V (5) and X (10) to make 4 and 9.
X can be placed before L (50) and C (100) to make 40 and 90.
C can be placed before D (500) and M (1000) to make 400 and 900.
Given an integer, convert it to a roman numeral.



Example 1:

Input: num = 3
Output: "III"
Example 2:

Input: num = 4
Output: "IV"
Example 3:

Input: num = 9
Output: "IX"
Example 4:

Input: num = 58
Output: "LVIII"
Explanation: L = 50, V = 5, III = 3.
Example 5:

Input: num = 1994
Output: "MCMXCIV"
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.


Constraints:

1 <= num <= 3999
*/

/*
Solution 2:
iterative build

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func intToRoman(_ num: Int) -> String {
        var num = num
        var roman = ""

        // 1000
        let m = num / 1000
        if m != 0 {
            roman += String(repeating: "M", count: m)
        }
        num = num % 1000

        build(&roman, &num, 100,
        Character("M"), Character("D"), Character("C"))
        build(&roman, &num, 10,
        Character("C"), Character("L"), Character("X"))
        build(&roman, &num, 1,
        Character("X"), Character("V"), Character("I"))
        return roman
    }

    func build(_ roman: inout String, _ num: inout Int,
    _ digit: Int, _ overTenChar: Character,
    _ overFiveChar: Character, _ curChar: Character) {
        var c = num / digit
        if c != 0 {
            if c == 9 {
                roman.append(curChar)
                roman.append(overTenChar)
            } else {
                if c >= 5 {
                    roman.append(overFiveChar)
                    c -= 5
                }
                if c == 4 {
                    roman.append(curChar)
                    roman.append(overFiveChar)
                } else {
                    roman += String(repeating: curChar, count: c)
                }
            }
        }
        num = num % digit
    }
}

/*
Solution 1:
map

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func intToRoman(_ num: Int) -> String {
        var num = num
        var map: [Int: Character] = [
            1: "I",
            5: "V",
            10: "X",
            50: "L",
            100: "C",
            500: "D",
            1000: "M"
        ]

        var key: [Int] = [1, 5, 10, 50, 100, 500, 1000]

        var str = String()
        for i in stride(from: 6, through: 0, by: -1) {
            if num >= key[i] {
                str.append(contentsOf: Array(repeating: map[key[i]]!, count: num/key[i]))
                num %= key[i]
            }

            if i > 1,  i%2 == 0, num >= (key[i]-key[i-2]) {
                // check IX, XC, CM case
                str.append(map[key[i-2]]!)
                str.append(map[key[i]]!)
                num -= (key[i]-key[i-2])
            } else if i > 0, i%2 == 1, num >= (key[i]-key[i-1]) {
                // check IV, XL, CD case
                str.append(map[key[i-1]]!)
                str.append(map[key[i]]!)
                num -= (key[i]-key[i-1])
            }

            if num == 0 {
                break
            }
        }

        return str
    }
}
