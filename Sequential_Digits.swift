/*
An integer has sequential digits if and only if each digit in the number is one more than the previous digit.

Return a sorted list of all the integers in the range [low, high] inclusive that have sequential digits.



Example 1:

Input: low = 100, high = 300
Output: [123,234]
Example 2:

Input: low = 1000, high = 13000
Output: [1234,2345,3456,4567,5678,6789,12345]


Constraints:

10 <= low <= high <= 10^9
*/

/*
Solution 2:
generate all possible sequential numbers, to see if they are in range or not

Time Complexity: O(9 * 9)
Space Complexity: O(1)
*/
class Solution {
    func sequentialDigits(_ low: Int, _ high: Int) -> [Int] {
        var list = [Int]()
        for var num in 1...9 {
            while num <= high, num % 10 != 0 {
                if num >= low {
                    list.append(num)
                }
                num = num * 10 + (num % 10) + 1
            }
        }
        return list.sorted()
    }
}

/*
Solution 1:
get range of length of digit
then for each digit len, find possible sequential number, and append to result lists

Time Complexity: O(9 * 9 * 9)
Space Complexity: O(1)
*/
class Solution {
    func sequentialDigits(_ low: Int, _ high: Int) -> [Int] {
        let lowDigit = String(low).count
        let highDigit = String(high).count

        var list = [Int]()
        for digit in lowDigit...highDigit {
            // at most 123456789
            // for more digit, break
            guard 10-digit >= 1 else {
                break
            }

            for startDigit in 1...(10-digit) {
                // generate sequential number
                // startDigit ... (startDigit+digit-1)
                var num = 0
                for i in 0..<digit {
                    num = num*10 + (startDigit+i)
                }

                if num < low {
                    continue
                } else if num >= low && num <= high {
                    list.append(num)
                } else {
                    // num > high
                    break
                }

                // print(list)
            }
        }

        return list
    }
}