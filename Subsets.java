/*
Given an integer array nums of unique elements, return all possible subsets (the power set).

The solution set must not contain duplicate subsets. Return the solution in any order.



Example 1:

Input: nums = [1,2,3]
Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
Example 2:

Input: nums = [0]
Output: [[],[0]]


Constraints:

1 <= nums.length <= 10
-10 <= nums[i] <= 10
All the numbers of nums are unique.
 */

/*
Solution 1:
backtrack

Time Complexity: O(n * 2^n)
Space Complexity: O(2^n)
*/
class Solution {
    List<List<Integer>> sub = new ArrayList<>();
    List<Integer> cur = new ArrayList<>();

    public List<List<Integer>> subsets(int[] nums) {
        backtrack(0, nums.length, nums);
        return sub;
    }

    public void backtrack(int index, int n, int[] nums) {
        if (index == n) {
            // not directly sub.add(cur), because cur elements will change later
            // and java will keep reference to that element
            // copy element to new list to avoid reference changes later
            List<Integer> temp = new ArrayList<>();
            for (int num: cur) {
                temp.add(num);
            }
            sub.add(temp);
            return;
        }

        // pick index elements
        cur.add(nums[index]);
        backtrack(index+1, n, nums);

        cur.remove(cur.size()-1);
        backtrack(index+1, n, nums);
    }
}
