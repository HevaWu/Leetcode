/*
Given a positive integer n, find the smallest integer which has exactly the same digits existing in the integer n and is greater in value than n. If no such positive integer exists, return -1.

Note that the returned integer should fit in 32-bit integer, if there is a valid answer but it does not fit in 32-bit integer, return -1.

 

Example 1:

Input: n = 12
Output: 21
Example 2:

Input: n = 21
Output: -1
 

Constraints:

1 <= n <= 231 - 1
*/

/*
Solution 1:

steps:
1. check if we can find first index where, digits[first] < some of digits[first+1...], if not, this array is in descending order, ex: 9876, which we should return -1
2. try to find second index where,
	- digits[second] > digits[first], digits[second] is the smallest element but larger than digits[first]
3. swap first & second digit
4. sort digits[first+1...] in inscending order
5. check result by comparing with int32.max, if larger than it, return -1, if not, return the generate nextGreater number
*/
class Solution {
    func nextGreaterElement(_ n: Int) -> Int {
        var digits: [Int] = {
            var res = [Int]()
            var _n = n
            while _n != 0 {
                res.insert(_n%10, at: 0)
                _n = _n/10
            }
            return res
        }()
        
        let n = digits.count
        
        // 1. find first digits[i] < digits[i+1...]
        var first = -1
        for i in stride(from: n-1, through: 1, by: -1) {
            if digits[i-1] < digits[i] {
                first = i-1
                break
            }
        }
        
        // array is in descending order
        if first == -1 { return -1 }
        
        // 2. find smaller larger number after first
        var second: Int = {
            var res = first + 1
            var temp = digits[first+1]
            for j in (first+1)..<n {
                if digits[j] < temp, digits[j] > digits[first] {
                    res = j
                }
            }
            return res
        }()
                
        // 3. swap first, second
        digits.swapAt(first, second)
        
        // 4. sort first+1 ..< n in ascending order
        digits = Array(digits[0...first] + digits[(first+1)...].sorted())
        
        var nextGreater: Int = digits.reduce(into: 0) { res, next in
            res = res*10 + next
        }
        return nextGreater > Int32.max ? -1 : nextGreater
    }
}