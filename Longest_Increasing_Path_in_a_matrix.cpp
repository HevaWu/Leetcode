/*
329. Longest Increasing Path in a Matrix  QuestionEditorial Solution  My Submissions
Total Accepted: 22836 Total Submissions: 66907 Difficulty: Hard
Given an integer matrix, find the length of the longest increasing path.

From each cell, you can either move to four directions: left, right, up or down. You may NOT move diagonally or move outside of the boundary (i.e. wrap-around is not allowed).

Example 1:

nums = [
  [9,9,4],
  [6,6,8],
  [2,1,1]
]
Return 4
The longest increasing path is [1, 2, 6, 9].

Example 2:

nums = [
  [3,4,5],
  [3,2,6],
  [2,2,1]
]
Return 4
The longest increasing path is [3, 4, 5, 6]. Moving diagonally is not allowed.

Credits:
Special thanks to @dietpepsi for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Depth-first Search Topological Sort Memoization
*/




/* O (mn) DFS
for each cell, check its longest path in matrix by increasePath() function
and compare it to ret
longPath[][] --- array store each cells longest path
increasePath() --- define four directions, recursively dfs its longest path*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int longestIncreasingPath(vector<vector<int>>& matrix) {
        int rows = matrix.size();
        if(!rows) return 0;
        int cols = matrix[0].size();

        vector<vector<int> > longPath(rows, vector<int>(cols,0) );  //vector<vector<int> >
        std::function<int(int,int) > increasePath = [&](int x, int y)  //definition of a function increasePath
        {
            if(longPath[x][y]) return longPath[x][y];
            vector<vector<int> > choos = {{-1,0},{1,0},{0,1},{0,-1} };  //vector<vector<int> >
            for(auto &dir:choos)
            {
                int xx = x + dir[0];
                int yy = y + dir[1];
                if(xx<0 || xx>=rows || yy<0 || yy>=cols) continue;
                if(matrix[xx][yy] <= matrix[x][y]) continue;

                longPath[x][y] = max(longPath[x][y], increasePath(xx,yy));
            }
            return ++longPath[x][y];
        };  // do not forget ";"

        int retu=0; //remember initiate retu
        for(int i = 0; i < rows; i++)
        {
            for(int j = 0; j < cols; j++)
            {
                retu = max(retu, increasePath(i,j));
            }
        }
        return retu;

    }
};

