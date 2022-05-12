/*
Given a collection of numbers, nums, that might contain duplicates, return all possible unique permutations in any order.



Example 1:

Input: nums = [1,1,2]
Output:
[[1,1,2],
 [1,2,1],
 [2,1,1]]
Example 2:

Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]


Constraints:

1 <= nums.length <= 8
-10 <= nums[i] <= 10
*/

/*
Solution 1:
backtrack

put num and freq into map
then insert number by sorted keys

Time Complexity: O(n!)
Space Complexity: O(n)
*/
class Solution {
    public List<List<Integer>> permuteUnique(int[] nums) {
        List<List<Integer>> per = new ArrayList<>();
        List<Integer> cur = new ArrayList<>();

        Map<Integer, Integer> map = new HashMap<>();
        for (int num: nums) {
            map.put(num, map.getOrDefault(num, 0) + 1);
        }
        int n = nums.length;

        backtrack(n, map, cur, per);
        return per;
    }

    public void backtrack(
        int n, Map<Integer, Integer> map,
        List<Integer> cur, List<List<Integer>> per
    ) {
        if (cur.size() == n) {
            per.add(new ArrayList<>(cur));
            return;
        }

        for (Map.Entry<Integer, Integer> entry: map.entrySet()) {
            int num = entry.getKey();
            int val = entry.getValue();
            if (val == 0) {
                continue;
            }

            cur.add(num);
            map.put(num, val-1);

            backtrack(n, map, cur, per);

            cur.remove(cur.size()-1);
            map.put(num, val);
        }
    }
}