/*280. Wiggle Sort  QuestionEditorial Solution  My Submissions
Total Accepted: 16869 Total Submissions: 31864 Difficulty: Medium
Given an unsorted array nums, reorder it in-place such that nums[0] <= nums[1] >= nums[2] <= nums[3]....

For example, given nums = [3, 5, 2, 1, 6, 4], one possible answer is [1, 6, 2, 5, 3, 4].

Hide Company Tags Google
Hide Tags Array Sort
Hide Similar Problems (M) Sort Colors (M) Wiggle Sort II
*/



/*O(n) time
we do it in-place
the nums should satisfy 2 conditions
1. i is odd, nums[i] >= nums[i-1]
2. i is even, nums[i] <= nums[i-1]
just to fix the ordering of nums that not satisfy these 2 conditions
*/
/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    void wiggleSort(vector<int>& nums) {
        if(nums.size() < 1) return;
        for(int i = 1; i < nums.size(); ++i){
            //i&1==1 i is odd
            //i&1==0 i is even
            if(((i&1) && nums[i] < nums[i-1]) 
                || (!(i&1) && nums[i] > nums[i-1])){
                    swap(nums[i], nums[i-1]);
                }
            //if can replace by if(i%2 == (nums[i-1]>nums[i]))
        }
        //another for: 
        /*for(int i = 1; i < nums.size(); ++i){
           swap(nums[i], nums[i-(i%2 ^ (nums[i-1]<nums[i]))]); 
        }*/
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public void wiggleSort(int[] nums) {
        if(nums.length < 1) return;
        for(int i = 1; i < nums.length; ++i){
            if(i%2==0){
                //i is even
                if(nums[i] > nums[i-1]){
                    swap(nums, i);
                }
            } else if (i%2 == 1){
                //i is odd
                if(nums[i] < nums[i-1]){
                    swap(nums, i);
                }
            }
        }
    }
    
    //swap i with i-1
    //pass array into function
    public void swap(int[] nums, int i){
        int temp = nums[i];
        nums[i] = nums[i-1];
        nums[i-1] = temp;
    }
}
