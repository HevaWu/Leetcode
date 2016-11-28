/*417. Pacific Atlantic Water Flow   QuestionEditorial Solution  My Submissions
Total Accepted: 2470 Total Submissions: 8120 Difficulty: Medium Contributors: Admin
Given an m x n matrix of non-negative integers representing the height of each unit cell in a continent, the "Pacific ocean" touches the left and top edges of the matrix and the "Atlantic ocean" touches the right and bottom edges.

Water can only flow in four directions (up, down, left, or right) from a cell to another one with height equal or lower.

Find the list of grid coordinates where water can flow to both the Pacific and Atlantic ocean.

Note:
The order of returned grid coordinates does not matter.
Both m and n are less than 150.
Example:

Given the following 5x5 matrix:

  Pacific ~   ~   ~   ~   ~ 
       ~  1   2   2   3  (5) *
       ~  3   2   3  (4) (4) *
       ~  2   4  (5)  3   1  *
       ~ (6) (7)  1   4   5  *
       ~ (5)  1   1   2   4  *
          *   *   *   *   * Atlantic

Return:

[[0, 4], [1, 3], [1, 4], [2, 2], [3, 0], [3, 1], [4, 0]] (positions with parentheses in above matrix).
Hide Company Tags Google
Hide Tags Depth-first Search Breadth-first Search
*/



/*
BFS:queue
DFS:recursive find

idea:
check start from all border of Pacific and Atlantic
use two array to store the visit situation, one for pacific one for atlantic
Water flood from ocean to the cell. Since water can only flow from high/equal cell to low cell, add the neighboor cell with height larger or equal to current cell to the queue and mark as visited.
at the end, we check if there is a cell visit both pacific and atlantic,
if it is, push this cell coordinate to return list*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<pair<int, int>> res;
    vector<vector<int>> visited;
    void dfs(vector<vector<int>>& matrix, int x, int y, int pre, int preval){
        if (x < 0 || x >= matrix.size() || y < 0 || y >= matrix[0].size()  
                || matrix[x][y] < pre || (visited[x][y] & preval) == preval) 
            return;
        visited[x][y] |= preval;
        if (visited[x][y] == 3) res.push_back({x, y});
        dfs(matrix, x + 1, y, matrix[x][y], visited[x][y]); dfs(matrix, x - 1, y, matrix[x][y], visited[x][y]);
        dfs(matrix, x, y + 1, matrix[x][y], visited[x][y]); dfs(matrix, x, y - 1, matrix[x][y], visited[x][y]);
    }

    vector<pair<int, int>> pacificAtlantic(vector<vector<int>>& matrix) {
        if (matrix.empty()) return res;
        int m = matrix.size(), n = matrix[0].size();
        visited.resize(m, vector<int>(n, 0));
        for (int i = 0; i < m; i++) {
            dfs(matrix, i, 0, INT_MIN, 1);
            dfs(matrix, i, n - 1, INT_MIN, 2);
        }
        for (int i = 0; i < n; i++) {
            dfs(matrix, 0, i, INT_MIN, 1);
            dfs(matrix, m - 1, i, INT_MIN, 2);
        }
        return res;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    //four directions
    private int[][] dir = new int[][]{{0,1},{0,-1},{1,0},{-1,0}};
    
    public List<int[]> pacificAtlantic(int[][] matrix) {
        //solution BFS
        List<int[]> ret = new ArrayList<>();
        if(matrix==null || matrix.length==0 || matrix[0].length==0) return ret;
        int m = matrix.length;
        int n = matrix[0].length;
        
        //one visit array for pacific and atlantic
        boolean[][] pacific = new boolean[m][n];
        boolean[][] atlantic = new boolean[m][n];
        Queue<int[]> pQ = new LinkedList<>();
        Queue<int[]> aQ = new LinkedList<>();
        for(int i = 0; i < m; ++i){//vertical border
            pQ.offer(new int[]{i,0});
            aQ.offer(new int[]{i, n-1});
            pacific[i][0] = true;
            atlantic[i][n-1] = true;
        }
        for(int i = 0; i < n; ++i){//horizental border
            pQ.offer(new int[]{0,i});
            aQ.offer(new int[]{m-1, i});
            pacific[0][i] = true;
            atlantic[m-1][i] = true;
        }
        
        //find which cell can be overflowed
        bfs(matrix, pacific, pQ);
        bfs(matrix, atlantic, aQ);
        
        //check if there is a cell both been visited at pacific and atlantic
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                if(pacific[i][j]==true && atlantic[i][j]==true){
                    ret.add(new int[]{i,j});
                }
            }
        }
        
        return ret;
    }
    
    public void bfs(int[][] matrix, boolean[][] visit, Queue<int[]> Q){
        //check if the cell can be overflowed
        int m = matrix.length;
        int n = matrix[0].length;
        
        while(!Q.isEmpty()){
            int[] cur = Q.poll();
            for(int[] d:dir){
                int x = cur[0] + d[0];
                int y = cur[1] + d[1];
                
                if(x<0 || x>=m || y<0 || y>=n || visit[x][y]==true 
                    || matrix[x][y]<matrix[cur[0]][cur[1]]){
                        continue;
                    }
                
                visit[x][y] = true;
                Q.offer(new int[]{x,y});
            }
        }
    }
}





public class Solution {
    //four directions
    private int[][] dir = new int[][]{{0,1},{0,-1},{1,0},{-1,0}};
    
    public List<int[]> pacificAtlantic(int[][] matrix) {
        //solution DFS
        List<int[]> ret = new ArrayList<>();
        if(matrix==null || matrix.length==0 || matrix[0].length==0) return ret;
        int m = matrix.length;
        int n = matrix[0].length;
        
        //one visit array for pacific and atlantic
        boolean[][] pacific = new boolean[m][n];
        boolean[][] atlantic = new boolean[m][n];
        for(int i = 0; i < m; ++i){//vertical border
            dfs(matrix, pacific, Integer.MIN_VALUE, i, 0);
            dfs(matrix, atlantic, Integer.MIN_VALUE, i, n-1);
        }
        for(int i = 0; i < n; ++i){//horizental border
            dfs(matrix, pacific, Integer.MIN_VALUE, 0, i);
            dfs(matrix, atlantic, Integer.MIN_VALUE, m-1, i);
        }
        
        //check if there is a cell both been visited at pacific and atlantic
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                if(pacific[i][j]==true && atlantic[i][j]==true){
                    ret.add(new int[]{i,j});
                }
            }
        }
        
        return ret;
    }
    
    public void dfs(int[][] matrix, boolean[][] visit, int height, int x, int y){
        //check if the cell can be overflowed
        int m = matrix.length;
        int n = matrix[0].length;
        
        if(x<0 || x>=m || y<0 || y>=n || visit[x][y] || matrix[x][y]<height){
            return;
        }
        
        visit[x][y] = true;
        for(int[] d:dir){
            dfs(matrix, visit, matrix[x][y], x+d[0], y+d[1]);
        }
    }
}
