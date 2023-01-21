'''
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
'''

'''
Solution 1:
backtracking

check all possible 4 parts
Time Complexity: O(n*(n-1)*(n-2)*(n-3))
Space Complexity: O(n)
'''
class Solution:
    def restoreIpAddresses(self, s: str) -> List[str]:
        res = []

        def restoreIP(s: str, index: int, restore: str, count: int):
            if count > 4: return
            if count == 4 and index == len(s):
                res.append(restore)
                return
            for i in range(1, 4):
                if index+i > len(s): break
                sub = s[index:index+i:]
                if (sub[0] == "0" and len(sub) > 1) or (i == 3 and int(sub) >= 256): continue
                restoreIP(s, index+i, restore+sub+("" if count == 3 else "."), count+1)

        restoreIP(s, 0, "", 0)
        return res
