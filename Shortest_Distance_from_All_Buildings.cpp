/*317. Shortest Distance from All Buildings  QuestionEditorial Solution  My Submissions
Total Accepted: 8145 Total Submissions: 25348 Difficulty: Hard
You want to build a house on an empty land which reaches all buildings in the shortest amount of distance. You can only move up, down, left and right. You are given a 2D grid of values 0, 1 or 2, where:

Each 0 marks an empty land which you can pass by freely.
Each 1 marks a building which you cannot pass through.
Each 2 marks an obstacle which you cannot pass through.
For example, given three buildings at (0,0), (0,4), (2,2), and an obstacle at (0,2):

1 - 0 - 2 - 0 - 1
|   |   |   |   |
0 - 0 - 0 - 0 - 0
|   |   |   |   |
0 - 0 - 1 - 0 - 0
The point (1,2) is an ideal empty land to build a house, as the total travel distance of 3+3+1=7 is minimal. So return 7.

Note:
There will be at least one building. If it is not possible to build such house according to the above rules, return -1.

Hide Company Tags Google Zenefits
Hide Tags Breadth-first Search
Hide Similar Problems (M) Walls and Gates (H) Best Meeting Point
*/



/*  total time  O(m^2*n^2)
traverse matrix, O(number of 1)O(number of 0) ~ O(m^2n^2)   time
for each building, use BFS compute the shortest distance from 0 to building
dis0[][] --- after finishing this all buildings, it is easy to get the sum of shortest distance from each 0 to all buildings, store the distance to dis0[][]
dis1[][] --- how many buildings each 0 can be reached
finalyy, traverse dis0[][] to get the point having shortest distance to all buildings O(m*n) time*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int shortestDistance(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<int> shift = {0,1,0,-1,0};
        vector<vector<int>> dis0(m, vector<int>(n));
        vector<vector<int>> dis1(m, vector<int>(n));
        int buildNum = 0;
        
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                if(grid[i][j] == 1){
                    buildNum++;
                    queue<pair<int,int>> Q;
                    Q.emplace(i,j); //store building position
                    
                    vector<vector<bool>> isVisit(m, vector<bool>(n));
                    int level = 1;
                    
                    while(Q.size()){
                        int qsize = Q.size(); //need to pass qsize to for loop
                        for(int q = 0; q < qsize; ++q){
                            auto ij = Q.front();
                            Q.pop();
                            
                            for(int k = 0; k < 4; ++k){
                                //change 0 to 1, 1 to 0, 0 to -1, -1 to 0
                                int d1 = ij.first + shift[k];
                                int d2 = ij.second + shift[k+1];
                                if(d1>=0 && d1<m && d2>=0 && d2<n 
                                    && grid[d1][d2]==0 
                                    && isVisit[d1][d2]==false){
                                    //the shortest distance from d1,d2 to this building is 'level'
                                    dis0[d1][d2] += level;
                                    dis1[d1][d2]++;
                                    
                                    isVisit[d1][d2] = true;
                                    Q.emplace(d1, d2);
                                }
                            }
                        }
                        level++;
                    }
                }
            }
        }
        
        int ret = INT_MAX;
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                if(grid[i][j]==0 && dis1[i][j]==buildNum){
                    ret = min(ret, dis0[i][j]);
                }
            }
        }
        
        return ret==INT_MAX ? -1 : ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int shortestDistance(int[][] grid) {
        if(grid.length==0 || grid[0].length==0) return 0;
        int m = grid.length;
        int n = grid[0].length;
        
        int[] shift = new int[]{0,1,0,-1,0};
        int[][] dis0 = new int[m][n]; //store the 0 cell to buildings sum distance
        int[][] dis1 = new int[m][n]; //store the 0 cell to howmany buildings
        int buildNum = 0; //count how many buildings in the grid
        
        for(int i = 0; i < m; ++i){
            for(int j =0 ; j < n; ++j){
                if(grid[i][j]==1){
                    //this cell is a building
                    buildNum++;
                    Queue<int[]> Q = new LinkedList<>();
                    Q.offer(new int[]{i,j});
                    
                    boolean[][] isVisit = new boolean[m][n];//check if this cell is visit
                    int level = 1;
                    
                    while(!Q.isEmpty()){
                        int qsize = Q.size();
                        for(int q = 0; q < qsize; ++q){
                            int[] q1 = Q.poll();
                            for(int k = 0; k < 4; ++k){
                                //shift 
                                int d1 = q1[0] + shift[k];
                                int d2 = q1[1] + shift[k+1];
                                
                                if(d1>=0 && d1<m && d2>=0 && d2<n
                                    && grid[d1][d2]==0
                                    && isVisit[d1][d2]==false){
                                    //count this 0 cell
                                    dis0[d1][d2] += level;
                                    dis1[d1][d2] ++;// add this building
                                    
                                    isVisit[d1][d2] = true;
                                    Q.offer(new int[]{d1,d2});
                                }
                            }
                        }
                        level++; //count next 0 cell
                    }
                }
            }
        }
        
        int ret = Integer.MAX_VALUE;
        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                if(grid[i][j]==0 && dis1[i][j]==buildNum){
                    //find the shortest path
                    ret = Math.min(ret, dis0[i][j]);
                }
            }
        }
        return ret==Integer.MAX_VALUE ? -1 : ret;
    }
}
