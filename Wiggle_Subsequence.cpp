/*376. Wiggle Subsequence  QuestionEditorial Solution  My Submissions
Total Accepted: 10129 Total Submissions: 29550 Difficulty: Medium
A sequence of numbers is called a wiggle sequence if the differences between successive numbers strictly alternate between positive and negative. The first difference (if one exists) may be either positive or negative. A sequence with fewer than two elements is trivially a wiggle sequence.

For example, [1,7,4,9,2,5] is a wiggle sequence because the differences (6,-3,5,-7,3) are alternately positive and negative. In contrast, [1,4,7,2,5] and [1,7,4,5,5] are not wiggle sequences, the first because its first two differences are positive and the second because its last difference is zero.

Given a sequence of integers, return the length of the longest subsequence that is a wiggle sequence. A subsequence is obtained by deleting some number of elements (eventually, also zero) from the original sequence, leaving the remaining elements in their original order.

Examples:
Input: [1,7,4,9,2,5]
Output: 6
The entire sequence is a wiggle sequence.

Input: [1,17,5,10,13,15,10,5,16,8]
Output: 7
There are several subsequences that achieve this length. One is [1,17,10,13,10,16,8].

Input: [1,2,3,4,5,6,7,8,9]
Output: 2
Follow up:
Can you do it in O(n) time?

Credits:
Special thanks to @agave and @StefanPochmann for adding this problem and creating all test cases.

Subscribe to see which companies asked this question*/



/*
mark a variable larger to check if the next element should larger than current element
1,7,8,4,5,2   
1, larger mark: true, 7  list:1,7
7, larger mark: false, 8 list: 1,8   change the list
8, larger mark: false, 4 list:1,8,4 
to each element, check if this element is satisfy larger mark, if it is, push into the list
else, update the last element in the list
we can directly update the original nums array*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int wiggleMaxLength(vector<int>& nums) {
        if(nums.size()==0 || nums.size()==1) return nums.size();
        
        int k = 1;
        while(k<nums.size()-1 && nums[k]==nums[k-1]){
            k++;
        }
        
        if(k==nums.size()-1) return 1;
        int ret = 2;
        bool larger = nums[k]>nums[k-1];
        for(int i = k+1; i < nums.size(); ++i){
            if(larger && nums[i]<nums[i-1]){
                nums[ret] = nums[i];
                ret++;
                larger = !larger;
            } else if(!larger && nums[i]>nums[i-1]){
                nums[ret] = nums[i];
                ret++;
                larger = !larger;
            } else {
                nums[ret-1] = nums[i];
            }
        }
        
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int wiggleMaxLength(int[] nums) {
        if(nums.length==0 || nums.length==1) return nums.length;
        
        int k = 1;//check if the first element is equal to the next one 
        while(k<nums.length-1 && nums[k]==nums[k-1]){
            k++;
        }
        
        if(k == nums.length-1) return 1;
        
        int ret = 2;
        boolean larger = nums[k]>nums[k-1];
        for(int i = k+1; i < nums.length; ++i){
            if(larger && nums[i]<nums[i-1]){
                nums[ret] = nums[i];
                ret++;
                larger = !larger;
            } else if(!larger && nums[i]>nums[i-1]){
                nums[ret] = nums[i];
                ret++;
                larger = !larger;
            } else {
                nums[ret-1] = nums[i];
            }
        }
        
        // for(int i = 0; i < ret; ++i){
        //     System.out.print(nums[i] + " ");
        // }
        
        return ret;
    }
}
