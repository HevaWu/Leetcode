/*
Given an array of integers nums, sort the array in ascending order.



Example 1:

Input: nums = [5,2,3,1]
Output: [1,2,3,5]
Example 2:

Input: nums = [5,1,1,2,0,0]
Output: [0,0,1,1,2,5]


Constraints:

1 <= nums.length <= 50000
-50000 <= nums[i] <= 50000
*/

/*
Solution 4:
binary insert

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    public int[] sortArray(int[] nums) {
        ArrayList<Integer> res = new ArrayList<>();
        for (int num : nums) {
            insert(num, res);
        }
        int n = nums.length;
        int[] arr = new int[n];
        for(int i = 0; i < n; i++) {
            arr[i] = res.get(i);
        }
        return arr;
    }

    public void insert(int num, ArrayList<Integer> arr) {
        if (arr.size() == 0) {
            arr.add(num);
            return;
        }

        int l = 0;
        int r = arr.size()-1;
        while (l < r) {
            int mid = l + (r-l)/2;
            if (arr.get(mid) < num) {
                l = mid+1;
            } else {
                r = mid;
            }
        }

        int index = arr.get(l) < num ? l+1 : l;
        arr.add(index, num);
    }
}
