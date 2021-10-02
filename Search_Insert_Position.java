/*35. Search Insert Position   QuestionEditorial Solution  My Submissions
Total Accepted: 132179
Total Submissions: 341243
Difficulty: Medium
Contributors: Admin
Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You may assume no duplicates in the array.

Here are few examples.
[1,3,5,6], 5 → 2
[1,3,5,6], 2 → 1
[1,3,5,6], 7 → 4
[1,3,5,6], 0 → 0

Subscribe to see which companies asked this question

Hide Tags Array Binary Search
Hide Similar Problems (E) First Bad Version
*/


class Solution {
    public int searchInsert(int[] nums, int target) {
        int left = 0;
        int right = nums.length-1;

        while (left < right) {
            int mid = left + (right-left)/2;
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] < target) {
                left = mid+1;
            } else {
                right = mid;
            }
        }
        return nums[left] < target ? left+1 : left;
    }
}


/*binary search
we check if the element is larger, equal or less than the middle element
then, find if this element should be inserted in this position
1. check the border element, 0, len-1
2. do binary search*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int searchInsert(int[] nums, int target) {
        int low = 0, high = nums.length;

        if(target <= nums[0]){ //check the border element
            return 0;
        }

        if(target > nums[high-1]){
            return high;
        }

        while(low < high-1){
            int mid = (high+low)/2; //find the middle element
            if(target == nums[mid]){
                low = mid;
                return low;
            } else if(target < nums[mid]){
                high = mid;
            } else if(target > nums[mid]){
                low = mid;
            }
        }

        return low+1;
    }
}
