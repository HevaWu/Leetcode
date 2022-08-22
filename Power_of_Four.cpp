/*342. Power of Four  QuestionEditorial Solution  My Submissions
Total Accepted: 35801
Total Submissions: 98886
Difficulty: Easy
Given an integer (signed 32 bits), write a function to check whether it is a power of 4.

Example:
Given num = 16, return true. Given num = 5, return false.

Follow up: Could you solve it without loops/recursion?

Credits:
Special thanks to @yukuairoy for adding this problem and creating all test cases.

Subscribe to see which companies asked this question*/

/*the power of 4 numbers have three features:
1. greater than 0
2. only have one 1 'bit' in their binary notation, use x&(x-1) to delete the lowest '1', if the result is 0, this number only have one bit
3. the only '1' bit should locate at the odd location, use '0x55555555' to check, or use
(x-1)%3==0 to check*/
class Solution
{
public:
    bool isPowerOfFour(int num)
    {
        return (num != 0) && (num & (num - 1)) == 0 && (num & 0x55555555) != 0;
    }
};
