/*154. Find Minimum in Rotated Sorted Array II
Description  Submission  Solutions  Add to List
Total Accepted: 70512
Total Submissions: 193789
Difficulty: Hard
Contributors: Admin
Follow up for "Find Minimum in Rotated Sorted Array":
What if duplicates are allowed?

Would this affect the run-time complexity? How and why?
Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

(i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).

Find the minimum element.

The array may contain duplicates.

Hide Tags Array Binary Search
Hide Similar Problems (M) Find Minimum in Rotated Sorted Array
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++





/*
Solution 2 is faster than solution 1

Solution 1:
Binary Search
add one line to check if the rotated pivor is the duplicated number

Solution 2:
search from the start to the end

 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    public int findMin(int[] nums) {
        if(nums.length <= 0) return -1;
        if(nums.length == 1) return nums[0];

        int start = 0;
        int end = nums.length -1;
        while(start < end){
            if(nums[start] < nums[end]) return nums[start];

            int mid = (start + end)/2;
            if(nums[start] == nums[end]){
                //add this line to check the if the rotated pivot is the duplicated number
                start++;
            } else if( nums[start] <= nums[mid]){
                start = mid + 1;
            } else {
                end = mid;
            }
        }
        return nums[start];
    }
}


//Solution 2
public class Solution {
    public int findMin(int[] nums) {
        if(nums.length <= 0) return -1;

        for(int i = 1; i < nums.length; ++i){
            if(nums[i] < nums[i-1]) return nums[i];
        }
        return nums[0];
    }
}

