/*
You are given an integer array nums of length n where nums is a permutation of the numbers in the range [0, n - 1].

You should build a set s[k] = {nums[k], nums[nums[k]], nums[nums[nums[k]]], ... } subjected to the following rule:

The first element in s[k] starts with the selection of the element nums[k] of index = k.
The next element in s[k] should be nums[nums[k]], and then nums[nums[nums[k]]], and so on.
We stop adding right before a duplicate element occurs in s[k].
Return the longest length of a set s[k].



Example 1:

Input: nums = [5,4,0,3,1,6,2]
Output: 4
Explanation:
nums[0] = 5, nums[1] = 4, nums[2] = 0, nums[3] = 3, nums[4] = 1, nums[5] = 6, nums[6] = 2.
One of the longest sets s[k]:
s[0] = {nums[0], nums[5], nums[6], nums[2]} = {5, 6, 2, 0}
Example 2:

Input: nums = [0,1,2]
Output: 1


Constraints:

1 <= nums.length <= 105
0 <= nums[i] < nums.length
All the values of nums are unique.
*/

/*
Solution 2:
bool array to record current num is visited or not
Each number will only visited once, to put them into one loop

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public int arrayNesting(int[] nums) {
        int n = nums.length;

        boolean[] visited = new boolean[n];
        int maxLength = 0;
        for (int i = 0; i < n; i++) {
            if (visited[i] == false) {
                visited[i] = true;
                int k = i;
                int cur = 1;
                while (!visited[nums[k]]) {
                    visited[nums[k]] = true;
                    k = nums[k];
                    cur += 1;
                }
                maxLength = Math.max(maxLength, cur);
            }
        }
        return maxLength;
    }
}

/*
Solution 1:
UF

take [5,4,0,3,1,6,2] as examples:
s[0] = 5, 6, 2, 0
s[1] = 4, 1
s[2] = 0, 5, 6, 2
s[3] = 3
s[4] = 1, 4
s[5] = 6, 2, 0, 5
s[6] = 2, 0, 5, 6

we notice 5,6,0,2 is one group, 4,1 is one group, 3 is one group

use Union Find to help finding the longest element in the group

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public int arrayNesting(int[] nums) {
        int n = nums.length;
        if (n == 1) { return 1; }

        UF uf = new UF(n);
        for (int i = 0; i < n; i++) {
            uf.union(i, nums[i]);
        }

        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[uf.find(i)] += 1;
        }

        int maxLength = 0;
        for (int i = 0; i < n; i++) {
            maxLength = Math.max(maxLength, parent[i]);
        }
        return maxLength;
    }
}

class UF {
    int[] parent;

    public UF(int n) {
        parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
    }

    public int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    public void union(int x, int y) {
        int px = find(x);
        int py = find(y);
        if (px != py) {
            parent[px] = py;
        }
    }
}