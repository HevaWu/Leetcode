/*31. Next Permutation  QuestionEditorial Solution  My Submissions
Total Accepted: 83164 Total Submissions: 299955 Difficulty: Medium
Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.

If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).

The replacement must be in-place, do not allocate extra memory.

Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the right-hand column.
1,2,3 → 1,3,2
3,2,1 → 1,2,3
1,1,5 → 1,5,1
Hide Company Tags Google
Hide Tags Array
Hide Similar Problems (M) Permutations (M) Permutations II (M) Permutation Sequence (M) Palindrome Permutation II
*/

/*
Solution 2:
1. find first a[first] which is in the ascending order, if cannot find, just reverse this array would be the answer. Note: after finding this element, assign it to a variable for checking, otherwise it is hard to clarify the descending & target index at 0
2. betwen firstIndex+1 to n-1, find the element just larger than a[firstIndex], and swap them
3. now, a[firstIndex] is the fixed one, for firstIndex+1 to n-1, just reverse them would be the correct answer
//
Time complexity : O(n). In worst case, only two scans of the whole array are needed.
Space complexity : O(1). No extra space is used. In place replacements are done.
*/
public class Solution {
    public void nextPermutation(int[] nums) {
        int k = -1;
        //find the largest index k, that nums[k] < nums[k + 1]
        for(int i = nums.length-2; i >= 0; --i){
            if(nums[i] < nums[i+1]){
                k = i;
                break;
            }
        }

        //if k==-1, the permutation is sorted in descending order
        //reverse it into ascending order
        if(k==-1){
            reverse(nums, 0, nums.length);
            return;
        }

        //find the largest index l greater than k, nums[k]<nums[l]
        int l = -1;
        for(int i = nums.length-1; i > k; --i){
            if(nums[k]<nums[i]){
                l = i;
                break;
            }
        }

        swap(nums, k, l);
        reverse(nums, k+1, nums.length);
    }

    //swap two element in nums
    public void swap(int[] nums, int i , int j){
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }

    //reverse the nums
    public void reverse(int[] nums, int start, int end){
        if(start>end) return;
        for(int i = start; i < (end+start)/2; ++i){
            swap(nums, i, start+end-i-1);
        }
    }
}
