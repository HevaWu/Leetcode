/*
You are given an integer num. You will apply the following steps exactly two times:

Pick a digit x (0 <= x <= 9).
Pick another digit y (0 <= y <= 9). The digit y can be equal to x.
Replace all the occurrences of x in the decimal representation of num by y.
The new integer cannot have any leading zeros, also the new integer cannot be 0.
Let a and b be the results of applying the operations to num the first and second times, respectively.

Return the max difference between a and b.



Example 1:

Input: num = 555
Output: 888
Explanation: The first time pick x = 5 and y = 9 and store the new integer in a.
The second time pick x = 5 and y = 1 and store the new integer in b.
We have now a = 999 and b = 111 and max difference = 888
Example 2:

Input: num = 9
Output: 8
Explanation: The first time pick x = 9 and y = 9 and store the new integer in a.
The second time pick x = 9 and y = 1 and store the new integer in b.
We have now a = 9 and b = 1 and max difference = 8
Example 3:

Input: num = 123456
Output: 820000
Example 4:

Input: num = 10000
Output: 80000
Example 5:

Input: num = 9288
Output: 8700


Constraints:

1 <= num <= 10^8
*/

/*
Solution 1:

get min number after replace 1 digit
    - be careful, we cannot make 0 as starting digit
get max number after replace 1 digits

res = max - min

Time Complexity: O(n)
- n is length of decimal digits count
Space Complexity: O(n)
*/
class Solution {
    func maxDiff(_ num: Int) -> Int {
        var numArr = [Int]()
        var num = num
        while num != 0 {
            numArr.insert(num % 10, at: 0)
            num /= 10
        }

        return getMax(numArr) - getMin(numArr)
    }

    func getMax(_ numArr: [Int]) -> Int {
        let n = numArr.count
        var numArr = numArr

        for i in 0..<n {
            if numArr[i] == 9 { continue }
            replace(numArr[i], 9, &numArr)

            break
        }
        return getNum(numArr)
    }

    func getMin(_ numArr: [Int]) -> Int {
        let n = numArr.count
        var numArr = numArr

        for i in 0..<n {
            if i == 0 {
                if numArr[i] == 1 { continue }
                replace(numArr[i], 1, &numArr)

                break
            } else {
                // add ==1 check for skip 0-index is 1
                if numArr[i] == 0 || numArr[i] == 1 { continue }
                replace(numArr[i], 0, &numArr)

                break
            }
        }
        return getNum(numArr)
    }

    func replace(_ digit: Int, _ newDigit: Int, _ arr: inout [Int]) {
        for i in 0..<arr.count {
            if arr[i] == digit {
                arr[i] = newDigit
            }
        }
    }

    func getNum(_ numArr: [Int]) -> Int {
        var num = 0
        for i in 0..<numArr.count {
            num = num * 10 + numArr[i]
        }
        return num
    }
}