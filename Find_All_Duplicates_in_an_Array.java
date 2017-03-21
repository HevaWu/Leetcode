/*442. Find All Duplicates in an Array
Description  Submission  Solutions  Add to List
Total Accepted: 16086
Total Submissions: 31384
Difficulty: Medium
Contributors: shen5630
Given an array of integers, 1 ≤ a[i] ≤ n (n = size of array), some elements appear twice and others appear once.

Find all the elements that appear twice in this array.

Could you do it without extra space and in O(n) runtime?

Example:
Input:
[4,3,2,7,8,2,3,1]

Output:
[2,3]
Hide Company Tags Pocket Gems
Hide Tags Array
Hide Similar Problems (E) Find All Numbers Disappeared in an Array
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
O(1) space, O(n) time

Since 1 ≤ a[i] ≤ n (n = size of array),
for ith element, we flip the i-1 element from positive to negative
if we find one element is already negative, we push this element to the return list
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public List<Integer> findDuplicates(int[] nums) {
        if(nums.length <= 0) return new ArrayList<>();

        List<Integer> ret = new ArrayList<>();
        for(int i = 0; i < nums.length; ++i){
            int index = Math.abs(nums[i]) - 1;
            if(nums[index] < 0){
                ret.add(Math.abs(nums[i])); //Math.abs(index+1)
            } else {
                nums[index] = -nums[index];
            }
        }
        return ret;
    }
}

