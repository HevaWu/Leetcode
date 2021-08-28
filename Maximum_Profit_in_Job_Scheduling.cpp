/*
We have n jobs, where every job is scheduled to be done from startTime[i] to endTime[i], obtaining a profit of profit[i].

You're given the startTime, endTime and profit arrays, return the maximum profit you can take such that there are no two jobs in the subset with overlapping time range.

If you choose a job that ends at time X you will be able to start another job that starts at time X.



Example 1:



Input: startTime = [1,2,3,3], endTime = [3,4,5,6], profit = [50,10,40,70]
Output: 120
Explanation: The subset chosen is the first and fourth job.
Time range [1-3]+[3-6] , we get profit of 120 = 50 + 70.
Example 2:



Input: startTime = [1,2,3,4,6], endTime = [3,5,10,6,9], profit = [20,20,100,70,60]
Output: 150
Explanation: The subset chosen is the first, fourth and fifth job.
Profit obtained 150 = 20 + 70 + 60.
Example 3:



Input: startTime = [1,1,1], endTime = [2,3,4], profit = [5,6,4]
Output: 6


Constraints:

1 <= startTime.length == endTime.length == profit.length <= 5 * 104
1 <= startTime[i] < endTime[i] <= 109
1 <= profit[i] <= 104
*/

/*
Solution 1:
DP + binary search

1. sort by start time
2. dp[i], maxProfit for job[i...]
3. update dp[i]
-> base dp[n-1] = job[n-1][2]
-> dp[i] = max(dp[index]+job[i][2], max(dp[(i+1)..<index)]))

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
public:
    int jobScheduling(vector<int>& startTime, vector<int>& endTime, vector<int>& profit) {
        int n = startTime.size();

        vector<vector<int>> job(n);
        for (int i = 0; i < n; ++i) {
            job[i] = {startTime[i], endTime[i], profit[i]};
        }

        // sort by start time
        sort(job.begin(), job.end(), [](vector<int> first, vector<int> second) {
            return first[0] < second[0];
        });

        // for (int i = 0; i < n; i++) {
        //     for (int j = 0; j < job[i].size(); j++) {
        //         cout << job[i][j] << " ";
        //     }
        //     cout << endl;
        // }

        vector<int> dp(n);
        dp[n-1] = job[n-1][2];

        for (int i = n-2; i >= 0; i--) {
            int index = getIndex(i, n, job);
            dp[i] = job[i][2] + (index == n ? 0 : dp[index]);
            dp[i] = max(dp[i], dp[i+1]);
        }

        return dp[0];
    }

    int getIndex(int i, int n, vector<vector<int>>& job) {
        int left = i+1;
        int right = n-1;
        while (left < right) {
            int mid = left + (right - left)/2;
            if (job[mid][0] < job[i][1]) {
                left = mid+1;
            } else {
                right = mid;
            }
        }
        return job[left][0] < job[i][1] ? left+1 : left;
    }
};