/*179. Largest Number  QuestionEditorial Solution  My Submissions
Total Accepted: 54761
Total Submissions: 267596
Difficulty: Medium
Given a list of non negative integers, arrange them such that they form the largest number.

For example, given [3, 30, 34, 5, 9], the largest formed number is 9534330.

Note: The result may be very large, so you need to return a string instead of an integer.

Credits:
Special thanks to @ts for adding this problem and creating all test cases.

Subscribe to see which companies asked this question

Show Tags
*/



/*sort the string, according to String(a+b) > String(b+a)
then combine them togeter*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    string largestNumber(vector<int>& nums) {
        sort(nums.begin(), nums.end(), [](int a, int b){
            return to_string(a)+to_string(b) > to_string(b)+to_string(a);
        });
        
        string ret;
        for(int n:nums){
            ret += to_string(n);
        }
        
        return ret[0]=='0' ? "0" : ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public String largestNumber(int[] nums) {
        if(nums==null || nums.length==0) return "";
        
        String[] temp = new String[nums.length];
        for(int i = 0; i < nums.length; ++i){
            temp[i] = nums[i] + "";
        }
        
        Arrays.sort(temp, new Comparator<String>(){
            @Override
            public int compare(String a, String b){
                return (a+b).compareTo(b+a);
            }
        });
        
        if(temp[temp.length-1].charAt(0)=='0') return "0";
        
        String ret = new String();
        for(String i:temp){
            ret = i + ret;
        }
        
        return ret;
    }
}
