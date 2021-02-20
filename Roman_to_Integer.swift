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
Given a roman numeral, convert it to an integer.

 

Example 1:

Input: s = "III"
Output: 3
Example 2:

Input: s = "IV"
Output: 4
Example 3:

Input: s = "IX"
Output: 9
Example 4:

Input: s = "LVIII"
Output: 58
Explanation: L = 50, V= 5, III = 3.
Example 5:

Input: s = "MCMXCIV"
Output: 1994
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
 

Constraints:

1 <= s.length <= 15
s contains only the characters ('I', 'V', 'X', 'L', 'C', 'D', 'M').
It is guaranteed that s is a valid roman numeral in the range [1, 3999].
*/

/*
Solution 3
optimize solution 2
*/
class Solution {
    func romanToInt(_ s: String) -> Int {
        var map: [Character: Int] = [
            "I": 1,
            "V": 5,
            "X": 10,
            "L": 50,
            "C": 100,
            "D": 500,
            "M": 1000
        ]
        
        var preVal = 1001
        var res = 0
        for c in s {
            if let cVal = map[c] {
                res += cVal
                if preVal < cVal {
                    res -= 2*preVal
                }
                preVal = cVal
            }
        }
        return res
    }
}

/*
Solution 2
optimize solution 1
*/
class Solution {
    func romanToInt(_ s: String) -> Int {
        var map = [Character: Int]()
        map["I"] = 1
        map["V"] = 5
        map["X"] = 10
        map["L"] = 50
        map["C"] = 100
        map["D"] = 500
        map["M"] = 1000
        
        var res = 0
        var preVal = 0
        for c in s {
            let curVal = map[c, default: 0]
            if preVal < curVal {
                res += curVal - 2*preVal
            } else {
                res += curVal
            }
            preVal = curVal
        }
        return res
    }
}

/*
Solution 1
map 
check from back to front

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func romanToInt(_ s: String) -> Int {
        var map = [Character: Int]()
        map["I"] = 1
        map["V"] = 5
        map["X"] = 10
        map["L"] = 50
        map["C"] = 100
        map["D"] = 500
        map["M"] = 1000
        
        var res = 0
        var pre: Character = Character("a")
        var s = Array(s)
        for i in stride(from: s.count-1, through: 0, by: -1) {
            let c = s[i]
            if (c == "I" && (pre == "V" || pre == "X")) 
            || (c == "X" && (pre == "L" || pre == "C"))
            || (c == "C" && (pre == "D" || pre == "M")){
                res -= map[c, default: 0]
            } else {
                res += map[c, default: 0]
            }
            pre = c            
        }
        return res
    }
}