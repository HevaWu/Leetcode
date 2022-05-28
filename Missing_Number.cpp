/*268. Missing Number  QuestionEditorial Solution  My Submissions
Total Accepted: 68108
Total Submissions: 162090
Difficulty: Medium
Given an array containing n distinct numbers taken from 0, 1, 2, ..., n, find the one that is missing from the array.

For example,
Given nums = [0, 1, 3] return 2.

Note:
Your algorithm should run in linear runtime complexity. Could you implement it using only constant extra space complexity?

Credits:
Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

Subscribe to see which companies asked this question*/



/*linear runtime compexity
constant extra space complexity
initialize the ret as the size of nums
use ^ XOR operation to delete each number, the final number is the missing number */
class Solution {
public:
    int missingNumber(vector<int>& nums) {
        int ret = nums.size();
        int i = 0;
        for(int n:nums){
            ret ^= n;
            ret ^= i;
            i++;
        }
        return ret;
    }
};
