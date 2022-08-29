
/*
Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example 1:

Input:
11110
11010
11000
00000

Output: 1
Example 2:

Input:
11000
11000
00100
00011

Output: 3
*/

/*
Solution 1:
for each point, if we find it is `1` mark it as an island, use dfs to check all of its surrounding `1` and change them to `0`, until we search all, keep finding the next island

Time Complexity: O(MN)
Space Complexity: O(MN)
*/
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