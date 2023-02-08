/*45. Jump Game II   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 82176
Total Submissions: 315816
Difficulty: Hard
Contributors: Admin
Given an array of non-negative integers, you are initially positioned at the first index of the array.

Each element in the array represents your maximum jump length at that position.

Your goal is to reach the last index in the minimum number of jumps.

For example:
Given array A = [2,3,1,1,4]

The minimum number of jumps to reach the last index is 2. (Jump 1 step from index 0 to 1, then 3 steps to the last index.)

Note:
You can assume that you can always reach the last index.

Hide Tags Array Greedy
*/

/*greedy
O(n) time
the range of the current jump is [curBegin, curEnd]
curFarthest is the farthest point that all points in [curBegin, curEnd] can reach
once the currend point reaches curEnd, trigger another jump, and set the new curEnd
keep do this
*/
public class Solution {
    public int jump(int[] nums) {
        int curBegin = 0;
        int curEnd = 0;
        int curFar = 0;
        int jump = 0;
        for(int i = 0; i < nums.length-1; ++i){ //remember -1
            curFar = Math.max(curFar, i + nums[i]); //find current largest range
            if(i == curEnd){
                jump++; //start another jump
                curEnd = curFar; //update the range
            }
        }
        return jump;
    }
}

