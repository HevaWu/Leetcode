/*486. Predict the Winner Add to List
Description  Submission  Solutions
Total Accepted: 4265
Total Submissions: 9781
Difficulty: Medium
Contributors: sameer13
Given an array of scores that are non-negative integers. Player 1 picks one of the numbers from either end of the array followed by the player 2 and then player 1 and so on. Each time a player picks a number, that number will not be available for the next player. This continues until all the scores have been chosen. The player with the maximum score wins.

Given an array of scores, predict whether player 1 is the winner. You can assume each player plays to maximize his score.

Example 1:
Input: [1, 5, 2]
Output: False
Explanation: Initially, player 1 can choose between 1 and 2.
If he chooses 2 (or 1), then player 2 can choose from 1 (or 2) and 5. If player 2 chooses 5, then player 1 will be left with 1 (or 2).
So, final score of player 1 is 1 + 2 = 3, and player 2 is 5.
Hence, player 1 will never be the winner and you need to return False.
Example 2:
Input: [1, 5, 233, 7]
Output: True
Explanation: Player 1 first chooses 1. Then player 2 have to choose between 5 and 7. No matter which number player 2 choose, player 1 can choose 233.
Finally, player 1 has more score (234) than player 2 (12), so you need to return True representing player1 can win.
Note:
1 <= length of the array <= 20.
Any scores in the given array are non-negative integers and will not exceed 10,000,000.
If the scores of both players are equal, then player 1 is still the winner.
Hide Company Tags Google
Hide Tags Dynamic Programming Minimax
Hide Similar Problems (M) Can I Win
*/






/*
Dynamic Programming
O(n^2) time
O(n^2) space
Player 1 wants to win, need to satisfy get more than player gets, which means more than sum/2
Assume we are the player 1, each time we gets the number we "plus" it,
another player gets number we "minus" it
At the end, we check if the total number is > 0, if it is, player 1 win

set a 2D array to help check
score[i][j] means player 1 get numbers between i to j
if(s==e) return nums[e]
else if player choose the end, return nums[s]-check(nums, s, e-1, score)
     if player choose the start, return nums[e]-check(nums, s+1, e, score)
at the end, we only need to check if current score is >= 0
 */

////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean PredictTheWinner(int[] nums) {
        if(nums.length == 0) return true;
        int len = nums.length;
        return check(nums, 0, len-1, new Integer[len][len]) >= 0; //when player 1 and player 2 get the same scores, player 1 win
    }

    public int check(int[] nums, int s, int e, Integer[][] score){  //use Integer Array, the value might be null
        if(score[s][e] == null){
            score[s][e] = s==e ? nums[s] : Math.max(nums[s]-check(nums, s+1, e, score), nums[e]-check(nums, s, e-1, score));
        }
        return score[s][e];
    }
}
