/*286. Walls and Gates  QuestionEditorial Solution  My Submissions
Total Accepted: 16681 Total Submissions: 41393 Difficulty: Medium
You are given a m x n 2D grid initialized with these three possible values.

-1 - A wall or an obstacle.
0 - A gate.
INF - Infinity means an empty room. We use the value 231 - 1 = 2147483647 to represent INF as you may assume that the distance to a gate is less than 2147483647.
Fill each empty room with the distance to its nearest gate. If it is impossible to reach a gate, it should be filled with INF.

For example, given the 2D grid:
INF  -1  0  INF
INF INF INF  -1
INF  -1 INF  -1
  0  -1 INF INF
After running your function, the 2D grid should be:
  3  -1   0   1
  2   2   1  -1
  1  -1   2  -1
  0  -1   3   4
Hide Company Tags Google Facebook
Hide Tags Breadth-first Search
Hide Similar Problems (M) Surrounded Regions (M) Number of Islands (H) Shortest Distance from All Buildings
*/



/* BFS O(mn) time 
push all gates into queue first,
for each gate, update its neighbor cells, and push them to queue
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    void wallsAndGates(vector<vector<int>>& rooms) {
        if(rooms.size()==0 || rooms[0].size()==0) return;
        queue<pair<int, int>> myqueue;
        int row = rooms.size();
        int col = rooms[0].size();
        //find all 0 gates 
        for(int i = 0; i < row; ++i){
            for(int j = 0; j < col; ++j){
                if(rooms[i][j] == 0){
                    myqueue.emplace(i,j);
                }
            }
        }
        
        //set four directions
        vector<pair<int,int>> dirs = {{-1,0},{1,0},{0,1},{0,-1}};
        while(!myqueue.empty()){
            int first = myqueue.front().first;
            int second = myqueue.front().second;
            myqueue.pop();
            for(auto d:dirs){
                int x = first+d.first;
                int y = second + d.second;
                // if x y out of range or it is obstasle, or has small distance aready
                if(x<0 || x>=row || y<0 || y>=col 
                    || rooms[x][y]<=rooms[first][second]) continue;
                
                rooms[x][y] = rooms[first][second] + 1;
                myqueue.emplace(x,y);
            }
        }
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public void wallsAndGates(int[][] rooms) {
        if(rooms.length==0 || rooms[0].length==0) return;
        Queue<int[]> myqueue = new LinkedList<>();
        int row = rooms.length;
        int col = rooms[0].length;
        //find all 0 gates
        for(int i = 0; i < row; ++i){
            for(int j = 0; j < col; ++j){
                if(rooms[i][j] == 0){
                    myqueue.add(new int[]{i,j});
                }
            }
        }
        
        //set four directions
        int[][] dirs = new int[][]{{-1,0},{1,0},{0,1},{0,-1}};
        while(!myqueue.isEmpty()){
            int[] q = myqueue.remove();
            for(int[] d:dirs){
                int x = q[0] + d[0];
                int y = q[1] + d[1];
                // if x y out of range or it is obstasle, or has small distance aready
                if(x<0 || x>= row || y<0 || y>= col
                    || rooms[x][y]<=rooms[q[0]][q[1]]) continue;
                
                rooms[x][y] = rooms[q[0]][q[1]] + 1;
                myqueue.add(new int[]{x,y});
            }
        }
    }
}
