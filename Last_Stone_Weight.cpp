/*
You are given an array of integers stones where stones[i] is the weight of the
ith stone.

We are playing a game with the stones. On each turn, we choose the heaviest two
stones and smash them together. Suppose the heaviest two stones have weights x
and y with x <= y. The result of this smash is:

If x == y, both stones are destroyed, and
If x != y, the stone of weight x is destroyed, and the stone of weight y has new
weight y - x. At the end of the game, there is at most one stone left.

Return the smallest possible weight of the left stone. If there are no stones
left, return 0.



Example 1:

Input: stones = [2,7,4,1,8,1]
Output: 1
Explanation:
We combine 7 and 8 to get 1 so the array converts to [2,4,1,1,1] then,
we combine 2 and 4 to get 2 so the array converts to [2,1,1,1] then,
we combine 2 and 1 to get 1 so the array converts to [1,1,1] then,
we combine 1 and 1 to get 0 so the array converts to [1] then that's the value
of the last stone. Example 2:

Input: stones = [1]
Output: 1


Constraints:

1 <= stones.length <= 30
1 <= stones[i] <= 1000
*/

/*
Solution 1:
sort, then binary search to insert

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
 public:
  int lastStoneWeight(vector<int>& stones) {
    sort(stones.begin(), stones.end());
    while (stones.size() > 1) {
      int s1 = stones.back();
      stones.pop_back();
      int s2 = stones.back();
      stones.pop_back();
      if (s1 == s2) {
        continue;
      }
      insert(stones, s1 - s2);
    }
    return stones.empty() ? 0 : stones[0];
  }

  void insert(vector<int>& arr, int target) {
    if (arr.empty()) {
      arr.push_back(target);
      return;
    }
    int l = 0;
    int r = arr.size() - 1;
    while (l < r) {
      int mid = l + (r - l) / 2;
      if (arr[mid] < target) {
        l = mid + 1;
      } else {
        r = mid;
      }
    }
    int index = arr[l] < target ? l + 1 : l;
    arr.insert(arr.begin() + index, target);
  }
};
