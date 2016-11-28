/*375. Guess Number Higher or Lower II   QuestionEditorial Solution  My Submissions
Total Accepted: 11867
Total Submissions: 34824
Difficulty: Medium
Contributors: Admin
We are playing the Guess Game. The game is as follows:

I pick a number from 1 to n. You have to guess which number I picked.

Every time you guess wrong, I'll tell you whether the number I picked is higher or lower.

However, when you guess a particular number x, and you guess wrong, you pay $x. You win the game when you guess the number I picked.

Example:

n = 10, I pick 8.

First round:  You guess 5, I tell you that it's higher. You pay $5.
Second round: You guess 7, I tell you that it's higher. You pay $7.
Third round:  You guess 9, I tell you that it's lower. You pay $9.

Game over. 8 is the number I picked.

You end up paying $5 + $7 + $9 = $21.
Given a particular n ≥ 1, find out how much money you need to have to guarantee a win.

Hint:

The best strategy to play the game is to minimize the maximum loss you could possibly face. Another strategy is to minimize the expected loss. Here, we are interested in the first scenario.
Take a small example (n = 3). What do you end up paying in the worst case?
Check out this article if you're still stuck.
The purely recursive implementation of minimax would be worthless for even a small n. You MUST use dynamic programming.
As a follow-up, how would you modify your code to solve the problem of minimizing the expected loss, instead of the worst-case loss?
Credits:
Special thanks to @agave and @StefanPochmann for adding this problem and creating all test cases.

Subscribe to see which companies asked this question

Hide Tags Dynamic Programming
Hide Similar Problems (M) Flip Game II (E) Guess Number Higher or Lower
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*DP Dynamic Programming
for each number x in range [i,j]
pick_x = x + max(DP(i,x-1), DP(x+1, j))
choose the max feed back
DP(i,j) = min(xi .. xj)
pick the minimize cost*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int getMoneyAmount(int n) {
        int[][] mydp = new int[n+1][n+1];
        return DP(mydp, 1, n); //start from 1 to n
    }

    public int DP(int[][] mydp, int s, int e){
        if(s>=e) return 0;
        if(mydp[s][e] != 0) return mydp[s][e];
        int ret = Integer.MAX_VALUE;
        for(int i = s; i <= e; ++i){
            int temp = i + Math.max(DP(mydp, s, i-1), DP(mydp, i+1, e)); //find the maximum feedback
            ret = Math.min(ret, temp); //get the min value of the list of temp
        }
        mydp[s][e] = ret;
        return ret;
    }
}
