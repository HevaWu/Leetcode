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
 public:
  vector<int> sortArray(vector<int>& nums) {
    vector<int> res;
    for (int num : nums) {
      insert(num, res);
    }
    return res;
  }

  void insert(int num, vector<int>& arr) {
    if (arr.empty()) {
      arr.push_back(num);
      return;
    }

    int l = 0;
    int r = arr.size() - 1;
    while (l < r) {
      int mid = l + (r - l) / 2;
      if (arr[mid] < num) {
        l = mid + 1;
      } else {
        r = mid;
      }
    }

    int index = arr[l] < num ? l + 1 : l;
    arr.insert(arr.begin() + index, num);
  }
};
