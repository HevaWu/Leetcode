/*330. Patching Array  QuestionEditorial Solution  My Submissions
Total Accepted: 14773 Total Submissions: 48193 Difficulty: Hard
Given a sorted positive integer array nums and an integer n, add/patch elements to the array such that any number in range [1, n] inclusive can be formed by the sum of some elements in the array. Return the minimum number of patches required.

Example 1:
nums = [1, 3], n = 6
Return 1.

Combinations of nums are [1], [3], [1,3], which form possible sums of: 1, 3, 4.
Now if we add/patch 2 to nums, the combinations are: [1], [2], [3], [1,3], [2,3], [1,2,3].
Possible sums are 1, 2, 3, 4, 5, 6, which now covers the range [1, 6].
So we only need 1 patch.

Example 2:
nums = [1, 5, 10], n = 20
Return 2.
The two patches can be [2, 4].

Example 3:
nums = [1, 2, 2], n = 5
Return 0.
Credits:
Special thanks to @dietpepsi for adding this problem and creating all test cases.

Subscribe to see which companies asked this question*/



/*using Sum to count the smallest sum in [0,n]
build sums in [0,Sum)
if there is a number num<=Sum in the array, add it to the smaller sum, and build [0,Sum+num)
if there is not, add this number into array, Sum add itself to maximize the result*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int minPatches(vector<int>& nums, int n) {
        long ret = 0, Sum = 1, i = 0;
        while(Sum <= n){
            if(i<nums.size() && nums[i]<=Sum){
                Sum += nums[i++];
            } else {
                Sum += Sum;
                ret++;
            }
        }
        
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int minPatches(int[] nums, int n) {
        int ret = 0, i = 0;
        long Sum = 1;
        while(Sum <= n){
            if(i<nums.length && nums[i]<=Sum){
                Sum += nums[i++];
            } else {
                Sum += Sum;
                ret++;
            }
        }
        
        return ret;
    }
}
