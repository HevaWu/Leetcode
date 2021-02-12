/*
Given a string, you need to reverse the order of characters in each word within a sentence while still preserving whitespace and initial word order.

Example 1:
Input: "Let's take LeetCode contest"
Output: "s'teL ekat edoCteeL tsetnoc"
Note: In the string, each word is separated by single space and there will not be any extra space in the string.
*/

/*
Solution 1
split join

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func reverseWords(_ s: String) -> String {
        return s.split(separator: " ")
        .map { String($0.reversed()) }
        .joined(separator: " ")
    }
}