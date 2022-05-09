'''
Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent.

A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.



Example:

Input: "23"
Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
Note:

Although the above answer is in lexicographical order, your answer could be in any order you want.
'''

'''
Solution 1:
backtracking

Time Complexity: O(3^n)
Space Complexity: O(3^n)
- n is digits length
'''
class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        if len(digits) < 1:
            return []

        comb = []
        n = len(digits)

        chars = ["", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]

        def backtrack(index: int, cur: str):
            if index == n:
                comb.append(cur)
                return

            num = ord(digits[index]) - ord('0')
            for c in chars[num]:
                backtrack(index+1, cur + c)

        backtrack(0, "")
        return comb
