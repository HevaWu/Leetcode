/*
A valid IP address consists of exactly four integers separated by single dots. Each integer is between 0 and 255 (inclusive) and cannot have leading zeros.

For example, "0.1.2.201" and "192.168.1.1" are valid IP addresses, but "0.011.255.245", "192.168.1.312" and "192.168@1.1" are invalid IP addresses.
Given a string s containing only digits, return all possible valid IP addresses that can be formed by inserting dots into s. You are not allowed to reorder or remove any digits in s. You may return the valid IP addresses in any order.



Example 1:

Input: s = "25525511135"
Output: ["255.255.11.135","255.255.111.35"]
Example 2:

Input: s = "0000"
Output: ["0.0.0.0"]
Example 3:

Input: s = "101023"
Output: ["1.0.10.23","1.0.102.3","10.1.0.23","10.10.2.3","101.0.2.3"]


Constraints:

1 <= s.length <= 20
s consists of digits only.
*/

/*
Solution 1:
backtracking

check all possible 4 parts
Time Complexity: O(n*(n-1)*(n-2)*(n-3))
Space Complexity: O(n)
*/
class Solution {
    func restoreIpAddresses(_ s: String) -> [String] {
        let n = s.count
        guard n >= 4 else { return [] }
        var s = Array(s)
        var res = [String]()
        var cur = [String]()
        check(0, n, s, &cur, &res)
        return res
    }

    func check(_ index: Int, _ n: Int, _ s: [Character],
    _ cur: inout [String],
    _ res: inout [String]) {
        if index == n {
            // print(cur)
            if cur.count == 4 {
                let valid = cur.joined(separator: ".")
                res.append(valid)
            }
            return
        }
        // means there still some digits remaining
        if cur.count == 4 { return }
        let remain = 4-cur.count
        for j in index..<(n-remain+1) {
            let p1 = String(s[index...j])
            if isValid(p1) {
                cur.append(p1)
                check(j+1, n, s, &cur, &res)
                cur.removeLast()
            }
        }
    }

    // check if s is between 0...255, without leading zero
    func isValid(_ s: String) -> Bool {
        if s.first == Character("0") { return s.count == 1 }
        guard let val = Int(s) else { return false }
        return val >= 0 && val <= 255
    }
}
