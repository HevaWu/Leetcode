/*
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
*/

/*
Solution 1:
backtrack
dfs

for each sticks, check which arr we can put it into

Time Complexity: O(4^n)
Space Complexity: O(1)
*/
import java.util.*;

class Solution {
    List<Integer> nums = new ArrayList<>();
    boolean canMake = false;
    int[] options = new int[4];

    public boolean makesquare(int[] matchsticks) {
        int total = 0;
        for(int stick: matchsticks) {
            total += stick;
        }

        if (total % 4 != 0) { return false; }
        int len = total / 4;

       this.nums = Arrays.stream(matchsticks).boxed().collect(Collectors.toList());
        Collections.sort(this.nums, Collections.reverseOrder());

        int n = matchsticks.length;
        check(0, n, len, matchsticks);
        return this.canMake;
    }

    public void check(int index, int n, int len, int[] matchsticks) {
        if (this.canMake) { return; }
        if (index == n) {
            for(int option: options) {
                if (option != len) {
                    return;
                }
            }
            this.canMake = true;
            return;
        }

        for(int i = 0; i < 4; i++) {
            if (matchsticks[index] + this.options[i] <= len) {
                this.options[i] += matchsticks[index];
                check(index+1, n, len, matchsticks);
                this.options[i] -= matchsticks[index];
            }
        }
    }
}