/*
You are given an array of integers stones where stones[i] is the weight of the ith stone.

We are playing a game with the stones. On each turn, we choose the heaviest two stones and smash them together. Suppose the heaviest two stones have weights x and y with x <= y. The result of this smash is:

If x == y, both stones are destroyed, and
If x != y, the stone of weight x is destroyed, and the stone of weight y has new weight y - x.
At the end of the game, there is at most one stone left.

Return the smallest possible weight of the left stone. If there are no stones left, return 0.



Example 1:

Input: stones = [2,7,4,1,8,1]
Output: 1
Explanation:
We combine 7 and 8 to get 1 so the array converts to [2,4,1,1,1] then,
we combine 2 and 4 to get 2 so the array converts to [2,1,1,1] then,
we combine 2 and 1 to get 1 so the array converts to [1,1,1] then,
we combine 1 and 1 to get 0 so the array converts to [1] then that's the value of the last stone.
Example 2:

Input: stones = [1]
Output: 1


Constraints:

1 <= stones.length <= 30
1 <= stones[i] <= 1000
*/

/*
Solution 2: priorityQueue
 */
class Solution {
    public int lastStoneWeight(int[] stones) {
        Queue<Integer> queue = new PriorityQueue(Collections.reverseOrder());
        if (stones.length == 1) {
            return stones[0];
        }
        for (var stone : stones) {
            queue.offer(stone);
        }
        while (!queue.isEmpty() && queue.size() != 1) {
            //System.out.print("\n queue ");
            //queue.forEach(i -> System.out.print(i+ " "));
            var y = queue.poll();
            var x = queue.poll();
            if (x != y) {
                queue.offer(y-x);
            }
        }
        if (queue.isEmpty()) {
            return 0;
        }
        return queue.peek();
    }
}

/*
Solution 1:
sort, then binary search to insert

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    public int lastStoneWeight(int[] stones) {
        Arrays.sort(stones);
        List<Integer> stoneList = new ArrayList<Integer>(stones.length);
        for (int stone : stones) {
            stoneList.add(stone);
        }

        while (stoneList.size() > 1) {
            int y = stoneList.remove(stoneList.size()-1);
            int x = stoneList.remove(stoneList.size()-1);

            if (y == x) {
                continue;
            }

            // insert y-x
            int target = y-x;

            if (stoneList.size() == 0) {
                stoneList.add(target);
            } else {
                int low = 0;
                int high = stoneList.size()-1;

                while (low < high) {
                    int mid = low + (high-low) / 2;
                    if (stoneList.get(mid) < target) {
                        low = mid+1;
                    } else {
                        high = mid;
                    }
                }

                stoneList.add(stoneList.get(low) < target ? low+1 : low, target);
            }
        }

        return stoneList.size() > 0 ? stoneList.get(0) : 0;
    }
}
