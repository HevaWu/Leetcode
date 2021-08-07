/*
Given an equation, represented by words on left side and the result on right side.

You need to check if the equation is solvable under the following rules:

Each character is decoded as one digit (0 - 9).
Every pair of different characters they must map to different digits.
Each words[i] and result are decoded as one number without leading zeros.
Sum of numbers on left side (words) will equal to the number on right side (result).
Return True if the equation is solvable otherwise return False.



Example 1:

Input: words = ["SEND","MORE"], result = "MONEY"
Output: true
Explanation: Map 'S'-> 9, 'E'->5, 'N'->6, 'D'->7, 'M'->1, 'O'->0, 'R'->8, 'Y'->'2'
Such that: "SEND" + "MORE" = "MONEY" ,  9567 + 1085 = 10652
Example 2:

Input: words = ["SIX","SEVEN","SEVEN"], result = "TWENTY"
Output: true
Explanation: Map 'S'-> 6, 'I'->5, 'X'->0, 'E'->8, 'V'->7, 'N'->2, 'T'->1, 'W'->'3', 'Y'->4
Such that: "SIX" + "SEVEN" + "SEVEN" = "TWENTY" ,  650 + 68782 + 68782 = 138214
Example 3:

Input: words = ["THIS","IS","TOO"], result = "FUNNY"
Output: true
Example 4:

Input: words = ["LEET","CODE"], result = "POINT"
Output: false


Constraints:

2 <= words.length <= 5
1 <= words[i].length, result.length <= 7
words[i], result contain only uppercase English letters.
The number of different characters used in the expression is at most 10.
*/

/*
Solution 2:
backtracking

for pruning,
reverse the words and result, to check digit from least significant digit to most significant digit

use indexArr to record the index -> char
use charMap to record char -> index

once we reach the end, try to check if leading zero is okay or not

Time Complexity: O()

*/
class Solution {
    // record which number will be map to which char
    var indexArr: [Character?] = Array(repeating: nil, count: 10)
    // record char is map to which interger
    var charMap = [Character: Int]()

    func isSolvable(_ words: [String], _ result: String) -> Bool {
        for word in words {
            if word.count > result.count {
                return false
            }
        }

        // reverse for checking from least significant digit to larger one
        var words = words.map { $0.reversed() }.map{ Array($0) }
        var result = Array(result.reversed())

        return check(0, 0, 0, words, result)
    }

    // words index
    // words[index] digit
    func check(_ index: Int, _ digit: Int, _ sum: Int,
               _ words: [[Character]], _ result: [Character]) -> Bool {
        if digit == result.count {
            var val = sum == 0
            if val {
                // double check words and result leading zero
                for word in words {
                    if word.count > 1, word.last == indexArr[0] {
                        return false
                    }
                }
                if result.count > 1, result.last == indexArr[0] {
                    return false
                }
                // print(indexArr)
                return true
            }
            return false
        }

        if index == words.count {
            if let val = charMap[result[digit]] {
                if sum % 10 == val {
                    return check(0, digit+1, sum/10, words, result)
                }
            } else if indexArr[sum % 10] == nil {
                if digit == result.count-1, sum % 10 == 0 {
                    // cannot assign leading 0 to result
                    return false
                }

                charMap[result[digit]] = sum % 10
                indexArr[sum % 10] = result[digit]

                if check(0, digit+1, sum / 10, words, result) {
                    // print(indexArr)
                    return true
                }

                charMap[result[digit]] = nil
                indexArr[sum % 10] = nil
            }
            return false
        }

        // check next word
        if digit >= words[index].count {
            return check(index+1, digit, sum, words, result)
        }

        if let val = charMap[words[index][digit]] {
            return check(index+1, digit, sum+val, words, result)
        }

        for i in 0...9 {
            if indexArr[i] != nil { continue }

            // can not assign leading zero to one string, reversed string,
            // check n-1 would be okay
            if i == 0, digit == words[index].count-1, words[index].count > 1 {
                continue
            }

            indexArr[i] = words[index][digit]
            charMap[words[index][digit]] = i

            if check(index+1, digit, sum+i, words, result) {
                return true
            }

            indexArr[i] = nil
            charMap[words[index][digit]] = nil
        }
        return false
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func isSolvable(_ words: [String], _ result: String) -> Bool {
        // all of char in words and result
        var charSet = Set<Character>()

        // first character in words and result cannot be 0,
        // no-leading zero rule
        var canNotBeZero = Set<Character>()

        var initialC: Character? = nil
        for word in words {
            initialC = nil
            for c in word {
                charSet.insert(c)
                if initialC == nil {
                    initialC = c
                }
            }
            canNotBeZero.insert(initialC!)
        }

        initialC = nil
        for c in result {
            charSet.insert(c)
            if initialC == nil {
                initialC = c
            }
        }
        canNotBeZero.insert(initialC!)

        // iterate all appeared char, and try to assign 0...9 to this char
        var charArr = Array(charSet)

        // record which number will be map to which char
        var indexArr: [Character?] = Array(repeating: nil, count: 10)

        // record char is map to which interger
        var charMap = [Character: Int]()

        return check(0, charArr.count, canNotBeZero, charArr, &indexArr, &charMap, words, result)
    }

    func check(_ i: Int, _ n: Int,
               _ canNotBeZero: Set<Character>,
               _ charArr: [Character],
               _ indexArr: inout [Character?],
               _ charMap: inout [Character: Int],
               _ words: [String], _ result: String) -> Bool {
        print(i, n)
        if i == n {
            // all char is assigned to a number
            // check equation
            return canEqual(words, result, charMap)
        }

        let c = charArr[i]
        for digit in 0...9 {
            if digit == 0, canNotBeZero.contains(c) { continue }
            if indexArr[digit] == nil {
                indexArr[digit] = c
                charMap[c] = digit

                if check(i+1, n, canNotBeZero, charArr, &indexArr, &charMap, words, result) {
                    return true
                }

                indexArr[digit] = nil
                charMap[c] = nil
            }
        }
        return false
    }

    func canEqual(_ words: [String], _ results: String,
                  _ charMap: [Character: Int]) -> Bool {
        var left = 0
        for word in words {
            var val = 0
            for c in word {
                if let cVal = charMap[c] {
                    val = val*10 + cVal
                } else {
                    return false
                }
            }
            left += val
        }

        var right = 0
        for c in results {
            if let cVal = charMap[c] {
                right = right*10 + cVal
            } else {
                return false
            }
        }

        print(left, right)
        return left == right
    }
}

