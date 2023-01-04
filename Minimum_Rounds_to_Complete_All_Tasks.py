'''
You are given a 0-indexed integer array tasks, where tasks[i] represents the difficulty level of a task. In each round, you can complete either 2 or 3 tasks of the same difficulty level.

Return the minimum rounds required to complete all the tasks, or -1 if it is not possible to complete all the tasks.



Example 1:

Input: tasks = [2,2,3,3,2,4,4,4,4,4]
Output: 4
Explanation: To complete all the tasks, a possible plan is:
- In the first round, you complete 3 tasks of difficulty level 2.
- In the second round, you complete 2 tasks of difficulty level 3.
- In the third round, you complete 3 tasks of difficulty level 4.
- In the fourth round, you complete 2 tasks of difficulty level 4.
It can be shown that all the tasks cannot be completed in fewer than 4 rounds, so the answer is 4.
Example 2:

Input: tasks = [2,3,3]
Output: -1
Explanation: There is only 1 task of difficulty level 2, but in each round, you can only complete either 2 or 3 tasks of the same difficulty level. Hence, you cannot complete all the tasks, and the answer is -1.


Constraints:

1 <= tasks.length <= 105
1 <= tasks[i] <= 109
'''

'''
Solution 1:
use map to store the tasks level, and its corresponding number of tasks
then for each level's tasks, check min complete rounds
- if this level's number of task is 1, return -1
- for others,
  - have rounds = task / 3
  - check task % 3
    - if it is 0, return rounds
    - if it is 1, return rounds + 1
      - can group it by (rounds-1) with 3 tasks, then have 3+1 remaining, can group it by 2 rounds with 2 tasks
      - ex: 7, can group it by 3 * 1 + 2 * 2
    - if it is 2, return rounds + 1
      - can group it by rounds with 3 tasks, then have 2 remaining
      - group it by (rounds + 1)

Time Complexity: O(n)
Space Complexity: O(n)
'''
class Solution:
    def minimumRounds(self, tasks: List[int]) -> int:
        # key is task level
        # val is number of this level tasks
        group = {}
        for t in tasks:
            group[t] = group.get(t, 0) + 1

        # for each value, get their min complete rounds
        # if there is any value == 1, return -1
        rounds = 0

        # enter the number of tasks
        # return the min rounds that could complete these tasks
        # by complete either 2 or 3 tasks
        def countRounds(task: int) -> int:
            rounds = task//3
            return rounds if task % 3 == 0 else rounds+1

        for task in group.values():
            if task == 1:
                return -1
            rounds += countRounds(task)
        return rounds

