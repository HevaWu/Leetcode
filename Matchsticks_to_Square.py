'''
You are given an integer array matchsticks where matchsticks[i] is the length of the ith matchstick. You want to use all the matchsticks to make one square. You should not break any stick, but you can link them up, and each matchstick must be used exactly one time.

Return true if you can make this square and false otherwise.



Example 1:


Input: matchsticks = [1,1,2,2,2]
Output: true
Explanation: You can form a square with length 2, one side of the square came two sticks with length 1.
Example 2:

Input: matchsticks = [3,3,3,3,4]
Output: false
Explanation: You cannot find a way to form a square with all the matchsticks.


Constraints:

1 <= matchsticks.length <= 15
0 <= matchsticks[i] <= 109
'''

'''
Solution 1:
backtrack
dfs

for each sticks, check which arr we can put it into

Time Complexity: O(4^n)
Space Complexity: O(1)
'''
class Solution:
    def makesquare(self, matchsticks: List[int]) -> bool:
        total = sum(matchsticks)
        if total % 4 != 0:
            return False
        self.side = total // 4

        # sort by decreasing order
        def compare(a, b) :
            return b-a
        matchsticks.sort(key=cmp_to_key(compare))

        self.sticks = matchsticks
        self.n = len(matchsticks)
        self.options = [0, 0, 0, 0]

        return self.check(0)

    def check(self, index: int) -> bool:
        if index == self.n:
            for option in self.options:
                if option != self.side:
                    return False
            return True

        for i in range(0, 4):
            if self.options[i] + self.sticks[index] <= self.side:
                self.options[i] += self.sticks[index]
                if self.check(index+1):
                    return True
                self.options[i] -= self.sticks[index]
        return False
