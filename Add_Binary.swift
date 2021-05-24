/*
Given two binary strings a and b, return their sum as a binary string.



Example 1:

Input: a = "11", b = "1"
Output: "100"
Example 2:

Input: a = "1010", b = "1011"
Output: "10101"


Constraints:

1 <= a.length, b.length <= 104
a and b consist only of '0' or '1' characters.
Each string does not contain leading zeros except for the zero itself.
*/

/*
Solution 3:
same idea as Solution 2

method without check a,b count

Time Complexity: O(max(na, nb))
Space Complexity: O(max(na, nb))
*/
class Solution {
    func addBinary(_ a: String, _ b: String) -> String {
        var a = a.map { $0.wholeNumberValue! }
        var b = b.map { $0.wholeNumberValue! }

        let na = a.count
        let nb = b.count

        var ia = na-1
        var ib = nb-1

        var cur = 0
        var res = [Int]()
        while ia >= 0, ib >= 0 {
            cur += a[ia] + b[ib]
            res.insert(cur%2, at: 0)
            cur /= 2
            ia -= 1
            ib -= 1
        }

        while ia >= 0 {
            cur += a[ia]
            res.insert(cur%2, at: 0)
            cur /= 2
            ia -= 1
        }

        while ib >= 0 {
            cur += b[ib]
            res.insert(cur % 2, at: 0)
            cur /= 2
            ib -= 1
        }

        if cur != 0 {
            res.insert(cur, at: 0)
        }

        var final = String()
        for num in res {
            final.append(String(num))
        }
        return final
    }
}

/*
Solution 2:
transfer to [Int] array first, then add them

Time Complexity: O(m+n)
Space Complexity: O(m+n)
*/
class Solution {
    func addBinary(_ a: String, _ b: String) -> String {
        var a = a.map { $0.wholeNumberValue! }
        var b = b.map { $0.wholeNumberValue! }

        var res = [Int]()
        var str = [Int]()

        if a.count > b.count {
            res = a
            str = b
        } else {
            res = b
            str = a
        }

        var i = res.count-1
        var j = str.count-1
        var temp = 0

        while i >= 0, j >= 0 {
            temp = temp + res[i] + str[j]
            res[i] = temp % 2
            temp /= 2

            i -= 1
            j -= 1
        }

        while i >= 0, temp != 0 {
            temp += res[i]
            res[i] = temp % 2
            temp /= 2

            i -= 1
        }

        if temp != 0 {
            res.insert(1, at: 0)
        }

        return res.reduce(into: "") { result, next in
            result.append(String(next))
        }
    }
}

/*
Solution 1:
use radix

NOT PASS
(exceed int limit maybe)

use string radix and int radix convert
*/
class Solution {
    func addBinary(_ a: String, _ b: String) -> String {
        return String((Int(a, radix: 2) ?? 0) + (Int(b, radix:2) ?? 0),
                      radix: 2)
    }
}