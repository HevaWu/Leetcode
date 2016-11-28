/*136. Single Number  QuestionEditorial Solution  My Submissions
Total Accepted: 151445
Total Submissions: 293549
Difficulty: Easy
Given an array of integers, every element appears twice except for one. Find that single one.

Note:
Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?

Subscribe to see which companies asked this question*/



/*Use XOR operation to delete the element appears twice*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int singleNumber(vector<int>& nums) {
        int ret = 0;
        for(int n:nums){
            ret ^= n;
        }
        
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int singleNumber(int[] nums) {
        int ret = 0;
        for(int n:nums){
            ret ^= n;
        }
        
        return ret;
    }
}
