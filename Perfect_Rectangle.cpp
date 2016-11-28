/*391. Perfect Rectangle   QuestionEditorial Solution  My Submissions
Total Accepted: 3606 Total Submissions: 18016 Difficulty: Hard Contributors: Admin
Given N axis-aligned rectangles where N > 0, determine if they all together form an exact cover of a rectangular region.

Each rectangle is represented as a bottom-left point and a top-right point. For example, a unit square is represented as [1,1,2,2]. (coordinate of bottom-left point is (1, 1) and top-right point is (2, 2)).


Example 1:

rectangles = [
  [1,1,3,3],
  [3,1,4,2],
  [3,2,4,4],
  [1,3,2,4],
  [2,3,3,4]
]

Return true. All 5 rectangles together form an exact cover of a rectangular region.

Example 2:

rectangles = [
  [1,1,2,3],
  [1,3,2,4],
  [3,1,4,2],
  [3,2,4,4]
]

Return false. Because there is a gap between the two rectangular regions.

Example 3:

rectangles = [
  [1,1,3,3],
  [3,1,4,2],
  [1,3,2,4],
  [3,2,4,4]
]

Return false. Because there is a gap in the top center.

Example 4:

rectangles = [
  [1,1,3,3],
  [3,1,4,2],
  [1,3,2,4],
  [2,2,4,4]
]

Return false. Because two of the rectangles overlap with each other.
Hide Company Tags Google
*/



/* O(n) time 
satisfy two conditions:
1. the large rectangle area should be equal to the sum of small rectangles
2. count of all the points should be even, and that of all the four corner points should be one

set x1 y1 x2 y2 for final rectangle
use hashset to store the angle point, after insert each rectangle
at the last, check if the set only contains four angle for the final rectangel
if it is not, return false
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    bool isRectangleCover(vector<vector<int>>& rectangles) {
        if(rectangles.size()==0 || rectangles[0].size()==0) return false;
        
        int x1 = INT_MAX, y1 = INT_MAX;
        int x2 = INT_MIN, y2 = INT_MIN;
        
        unordered_set<string> myset;
        int area = 0;
        
        for(vector<int> r:rectangles){
            
            x1 = min(r[0], x1);
            y1 = min(r[1], y1);
            x2 = max(r[2], x2);
            y2 = max(r[3], y2);
            
            area += (r[2]-r[0])*(r[3]-r[1]);
            
            string s1 = to_string(r[0]) + " " + to_string(r[1]);
            string s2 = to_string(r[0]) + " " + to_string(r[3]);
            string s3 = to_string(r[2]) + " " + to_string(r[1]);
            string s4 = to_string(r[2]) + " " + to_string(r[3]);
            
            if(myset.find(s1)!=myset.end()) myset.erase(myset.find(s1));
            else {
                myset.emplace(s1);
                // cout << s1 << endl;
            }
                

            if(myset.find(s2)!=myset.end()) myset.erase(myset.find(s2));
            else {
                myset.emplace(s2);
                // cout << s2 << endl;
            }

            if(myset.find(s3)!=myset.end()) myset.erase(myset.find(s3));
            else {
                myset.emplace(s3);
                // cout << s3 << endl;
            }

            if(myset.find(s4)!=myset.end()) myset.erase(myset.find(s4));
            else {
                myset.emplace(s4);
                // cout << s4 << endl;
            }
            // cout << myset.size() << endl;
        }
        
        if(myset.find(to_string(x1)+" "+to_string(y1))==myset.end()
            || myset.find(to_string(x1)+" "+to_string(y2))==myset.end()
            || myset.find(to_string(x2)+" "+to_string(y1))==myset.end()
            || myset.find(to_string(x2)+" "+to_string(y2))==myset.end()
            || myset.size()!=4){
                // cout << myset.size() << endl;
                return false;
            }
            
        return area == (x2-x1)*(y2-y1);
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean isRectangleCover(int[][] rectangles) {
        if(rectangles.length==0 || rectangles[0].length==0) return false;
        
        Set<String> myset = new HashSet<>();//store all angle points 
        
        // x1 y1 x2 y2 is the final return rectangle points
        int x1 = Integer.MAX_VALUE, y1 = Integer.MAX_VALUE;
        int x2 = Integer.MIN_VALUE, y2 = Integer.MIN_VALUE;
        int area = 0; //the final rectangle area
        
        for(int[] r:rectangles){
            x1 = Math.min(x1, r[0]);
            y1 = Math.min(y1, r[1]);
            x2 = Math.max(x2, r[2]);
            y2 = Math.max(y2, r[3]);
            
            area += (r[2]-r[0])*(r[3]-r[1]);
            
            //four angle points
            String s1 = r[0] + " " + r[1];
            String s2 = r[0] + " " + r[3];
            String s3 = r[2] + " " + r[1];
            String s4 = r[2] + " " + r[3];
            
            if(myset.contains(s1)) myset.remove(s1);
            else myset.add(s1);
            if(myset.contains(s2)) myset.remove(s2);
            else myset.add(s2);
            if(myset.contains(s3)) myset.remove(s3);
            else myset.add(s3);
            if(myset.contains(s4)) myset.remove(s4);
            else myset.add(s4);
        }
        
        if(!myset.contains(x1 + " " + y1)
            || !myset.contains(x1 + " " + y2)
            || !myset.contains(x2 + " " + y1)
            || !myset.contains(x2 + " " + y2)
            || myset.size() != 4){
                return false;
            }
            
        return area == (x2-x1)*(y2-y1);
    }
}
