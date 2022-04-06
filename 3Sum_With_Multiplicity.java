/*
Given an integer array arr, and an integer target, return the number of tuples i, j, k such that i < j < k and arr[i] + arr[j] + arr[k] == target.

As the answer can be very large, return it modulo 109 + 7.



Example 1:

Input: arr = [1,1,2,2,3,3,4,4,5,5], target = 8
Output: 20
Explanation:
Enumerating by the values (arr[i], arr[j], arr[k]):
(1, 2, 5) occurs 8 times;
(1, 3, 4) occurs 8 times;
(2, 2, 4) occurs 2 times;
(2, 3, 3) occurs 2 times.
Example 2:

Input: arr = [1,1,2,2,2,2], target = 5
Output: 12
Explanation:
arr[i] = 1, arr[j] = arr[k] = 2 occurs 12 times:
We choose one 1 from [1,1] in 2 ways,
and two 2s from [2,2,2,2] in 6 ways.


Constraints:

3 <= arr.length <= 3000
0 <= arr[i] <= 100
0 <= target <= 300
*/

/*
Solution 2:
3sum

buid map -> [num: count]
then sort map.keys
for each key, check if we can find other 2 elements(x, y, z) that sum as target
cases:
- x == y == z
	res += map[x] * (map[x]-1) * (map[x]-2) / 6
- x == y < z
	res += map[x] * (map[x]-1) / 2 * map[z]
- x < y == z
	res += map[x] * map[y] * (map[y]-1) / 2
- x < y < z
	res += map[x] * map[y] * map[z]

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    public int threeSumMulti(int[] arr, int target) {
        Map<Integer, Long> freq = new HashMap<>();
        for(int num: arr) {
            freq.put(num, freq.getOrDefault(num, Long.valueOf(0)) + 1);
        }

        List<Integer> sortedKeys = new ArrayList<>(freq.keySet());
        Collections.sort(sortedKeys);
        int n = sortedKeys.size();

        int mod = 1_000_000_007;
        long finded = 0;

        for(int i = 0; i < n; i++) {
            int x = sortedKeys.get(i);
            int temp = target - x;

            int j = i;
            int k = n-1;

            while (j <= k) {
                int y = sortedKeys.get(j);
                int z = sortedKeys.get(k);

                if (y + z == temp) {
                    if (x == y && y == z) {
                        long valx = freq.getOrDefault(x, Long.valueOf(0));
                        finded += valx * (valx - 1) * (valx - 2) / 6;
                        finded %= mod;
                    } else if (x == y && y < z) {
                        long valx = freq.getOrDefault(x, Long.valueOf(0));
                        long valz = freq.getOrDefault(z, Long.valueOf(0));
                        finded += valx * (valx - 1) / 2 * valz;
                        finded %= mod;
                    } else if (x < y && y == z) {
                        long valx = freq.getOrDefault(x, Long.valueOf(0));
                        long valy = freq.getOrDefault(y, Long.valueOf(0));
                        finded += valx * valy * (valy - 1) / 2;
                        finded %= mod;
                    } else if (x < y && y < z) {
                        long valx = freq.getOrDefault(x, Long.valueOf(0));
                        long valy = freq.getOrDefault(y, Long.valueOf(0));
                        long valz = freq.getOrDefault(z, Long.valueOf(0));
                        finded += valx * valy * valz;
                        finded %= mod;
                    }

                    j += 1;
                    k -= 1;
                } else if (y + z < temp) {
                    j += 1;
                } else {
                    k -= 1;
                }
            }
        }
        return (int)finded;
    }
}