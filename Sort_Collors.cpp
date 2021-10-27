/*75. Sort Colors  QuestionEditorial Solution  My Submissions
Total Accepted: 115715 Total Submissions: 322833 Difficulty: Medium
Given an array with n objects colored red, white or blue, sort them so that objects of the same color are adjacent, with the colors in the order red, white and blue.

Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.

Note:
You are not suppose to use the library's sort function for this problem.

click to show follow up.

Follow up:
A rather straight forward solution is a two-pass algorithm using counting sort.
First, iterate the array counting number of 0's, 1's, and 2's, then overwrite array with total number of 0's, then 1's and followed by 2's.

Could you come up with an one-pass algorithm using only constant space?
Subscribe to see which companies asked this question*/



/*swap all 0s to the left
swap all 2s to the right
then all 1s are left in the middle*/

class Solution {
public:
    void sortColors(vector<int>& nums) {
        int start = 0, end = nums.size()-1;
        for(int i = 0; i <= end; ++i){
            while(nums[i]==2 && i<end){
                int temp = nums[i];
                nums[i] = nums[end];
                nums[end] = temp;
                end--;
            }
            while(nums[i]==0 && i>start){
                int temp = nums[i];
                nums[i] = nums[start];
                nums[start] = temp;
                start++;
            }
        }
    }
};
