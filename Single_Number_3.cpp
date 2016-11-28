/*260. Single Number III  QuestionEditorial Solution  My Submissions
Total Accepted: 46200
Total Submissions: 98287
Difficulty: Medium
Given an array of numbers nums, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once.

For example:

Given nums = [1, 2, 1, 3, 2, 5], return [3, 5].

Note:
The order of the result is not important. So in the above example, [5, 3] is also correct.
Your algorithm should run in linear runtime complexity. Could you implement it using only constant space complexity?
Credits:
Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

Subscribe to see which companies asked this question*/



/*linear runtime compexity O(n)
constant extra space complexity O(1)
1. using XOR operation, get the result of two elements XOR, there must be a bit'1' in the XOR result, find any set bit, eg. choose the rightmost set bit
2. divide into two groups, one has this bit set, one did not have, using XOR in each group,
we can find two elements*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> singleNumber(vector<int>& nums) {
        vector<int> ret(2);
        int diffBit = 0;
        for(int n: nums){  //get the XOR of the two element
            diffBit ^= n;
        }
        
        diffBit &= -diffBit; //get its last set bit
        
        for(int n:nums){
            if((n&diffBit)==0) ret[0] ^= n;  //find the bit not set
            else ret[1] ^= n;  //the bit in the set
        }
        
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int[] singleNumber(int[] nums) {
        int[] ret = new int[2];
        int diffBit = 0;
        for(int n:nums){
            diffBit ^= n;
        }
        
        diffBit &= ~(diffBit-1);
        
        for(int n:nums){
            if((diffBit&n)==0) ret[0] ^= n;
            else ret[1] ^= n;
        }
        
        return ret;
    }
}