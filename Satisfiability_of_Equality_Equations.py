'''
You are given an array of strings equations that represent relationships between variables where each string equations[i] is of length 4 and takes one of two different forms: "xi==yi" or "xi!=yi".Here, xi and yi are lowercase letters (not necessarily different) that represent one-letter variable names.

Return true if it is possible to assign integers to variable names so as to satisfy all the given equations, or false otherwise.



Example 1:

Input: equations = ["a==b","b!=a"]
Output: false
Explanation: If we assign say, a = 1 and b = 1, then the first equation is satisfied, but not the second.
There is no way to assign the variables to satisfy both equations.
Example 2:

Input: equations = ["b==a","a==b"]
Output: true
Explanation: We could assign a = 1 and b = 1 to satisfy both equations.


Constraints:

1 <= equations.length <= 500
equations[i].length == 4
equations[i][0] is a lowercase letter.
equations[i][1] is either '=' or '!'.
equations[i][2] is '='.
equations[i][3] is a lowercase letter.
'''

'''
Solution 1:
UF (union find)

since the equation parameter is all lowercase character
can simple map them into 26 integer array

for all equal equations, link them together
then for non-equal equations, if find two param is equal, return false

Time Complexity: O(n^2)
Space Complexity: O(1)
'''
class Solution:
    def equationsPossible(self, equations: List[str]) -> bool:
        notEqual = []
        uf = UF(26)
        for e in equations:
            if e[1] == '!':
                notEqual.append(e)
            else:
                # two char is equal, union them together
                uf.union(ord(e[0])-ord('a'), ord(e[3])-ord('a'))
        for e in notEqual:
            if uf.find(ord(e[0])-ord('a')) == uf.find(ord(e[3])-ord('a')):
                return False
        return True

class UF:
    def __init__(self, n: int):
        self.parent = [i for i in range(n)]

    def find(self, x: int):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x: int, y: int):
        if self.find(x) != self.find(y):
            self.parent[self.find(x)] = self.find(y)
