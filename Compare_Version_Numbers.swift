/*
Given two version strings, version1 and version2, compare them. A version string consists of revisions separated by dots '.'. The value of the revision is its integer conversion ignoring leading zeros.

To compare version strings, compare their revision values in left-to-right order. If one of the version strings has fewer revisions, treat the missing revision values as 0.

Return the following:

If version1 < version2, return -1.
If version1 > version2, return 1.
Otherwise, return 0.


Example 1:

Input: version1 = "1.2", version2 = "1.10"

Output: -1

Explanation:

version1's second revision is "2" and version2's second revision is "10": 2 < 10, so version1 < version2.

Example 2:

Input: version1 = "1.01", version2 = "1.001"

Output: 0

Explanation:

Ignoring leading zeroes, both "01" and "001" represent the same integer "1".

Example 3:

Input: version1 = "1.0", version2 = "1.0.0.0"

Output: 0

Explanation:

version1 has less revisions, which means every missing revision are treated as "0".



Constraints:

1 <= version1.length, version2.length <= 500
version1 and version2 only contain digits and '.'.
version1 and version2 are valid version numbers.
All the given revisions in version1 and version2 can be stored in a 32-bit integer.
*/


/*
Solution 1:
First get the digit array, then compare it one by one

Time Complexity: O(n1 + n2)
Space Complexity: O(n1 + n2)
- n1 = version1.count
- n2 = version2.count
*/
class Solution {
    func compareVersion(_ version1: String, _ version2: String) -> Int {
        var digits1 = getDigit(version1)
        var digits2 = getDigit(version2)
        let n1 = digits1.count
        let n2 = digits2.count
        var index = 0
        while index < n1 || index < n2 {
            let d1 = index < n1 ? digits1[index] : 0
            let d2 = index < n2 ? digits2[index] : 0
            if (d1 < d2) {
                return -1
            } else if (d1 > d2) {
                return 1
            } else {
                index += 1
            }
        }
        return 0
    }

    // return digit array
    // ex: 1.2 return [1,2]
    func getDigit(_ version: String) -> [Int] {
        var digits = version.split(separator: ".")
        return digits.map { Int($0) ?? 0 }
    }
}
