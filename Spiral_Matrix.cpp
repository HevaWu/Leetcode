/*54. Spiral Matrix  QuestionEditorial Solution  My Submissions
Total Accepted: 74909 Total Submissions: 312809 Difficulty: Medium
Given a matrix of m x n elements (m rows, n columns), return all elements of the matrix in spiral order.

For example,
Given the following matrix:

[
 [ 1, 2, 3 ],
 [ 4, 5, 6 ],
 [ 7, 8, 9 ]
]
You should return [1,2,3,6,9,8,7,4,5].

Hide Company Tags Microsoft Google Uber
Hide Tags Array
Hide Similar Problems (M) Spiral Matrix II
*/



/*
traverse right and increment right
then traverse down and decrement down
then traverse left and decrement left
then traverse up and increment up

when traverse left or up, need to check whether the row or col still exists to prevent duplicates*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> spiralOrder(vector<vector<int>>& matrix) {
        vector<int> ret;
        if(matrix.size()==0 || matrix[0].size()==0) return ret;
        int right = 0;
        int down = 0;
        int left = matrix[0].size()-1;
        int up = matrix.size()-1;
        
        while(down<=up && right<=left){
            //traverse right;
            for(int i = right; i <= left; ++i){
                ret.push_back(matrix[down][i]);
            }
            down++;
            
            //traverse down
            for(int i = down; i <= up; ++i){
                ret.push_back(matrix[i][left]);
            }
            left--;
            
            if(down<=up){
                //traverse left
                for(int i = left; i >= right; --i){
                    ret.push_back(matrix[up][i]);
                }
            }
            up--;
            
            if(right<=left){
                //traverse up
                for(int i = up; i >= down; --i){
                    ret.push_back(matrix[i][right]);
                }
            }
            right++;
        }
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<Integer> spiralOrder(int[][] matrix) {
        List<Integer> ret = new ArrayList<>();
        if(matrix.length==0 || matrix[0].length==0) return ret;
        int right = 0;
        int down = 0;
        int left = matrix[0].length-1;
        int up = matrix.length-1;
        
        while(right<=left && down<=up){
            //traverse right
            for(int i = right; i <= left; ++i){
                ret.add(matrix[down][i]);
            }
            down++;
            
            //traverse down
            for(int i = down; i <= up; ++i){
                ret.add(matrix[i][left]);
            }
            left--;
            
            //traverse left
            if(down<=up){//check down and up
                for(int i = left; i >= right; --i){
                    ret.add(matrix[up][i]);
                }
            }
            up--;
            
            //traverse up
            if(right<=left){//check right and left
                for(int i = up; i >= down; --i){
                    ret.add(matrix[i][right]);
                }
            }
            right++;
        }
        return ret;
    }
}
