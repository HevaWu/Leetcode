/*
Given a valid (IPv4) IP address, return a defanged version of that IP address.

A defanged IP address replaces every period "." with "[.]".



Example 1:

Input: address = "1.1.1.1"
Output: "1[.]1[.]1[.]1"
Example 2:

Input: address = "255.100.50.0"
Output: "255[.]100[.]50[.]0"


Constraints:

The given address is a valid IPv4 address.
*/

/*
Solution 2:
swift split and join

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func defangIPaddr(_ address: String) -> String {
        return address.split(separator: ".").joined(separator: "[.]")
    }
}

/*
Solution 1:
swift embedded replacingOccurrences function

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func defangIPaddr(_ address: String) -> String {
        return address.replacingOccurrences(of: ".", with: "[.]")
    }
}