/*200. Number of Islands  QuestionEditorial Solution  My Submissions
Total Accepted: 57448
Total Submissions: 193760
Difficulty: Medium
Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example 1:

11110
11010
11000
00000
Answer: 1

Example 2:

11000
11000
00100
00011
Answer: 3

Credits:
Special thanks to @mithmatt for adding this problem and creating all test cases.

Hide Company Tags Amazon Microsoft Google Facebook Zenefits
Hide Tags Depth-first Search Breadth-first Search Union Find
Hide Similar Problems (M) Surrounded Regions (M) Walls and Gates (H) Number of Islands II (M) Number of Connected Components in an Undirected Graph
*/



/*When we met a '1', the answer add 1, 
we also need to search all '1' which connected to it directly or indirectly, 
and change it to '0'. And we can use DFS or BFS to search.*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
//DFS
class Solution {
public:
    int numIslands(vector<vector<char>>& grid) {
        if(grid.size() == 0 || grid[0].size() == 0){
            return 0;
        }
        
        int ret = 0;
        for(int i = 0; i < grid.size(); ++i){
            for(int j = 0; j < grid[0].size(); ++j){
                if(grid[i][j] == '1'){
                    ++ret;
                    DFS(grid, i , j);
                }
            }
        }
        return ret;
    }
    
private:
    void DFS(vector<vector<char>>& grid, int x, int y){
        grid[x][y] = '0';
        if(x > 0 && grid[x-1][y] == '1') DFS(grid, x-1, y);
        if(x < grid.size()-1 && grid[x+1][y] == '1') DFS(grid, x+1, y);
        if(y > 0 && grid[x][y-1] == '1') DFS(grid, x, y-1);
        if(y < grid[0].size()-1 && grid[x][y+1] == '1') DFS(grid, x, y+1);
    }
};

//BFS
class Solution {
public:
    int numIslands(vector<vector<char>>& grid) {
        if(grid.size() == 0 || grid[0].size() == 0) return 0;
        
        int ret = 0;
        for(int i = 0; i < grid.size(); ++i){
            for(int j = 0; j < grid[i].size(); ++j){
                if(grid[i][j] == '1'){
                    ret++;
                    BFS(grid, i, j);
                }
            }
        }
        
        return ret;
    }
    
    private:
    void BFS(vector<vector<char>>& grid, int x, int y){
        //use a queue to store the around '1'
        grid[x][y] = '0';
        queue<vector<int>> q;
        q.push({x, y});
        while(!q.empty()){
            x = q.front()[0];
            y = q.front()[1];
            q.pop();
            if(x>0 && grid[x-1][y]=='1'){
                q.push({x-1,y});
                grid[x-1][y] = '0';
            }
            if(x<grid.size()-1 && grid[x+1][y]=='1'){
                q.push({x+1,y});
                grid[x+1][y] = '0';
            }
            if(y>0 && grid[x][y-1]=='1'){
                q.push({x,y-1});
                grid[x][y-1] = '0';
            }
            if(y<grid[0].size()-1 && grid[x][y+1]=='1'){
                q.push({x,y+1});
                grid[x][y+1] = '0';
            }
        }
    }

};





/////////////////////////////////////////////////////////////////////////////////////
//Java
//DFS
public class Solution {
    public int numIslands(char[][] grid) {
        if(grid.length == 0){
            return 0;
        }
        
        int ret = 0;
        for(int i = 0; i < grid.length; ++i){
            for(int j = 0; j < grid[0].length; ++j){
                if(grid[i][j] == '1'){
                    ++ret;
                    DFS(grid, i ,j);
                }
            }
        }
        
        return ret;
    }
    
    private void DFS(char[][] grid, int x, int y){
        if(x < 0 || y < 0 || x >= grid.length || y >= grid[0].length || grid[x][y] != '1') return;
        grid[x][y] = '0'; //mark it as already read
        DFS(grid, x+1, y);
        DFS(grid, x-1, y);
        DFS(grid, x, y+1);
        DFS(grid, x, y-1);
    }
}




public class Solution {
    public int numIslands(char[][] grid) {
        //BFS
        if(grid==null || grid.length==0 || grid[0].length==0) return 0;
        
        int m = grid.length;
        int n = grid[0].length;
        int island = 0;
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                if(grid[i][j]=='1'){
                    BFS(grid, i, j);
                    island++;
                }
            }
        }
        return island;
    }
    
    private void BFS(char[][] grid, int x, int y){
        grid[x][y]='0';
        Queue<int[]> Q = new LinkedList<>();
        Q.offer(new int[]{x,y});
        int m = grid.length;
        int n = grid[0].length;
        while(!Q.isEmpty()){
            int[] cur = Q.poll();
            int xx = cur[0];
            int yy = cur[1];
            if(xx>0 && grid[xx-1][yy]=='1') {
                grid[xx-1][yy] = '0';
                Q.offer(new int[]{xx-1,yy});
            }
            if(xx<m-1 && grid[xx+1][yy]=='1'){
                grid[xx+1][yy]='0';
                Q.offer(new int[]{xx+1,yy});
            }
            if(yy>0 && grid[xx][yy-1]=='1'){
                grid[xx][yy-1] = '0';
                Q.offer(new int[]{xx,yy-1});
            }
            if(yy<n-1 && grid[xx][yy+1]=='1'){
                grid[xx][yy+1] = '0';
                Q.offer(new int[]{xx,yy+1});
            }
        }
    }
}