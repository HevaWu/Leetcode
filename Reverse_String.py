'''
Write a function that reverses a string. The input string is given as an array of characters char[].

Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

You may assume all the characters consist of printable ascii characters.



Example 1:

Input: ["h","e","l","l","o"]
Output: ["o","l","l","e","h"]
Example 2:

Input: ["H","a","n","n","a","h"]
Output: ["h","a","n","n","a","H"]

Hint 1:
The entire logic for reversing a string is based on using the opposite directional two-pointer approach!
'''

'''
Solution 1:
Swap i, n-i-1

Time Complexity: O(n/2)
Space Complexity: O(1)
'''
class Solution:
    def reverseString(self, s: List[str]) -> None:
        """
        Do not return anything, modify s in-place instead.
        """
        for i in range(len(s) // 2):
            temp = s[i]
            s[i] = s[len(s)-i-1]
            s[len(s)-i-1] = temp
