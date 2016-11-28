/*163. Missing Ranges  QuestionEditorial Solution  My Submissions
Total Accepted: 17183
Total Submissions: 55906
Difficulty: Medium
Given a sorted integer array where the range of elements are [lower, upper] inclusive, return its missing ranges.

For example, given [0, 1, 3, 50, 75], lower = 0 and upper = 99, return ["2", "4->49", "51->74", "76->99"].

Hide Company Tags Google
Hide Tags Array
Hide Similar Problems (M) Summary Ranges
*/



/*set a start and end for a new string
for each element in given array, check if there is a new range between this element and former element*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<string> findMissingRanges(vector<int>& nums, int lower, int upper) {
        vector<string> ret;
        int start = lower-1;  //when get range we do start+1
        for(int i = 0; i <= nums.size(); i++){ //check until the last element
            int end = (i==nums.size() ? upper+1 : nums[i]); // when get range we do end-1
            if(end-start >= 2){//insert new range
                ret.push_back(getRange(start+1, end-1));
            }
            start = end; // reset the start
        }
        
        return ret;
    }
    
    string getRange(int start, int end){
        return start==end ? to_string(start) : to_string(start)+"->"+to_string(end);
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<String> findMissingRanges(int[] nums, int lower, int upper) {
        List<String> ret = new ArrayList<>();
        int start = lower - 1;
        for(int i = 0; i <= nums.length; ++i){
            int end = (i==nums.length ? upper+1 : nums[i]);
            if(end-start >= 2){
                ret.add(getRange(start+1, end-1));
            }
            start = end;
        }
        return ret;
    }
    
    public String getRange(int start, int end){
        return start==end ? Integer.toString(start) : Integer.toString(start)+"->"+Integer.toString(end);
    }
}
