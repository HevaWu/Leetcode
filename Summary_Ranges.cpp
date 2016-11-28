/*228. Summary Ranges  QuestionEditorial Solution  My Submissions
Total Accepted: 58494 Total Submissions: 219243 Difficulty: Medium
Given a sorted integer array without duplicates, return the summary of its ranges.

For example, given [0,1,2,4,5,7], return ["0->2","4->5","7"].

Credits:
Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Array
Hide Similar Problems (M) Missing Ranges (H) Data Stream as Disjoint Intervals
*/




/*for each element, initialize the step as 1
check how large it can range, and put this range into the ret array*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<string> summaryRanges(vector<int>& nums) {
        vector<string> ret;
        int i = 0;
        int n = nums.size();
        while(i<n){
            int j = 1; //initialize the step
            while(i+j<n && nums[i+j]-nums[i]==j) ++j;//set how large this element can go
            ret.push_back(j<=1 ? to_string(nums[i]) : to_string(nums[i])+"->"+to_string(nums[i+j-1]));  //remember -1, before is ++j
            i += j;
        }
        
        return ret;
    }
};

class Solution {
public:
    vector<string> summaryRanges(vector<int>& nums) {
        int nsize = nums.size();
        vector<string> nrange;  //the vector is a string vector
        
        for(int i = 0; i < nsize;){
            int start = i, end = i;
            while(end+1<nsize && nums[end+1]==nums[end]+1 ) end++;
            if(end > start) nrange.push_back(to_string(nums[start])+"->"+to_string(nums[end]));   //nums[start] not start
            else nrange.push_back(to_string(nums[start]));
            i = end +1;  //through this to control the next value
        }
        return nrange;
    }
};







/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<String> summaryRanges(int[] nums) {
        List<String> ret = new ArrayList<>();
        if(nums==null || nums.length==0) return ret;
        
        int i = 0;
        int n = nums.length;
        while(i<n){
            int j = 1;
            while(i+j<n && nums[i+j]-nums[i]==j) ++j;
            ret.add(j<=1 ? Integer.toString(nums[i]) : 
            Integer.toString(nums[i])+"->"+Integer.toString(nums[i+j-1]));
            /*if(step>=2){
                ret.add(Integer.toString(nums[start]) + "->" + 
                        Integer.toString(nums[start+step-1]));
            } else if(step==1){
                ret.add(Integer.toString(nums[start]));
            }*/
            i += j;
        }
        
        return ret;
    }
}