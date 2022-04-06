'''
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
'''

'''
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
'''
class Solution:
    def threeSumMulti(self, arr: List[int], target: int) -> int:
        freq = {}
        for num in arr:
            freq[num] = freq.get(num, 0) + 1

        sortedKey = sorted(freq.keys())
        n = len(sortedKey)

        finded = 0
        mod = 1_000_000_007

        for i in range(n):
            x = sortedKey[i]
            temp = target - x

            j = i
            k = n-1

            while j <= k:
                y = sortedKey[j]
                z = sortedKey[k]

                if y+z == temp:
                    if x == y and y == z:
                        valx = freq.get(x, 0)
                        finded += valx * (valx-1) * (valx-2) // 6
                        finded %= mod

                    elif x == y and y < z:
                        valx = freq.get(x, 0)
                        valz = freq.get(z, 0)
                        finded += valx * (valx-1) // 2 * valz
                        finded %= mod

                    elif x < y and y == z:
                        valx = freq.get(x, 0)
                        valy = freq.get(y, 0)
                        finded += valx * valy * (valy-1) // 2
                        finded %= mod

                    elif x < y and y < z:
                        valx = freq.get(x, 0)
                        valy = freq.get(y, 0)
                        valz = freq.get(z, 0)
                        finded += valx * valy * valz
                        finded %= mod

                    j += 1
                    k -= 1
                    # print(x, y, z, finded)

                elif y+z < temp:
                    j += 1

                else:
                    k -= 1

        return finded
