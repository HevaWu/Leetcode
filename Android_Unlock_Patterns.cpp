/*351. Android Unlock Patterns   QuestionEditorial Solution  My Submissions
Total Accepted: 5629 Total Submissions: 13951 Difficulty: Medium Contributors: Admin
Given an Android 3x3 key lock screen and two integers m and n, where 1 ≤ m ≤ n ≤ 9, count the total number of unlock patterns of the Android lock screen, which consist of minimum of m keys and maximum n keys.

Rules for a valid pattern:
Each pattern must connect at least m keys and at most n keys.
All the keys must be distinct.
If the line connecting two consecutive keys in the pattern passes through any other keys, the other keys must have previously selected in the pattern. No jumps through non selected key is allowed.
The order of keys used matters.

Explanation:
| 1 | 2 | 3 |
| 4 | 5 | 6 |
| 7 | 8 | 9 |
Invalid move: 4 - 1 - 3 - 6 
Line 1 - 3 passes through key 2 which had not been selected in the pattern.

Invalid move: 4 - 1 - 9 - 2
Line 1 - 9 passes through key 5 which had not been selected in the pattern.

Valid move: 2 - 4 - 1 - 3 - 6
Line 1 - 3 is valid because it passes through key 2, which had been selected in the pattern

Valid move: 6 - 5 - 4 - 1 - 9 - 2
Line 1 - 9 is valid because it passes through key 5, which had been selected in the pattern.

Example:
Given m = 1, n = 1, return 9.

Credits:
Special thanks to @elmirap for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Dynamic Programming Backtracking
*/



/*DFS 
1,3,7,9 are symmetric, 2,4,6,8 are symmetric
so, we only calculate 1 among each group and multiply 4
skip[][] array store number to skip between two numbers
visit[] array to check if this number is already been visit
recursively check the 9 number and choices

 the time complexity is
O(3 * sigma(i = m to n) ((8!) / (9 - i)!)), but not very precise.

Starting from 5, we have 8 choices. After we choose one number as our next step, suppose 3, we have 7 choices remaining. Then we have 6 remaining, we keep this procedure until we reach step i. The search tree is of size (8!) / (9 - i)!

Search tree starting from 1 or 2 apperantly will not have as much node as starting from 5, but the difference is of constant factor.
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int numberOfPatterns(int m, int n) {
        vector<vector<int>> skip(10, vector<int>(10));
        skip[1][3] = skip[3][1] = 2;
        skip[1][7] = skip[7][1] = 4;
        skip[7][9] = skip[9][7] = 8;
        skip[9][3] = skip[3][9] = 6;
        skip[1][9] = skip[9][1] = skip[3][7] = skip[7][3] = skip[2][8] = skip[8][2] = skip[4][6] = skip[6][4] = 5;
        
        vector<bool> visit(10, false);
        int ret = 0;
        for(int i = m; i <= n; ++i){
            ret += getPattern(visit, skip, 1, i-1) * 4; 
            ret += getPattern(visit, skip, 2, i-1) * 4;
            ret += getPattern(visit, skip, 5, i-1);
        }
        return ret;
    }
    
    int getPattern(vector<bool>& visit, vector<vector<int>> skip, int cur, int remain){
        if(remain < 0) return 0;
        if(remain == 0) return 1;
        
        visit[cur] = true;
        int ret = 0;
        for(int i = 1; i <= 9; ++i){
            if(visit[i]==false && (skip[cur][i]==0 || visit[skip[cur][i]]==true)){
                ret += getPattern(visit, skip, i, remain-1);
            }
        }
        visit[cur] = false;
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int numberOfPatterns(int m, int n) {
        //build skip array
        int[][] skip = new int[10][10];
        //pay attention to this, not input wrong number
        skip[1][3] = skip[3][1] = 2;
        skip[1][7] = skip[7][1] = 4;
        skip[7][9] = skip[9][7] = 8;
        skip[9][3] = skip[3][9] = 6;
        skip[1][9] = skip[9][1] = skip[3][7] = skip[7][3] = skip[2][8] = skip[8][2] = skip[4][6] = skip[6][4] = 5;
        
        int ret = 0;
        boolean[] visit = new boolean[10]; //check if this number is already visit
        for(int i = m; i <= n; ++i){
            //from m to n
            ret += getPattern(visit, skip, 1, i-1) * 4;//1,3,7,9 are symmetric
            ret += getPattern(visit, skip, 2, i-1) * 4;//2,4,8,6 are symmetric
            ret += getPattern(visit, skip, 5, i-1);
        }
        return ret;
    }
    
    public int getPattern(boolean[] visit, int[][] skip, int cur, int remain){
        if(remain<0) return 0;
        if(remain==0) return 1;
        
        int ret = 0;
        visit[cur] = true; //visit this number
        for(int i = 1; i <= 9; ++i){
            if(!visit[i] && (visit[skip[cur][i]] || skip[cur][i]==0)){
                //if visit[i] isnot visit and 
                //  there is no number between cur,i, means they are adjacent
                //  or the number between cur,i is already visit
                ret += getPattern(visit, skip, i, remain-1);
            } 
        }
        visit[cur] = false; //recover cur number
        return ret;
    }
}
