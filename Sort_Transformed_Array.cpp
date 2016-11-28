/*360. Sort Transformed Array   QuestionEditorial Solution  My Submissions
Total Accepted: 4886 Total Submissions: 11750 Difficulty: Medium Contributors: Admin
Given a sorted array of integers nums and integer values a, b and c. Apply a function of the form f(x) = ax2 + bx + c to each element x in the array.

The returned array must be in sorted order.

Expected time complexity: O(n)

Example:
nums = [-4, -2, 2, 4], a = 1, b = 3, c = 5,

Result: [3, 9, 15, 33]

nums = [-4, -2, 2, 4], a = -1, b = 3, c = 5

Result: [-23, -5, 1, 7]
Credits:
Special thanks to @elmirap for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Math Two Pointers
*/



/* O(n) time
if a>0, the center should be less than two ends
if a<0, the center should be larger than two ends
use two pointers mark the begin of array and the end of array
first we compare the value of this two positions, 
and push the first value into return array,
then move pointers to finish comparing
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> sortTransformedArray(vector<int>& nums, int a, int b, int c) {
        vector<int> ret;
        if(nums.size()==0) return ret;
        
        int left = 0;
        int right = nums.size()-1;
        ret.resize(nums.size());
        int index = a>=0 ? nums.size()-1 : 0;
        while(left <= right){
            if(a>=0){
                ret[index--] =
                    form(nums[left],a,b,c)<=form(nums[right],a,b,c) 
                    ? form(nums[right--],a,b,c) : form(nums[left++],a,b,c);
            } else if(a<0){
                ret[index++] = 
                    form(nums[left],a,b,c)<=form(nums[right],a,b,c)
                    ? form(nums[left++],a,b,c) : form(nums[right--],a,b,c);
            }
        }
        return ret;
    }
    
    int form(int x, int a, int b, int c){
        return a*x*x+b*x+c;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int[] sortTransformedArray(int[] nums, int a, int b, int c) {
        if(nums==null || nums.length==0) return new int[0];
        
        int[] ret = new int[nums.length];
        int left = 0;  //left pointer
        int right = nums.length-1; //right pointer
        int index = a>=0 ? nums.length-1 : 0; //ret pointer
        
        while(left <= right){
            if(a >= 0){
                ret[index--] = 
                form(nums[left],a,b,c) <= form(nums[right],a,b,c)
                ? form(nums[right--],a,b,c) : form(nums[left++],a,b,c);
            } else if(a < 0){
                ret[index++] = 
                form(nums[left],a,b,c) <= form(nums[right],a,b,c)
                ? form(nums[left++],a,b,c) : form(nums[right--],a,b,c);
            }
        }
        return ret;
    }
    
    public int form(int x, int a, int b, int c){
        return a*x*x + b*x + c;
    }
}
