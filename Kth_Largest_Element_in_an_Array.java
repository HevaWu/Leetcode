/*
Find the kth largest element in an unsorted array. Note that it is the kth largest element in the sorted order, not the kth distinct element.

Example 1:

Input: [3,2,1,5,6,4] and k = 2
Output: 5
Example 2:

Input: [3,2,3,1,2,4,5,5,6] and k = 4
Output: 4
Note:
You may assume k is always valid, 1 ≤ k ≤ array's length.
*/

/*
Solution: default function
TimeComplexity: O(klogn)
SpaceComplexity: O(n)
*/
class Solution {
    public int findKthLargest(int[] nums, int k) {
        Arrays.sort(nums);
        return nums[nums.length - k];
    }
}

/*
Solution 4:
quick sort
optimize solution 3 by use one help function to do it

Time complexity : O(N) in the average case, O(N^2)in the worst case.
Space complexity : O(n).
*/
class Solution {
    public int findKthLargest(int[] nums, int k) {
        // sort by decreasing order, then pick k-1 element
        return quickSort(nums, k-1, 0, nums.length-1);
    }

    public int quickSort(int[] nums, int k, int start, int end) {
        if (start == end) { return nums[start]; }

        int pivot = nums[end];
        int i = start;
        int j = end-1;
        while (i < end && i <= j) {
            if (nums[i] < pivot) {
                // switch i,j element, keep larger one at front
                swap(nums, i, j);
                j -= 1;
            } else {
                i += 1;
            }
        }

        swap(nums, i, end);

        // for (int t = 0; t < nums.length; t++) {
        //     System.out.print(nums[t]);
        // }
        // System.out.println();


        if (i == k) {
            return nums[i];
        } else if (i < k) {
            return quickSort(nums, k, i+1, end);
        } else {
            return quickSort(nums, k, start, i-1);
        }
    }

    public void swap(int[] nums, int i, int j) {
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
}