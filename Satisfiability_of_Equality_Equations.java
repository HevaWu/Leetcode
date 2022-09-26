/*
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
*/

/*
Solution 1:
UF (union find)

since the equation parameter is all lowercase character
can simple map them into 26 integer array

for all equal equations, link them together
then for non-equal equations, if find two param is equal, return false

Time Complexity: O(n^2)
Space Complexity: O(1)
*/
class Solution {
    public boolean equationsPossible(String[] equations) {
        List<String> notEqual = new ArrayList<>();

        UF uf = new UF(26);
        for (String e : equations) {
            if (e.charAt(1) == '!') {
                notEqual.add(e);
            } else {
                // union equal characters
                uf.union(e.charAt(0) - 'a', e.charAt(3) - 'a');
            }
        }

        for (String e : notEqual) {
            if (uf.find(e.charAt(0) - 'a') == uf.find(e.charAt(3) - 'a')) {
                return false;
            }
        }
        return true;
    }
}

class UF {
    int[] parent;

    UF(int n) {
        parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
    }

    public int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    public void union(int x, int y) {
        if (find(x) != find(y)) {
            parent[find(x)] = find(y);
        }
    }
}
