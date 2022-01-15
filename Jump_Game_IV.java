/*
Given an array of integers arr, you are initially positioned at the first index of the array.

In one step you can jump from index i to index:

i + 1 where: i + 1 < arr.length.
i - 1 where: i - 1 >= 0.
j where: arr[i] == arr[j] and i != j.
Return the minimum number of steps to reach the last index of the array.

Notice that you can not jump outside of the array at any time.



Example 1:

Input: arr = [100,-23,-23,404,100,23,23,23,3,404]
Output: 3
Explanation: You need three jumps from index 0 --> 4 --> 3 --> 9. Note that index 9 is the last index of the array.
Example 2:

Input: arr = [7]
Output: 0
Explanation: Start index is the last index. You do not need to jump.
Example 3:

Input: arr = [7,6,9,6,9,6,9,7]
Output: 1
Explanation: You can jump directly from index 0 to index 7 which is last index of the array.


Constraints:

1 <= arr.length <= 5 * 104
-108 <= arr[i] <= 108
*/

/*
Solution 2
bidirectional BFS

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public int minJumps(int[] arr) {
        int n = arr.length;
        if (n <= 1) { return 0; }

        Map<Integer, List<Integer>> map = new HashMap<>();
        for(int i = 0; i < n; i++) {
            map.computeIfAbsent(arr[i], v -> new LinkedList<>()).add(i);
        }

        Set<Integer> startSet = new HashSet<>();
        startSet.add(0);
        Set<Integer> endSet = new HashSet<>();
        endSet.add(n-1);

        boolean[] visited = new boolean[n];
        visited[0] = true;
        visited[n-1] = true;

        int step = 0;

        while (!startSet.isEmpty()) {
            if (startSet.size() > endSet.size()) {
                Set<Integer> temp = startSet;
                startSet = endSet;
                endSet = temp;
            }

            Set<Integer> nextStart = new HashSet<>();

            for(int cur : startSet) {
                for (int next : map.get(arr[cur])) {
                    if (endSet.contains(next)) {
                        return step+1;
                    }
                    if (!visited[next]) {
                        visited[next] = true;
                        nextStart.add(next);
                    }
                }
                // cleart list to previent redundant search
                map.get(arr[cur]).clear();

                if (endSet.contains(cur+1) || endSet.contains(cur-1)) {
                    return step+1;
                }

                if (cur+1 < n && !visited[cur+1]) {
                    visited[cur+1] = true;
                    nextStart.add(cur+1);
                }

                if (cur-1 >= 0 && !visited[cur-1]) {
                    visited[cur-1] = true;
                    nextStart.add(cur-1);
                }
            }

            step += 1;
            startSet = nextStart;
        }

        return step;
    }
}

/*
Solution 1:
BFS

check all possible path, see if there is one reaches the last index
store visited
save all same element index in map

clear dictionary to avoid check that element again

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    public int minJumps(int[] arr) {
        int n = arr.length;
        if (n <= 1) { return 0; }

        Map<Integer, List<Integer>> map = new HashMap<>();
        for(int i = 0; i < n; i++) {
            map.computeIfAbsent(arr[i], v -> new LinkedList<>()).add(i);
        }

        Set<Integer> startSet = new HashSet<>();
        startSet.add(0);

        boolean[] visited = new boolean[n];
        visited[0] = true;

        int step = 0;

        while (!startSet.isEmpty()) {
            Set<Integer> nextStart = new HashSet<>();

            for(int cur : startSet) {
                for (int next : map.get(arr[cur])) {
                    if (next == n-1) { return step+1; }
                    if (!visited[next]) {
                        visited[next] = true;
                        nextStart.add(next);
                    }
                }
                // cleart list to previent redundant search
                map.get(arr[cur]).clear();

                if (cur+1 == n-1 || cur-1 == n-1) {
                    return step+1;
                }

                if (cur+1 < n && !visited[cur+1]) {
                    visited[cur+1] = true;
                    nextStart.add(cur+1);
                }

                if (cur-1 >= 0 && !visited[cur-1]) {
                    visited[cur-1] = true;
                    nextStart.add(cur-1);
                }
            }

            step += 1;
            startSet = nextStart;
        }

        return step;
    }
}
