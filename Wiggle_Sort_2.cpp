/*324. Wiggle Sort II  QuestionEditorial Solution  My Submissions
Total Accepted: 16345
Total Submissions: 67725
Difficulty: Medium
Given an unsorted array nums, reorder it such that nums[0] < nums[1] > nums[2] < nums[3]....

Example:
(1) Given nums = [1, 5, 1, 1, 6, 4], one possible answer is [1, 4, 1, 5, 1, 6]. 
(2) Given nums = [1, 3, 2, 2, 3, 1], one possible answer is [2, 3, 1, 3, 1, 2].

Note:
You may assume all input has valid answer.

Follow Up:
Can you do it in O(n) time and/or in-place with O(1) extra space?

Credits:
Special thanks to @dietpepsi for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Sort
Hide Similar Problems (M) Sort Colors (M) Kth Largest Element in an Array (M) Wiggle Sort
*/



/* O(n) time and/or in-place with O(1) extra space
the number on the even indexes are larger than the odd indexes
1. sort the array, from small to high
2. the first half of array insert into the odd index
the last haf of array insert into the even index
use & AND operator to see this position is odd index or even index
from the back of string to change
eg:
Small half:    4 . 3 . 2 . 1 . 0 .
Large half:    . 9 . 8 . 7 . 6 . 5
----------------------------------
Together:      4 9 3 8 2 7 1 6 0 5*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    void wiggleSort(vector<int>& nums) {
        vector<int> temp(nums);
        sort(temp.begin(), temp.end());
        for(int i = nums.size()-1, j = 0, k = i/2+1; i>=0; i--){
            nums[i] = temp[i&1 ? k++: j++];
        }
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public void wiggleSort(int[] nums) {
        int[] temp = new int[nums.length];
        for(int i = 0 ; i < nums.length; ++i){
            temp[i] = nums[i];
        }
        //int[] temp = nums.clone(); //copy nums to temp --- way 1
        //int[] temp = Arrays.copyOf(nums, nums.length); //copy nums to temp --- way 2
        Arrays.sort(temp);
        
        for(int i = nums.length-1, j = 0, k = i/2+1; i>=0; --i){
            nums[i] = temp[(i&1)!=0 ? k++: j++];
        }
    }
}
