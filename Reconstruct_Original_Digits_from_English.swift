/*
Given a non-empty string containing an out-of-order English representation of digits 0-9, output the digits in ascending order.

Note:
Input contains only lowercase English letters.
Input is guaranteed to be valid and can be transformed to its original digits. That means invalid inputs such as "abc" or "zerone" are not permitted.
Input length is less than 50,000.
Example 1:
Input: "owoztneoer"

Output: "012"
Example 2:
Input: "fviefuro"

Output: "45"
*/

/*
Solution 3:
optimize solution 2 by using
specific ids to help checking each num

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func originalDigits(_ s: String) -> String {
        var charMap = [Character: Int]()
        for c in s {
            charMap[c, default: 0] += 1
        }

        let arr = [0, 2, 4, 6, 8, 1, 3, 5, 7, 9]
        let ids: [Character] = ["z", "o", "w", "h", "u", "f", "x", "s", "g", "i"]
        let numArr = [
            "zero",
            "one",
            "two",
            "three",
            "four",
            "five",
            "six",
            "seven",
            "eight",
            "nine"
        ]

        var found = Array(repeating: 0, count: 10)
        var index = 0
        while index <= 9, !charMap.isEmpty {
            let num = arr[index]
            if let val = charMap[ids[num]] {
                found[num] += val
                for c in numArr[num] {
                    charMap[c]! -= val
                    if charMap[c] == 0 {
                        charMap[c] = nil
                    }
                }
            }
            index += 1
        }

        var res = String()
        for i in 0...9 {
            if found[i] > 0 {
                let str = String(i).first!
                res.append(contentsOf: Array(repeating: str, count: found[i]))
            }
        }

        return res
    }
}

/*
Solution 2:
check each number specific char
- Let us look at word zero: we meet symbol z only in this word, so total number of times we have z in string is number of times we have word zero inside. So, what we do: we keep global counter cnt and subtract all frequencies, corresponding to letters z, e, r, o.
- Look at word two, we have symbol w only in this word, remove all words two.
- Look at word four, we have symbol u only in this word, remove all words four.
- Look at word six, we have symbol x only in this word, remove all words six.
- Look at word eight, we have symbol g only in this word, remove all words eight.
- Look at word one, we have symbol o only in this word if we look at words we still have, remove all words one.
- Look at word three, we have symbol t only in this word if we look at words we still have, remove all words three.
- Look at word five, we have symbol f only in this word if we look at words we still have, remove all words five.
- Look at word seven, we have symbol s only in this word if we look at words we still have, remove all words seven.
- Look at word nine, we have symbol n only in this word if we look at words we still have, remove all words nine.

0 2 4 6 8 1 3 5 7 9

Optimized by specifying array order first

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func originalDigits(_ s: String) -> String {
        var charMap = [Character: Int]()
        for c in s {
            charMap[c, default: 0] += 1
        }

        var arr = [0, 2, 4, 6, 8, 1, 3, 5, 7, 9]

        var numMap = [Int: String]()
        numMap[0] = "zero"
        numMap[1] = "one"
        numMap[2] = "two"
        numMap[3] = "three"
        numMap[4] = "four"
        numMap[5] = "five"
        numMap[6] = "six"
        numMap[7] = "seven"
        numMap[8] = "eight"
        numMap[9] = "nine"

        var found = Array(repeating: 0, count: 10)
        check(arr, 0, 9, &found, numMap, charMap)

        var res = String()
        for i in 0...9 {
            if found[i] > 0 {
                let str = String(i).first!
                res.append(contentsOf: Array(repeating: str, count: found[i]))
            }
        }

        return res
    }

    func check(_ arr: [Int],
               _ start: Int, _ end: Int,
               _ found: inout [Int],
               _ numMap: [Int: String], _ charMap: [Character: Int]) -> Bool {
        if charMap.isEmpty {
            return true
        }

        for i in start...end {
            let (isFind, newCharMap) = canFind(arr[i], numMap, charMap)
            // print(num, isFind, newCharMap)
            if isFind {
                found[arr[i]] += 1
                if check(arr, i, end, &found, numMap, newCharMap) {
                    return true
                }
                found[arr[i]] -= 1
            }
        }

        return false
    }

    // if num english string can be found in sarr
    // (true, removed english num from sarr)
    // (false, remove original sarr)
    func canFind(_ num: Int, _ numMap: [Int: String], _ charMap: [Character: Int])
    -> (Bool, [Character: Int]) {
        var newCharMap = charMap
        for c in numMap[num]! {
            if let val = newCharMap[c] {
                newCharMap[c] = val-1 > 0 ? val-1 : nil
            } else {
                return (false, charMap)
            }
        }
        return (true, newCharMap)
    }
}

/*
Solution 1:
backTrack

Time Limit Exceeded

check 0...9 num, if we can find this num in s
if we can find one, append it into result

Time Complexity: O(n + (9*26)^k)
- k: final result length
*/
class Solution {
    let ascii_a = Character("a").asciiValue!

    func originalDigits(_ s: String) -> String {
        var sarr = Array(repeating: 0, count: 26)
        for c in s {
            sarr[Int(c.asciiValue! - ascii_a)] += 1
        }

        var numMap = [Int: String]()
        numMap[0] = "zero"
        numMap[1] = "one"
        numMap[2] = "two"
        numMap[3] = "three"
        numMap[4] = "four"
        numMap[5] = "five"
        numMap[6] = "six"
        numMap[7] = "seven"
        numMap[8] = "eight"
        numMap[9] = "nine"

        var res = String()
        check(0, 9, &res, numMap, sarr)

        return res
    }

    func check(_ start: Int, _ end: Int,
               _ res: inout String,
               _ numMap: [Int: String], _ sarr: [Int]) -> Bool {
        if allChecked(sarr) {
            return true
        }

        for num in start...end {
            let (isFind, newArr) = canFind(num, numMap, sarr)
            // print(num, isFind, newArr)
            if isFind {
                res.append(String(num))
                if check(num, end, &res, numMap, newArr) {
                    return true
                }
                res.removeLast()
            }
        }

        return false
    }

    func allChecked(_ sarr: [Int]) -> Bool {
        for i in sarr {
            if i > 0 {
                return false
            }
        }
        return true
    }

    // if num english string can be found in sarr
    // (true, removed english num from sarr)
    // (false, remove original sarr)
    func canFind(_ num: Int, _ numMap: [Int: String], _ sarr: [Int]) -> (Bool, [Int]) {
        var arr = sarr
        for c in numMap[num]! {
            let index = Int(c.asciiValue! - ascii_a)
            if arr[index] > 0 {
                arr[index] -= 1
            } else {
                return (false, sarr)
            }
        }
        return (true, arr)
    }
}