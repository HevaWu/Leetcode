/*305. Number of Islands II  QuestionEditorial Solution  My Submissions
Total Accepted: 11748 Total Submissions: 32004 Difficulty: Hard
A 2d grid map of m rows and n columns is initially filled with water. We may perform an addLand operation which turns the water at position (row, col) into a land. Given a list of positions to operate, count the number of islands after each addLand operation. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example:

Given m = 3, n = 3, positions = [[0,0], [0,1], [1,2], [2,1]].
Initially, the 2d grid grid is filled with water. (Assume 0 represents water and 1 represents land).

0 0 0
0 0 0
0 0 0
Operation #1: addLand(0, 0) turns the water at grid[0][0] into a land.

1 0 0
0 0 0   Number of islands = 1
0 0 0
Operation #2: addLand(0, 1) turns the water at grid[0][1] into a land.

1 1 0
0 0 0   Number of islands = 1
0 0 0
Operation #3: addLand(1, 2) turns the water at grid[1][2] into a land.

1 1 0
0 0 1   Number of islands = 2
0 0 0
Operation #4: addLand(2, 1) turns the water at grid[2][1] into a land.

1 1 0
0 0 1   Number of islands = 3
0 1 0
We return the result as an array: [1, 1, 2, 3]

Challenge:

Can you do it in time complexity O(k log mn), where k is the length of the positions?

Hide Company Tags Google
Hide Tags Union Find
Hide Similar Problems (M) Number of Islands
*/



/*
union find
see a list of islands as trees, If roots[c] = p means the parent of node c is p, we can climb up the parent chain to find out the identifier of an island
perform a linear mapping, through n * i + j
initially, assume each cell in roots[] is -1

union --- change root parent O(1), search four directions from this point, if the roots[neighbors] == -1, there is not an island join this point, 
if != -1, there is an island, join this point to that island, and update the roots value

find --- to the depth of the tree O(logn), search 4 directions O(nlogn), if no balancing, the worse case O(n^2)

note: 1 island could have different roots[node], which means different parent*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> numIslands2(int m, int n, vector<pair<int, int>>& positions) {
        vector<int> ret;
        if(m<=0 || n <=0) return ret;
        
        int numIsland = 0; //count the number of islands
        vector<int> roots(m*n, -1); //one island = one tree
        vector<vector<int>> dirs = {{-1,0},{1,0},{0,1},{0,-1}}; //four directions
        
        for(pair<int,int> p:positions){
            int root = n * p.first + p.second;
            roots[root] = root; //add a new island
            numIsland++;
            
            for(vector<int> d:dirs){
                int x = p.first + d[0];
                int y = p.second + d[1];
                int newId = n * x + y;
                if(x<0 || x>=m || y<0 || y>=n || roots[newId]==-1){
                    continue;
                }
                
                //not -1, there is already an island
                int rootId = findIsland(roots, newId);
                if(root != rootId){
                    roots[root] = rootId; 
                    root = rootId; //union this to neighbor island
                    numIsland--;
                }
            }
            ret.push_back(numIsland);
        }
        return ret;
    }
    
    int findIsland(vector<int>& roots, int id){
        while(id != roots[id]){
            roots[id] = roots[roots[id]];
            id = roots[id];
        }
        return id;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<Integer> numIslands2(int m, int n, int[][] positions) {
        List<Integer> ret = new ArrayList<>();
        if(m<=0 || n <=0) return ret;
        
        int numIsland = 0; //count the number of islands
        int[] roots = new int[m*n]; //one island = one tree
        Arrays.fill(roots, -1); //initialize -1
        int[][] dirs = {{-1,0},{1,0},{0,1},{0,-1}}; //four directions
        
        for(int[] p:positions){
            int root = n * p[0] + p[1];
            roots[root] = root; //assume it is a isolated island, add this island
            numIsland++;
            
            for(int[] d: dirs){
                int x = d[0] + p[0];
                int y = d[1] + p[1];
                int newId = n * x + y;
                if(x<0 || x>=m || y<0 || y>=n || roots[newId]==-1){
                    continue;
                }
                
                //not -1, there is an island join this point
                int rootId = findIsland(roots, newId);
                if(rootId != root){
                    roots[root] = rootId;
                    root = rootId; //union this point to the island
                    numIsland--;
                }
            }
            
            ret.add(numIsland);
        }
        return ret;
    }
    
    public int findIsland(int[] roots, int id){
        while(id!=roots[id]){
            roots[id] = roots[roots[id]];
            id = roots[id];
        }
        return id;
    }
}
