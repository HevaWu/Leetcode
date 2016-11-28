/*259. 3Sum Smaller  QuestionEditorial Solution  My Submissions
Total Accepted: 14952 Total Submissions: 37487 Difficulty: Medium
Given an array of n integers nums and a target, find the number of index triplets i, j, k with 0 <= i < j < k < n that satisfy the condition nums[i] + nums[j] + nums[k] < target.

For example, given nums = [-2, 0, 1, 3], and target = 2.

Return 2. Because there are two triplets which sums are less than 2:

[-2, 0, 1]
[-2, 0, 3]
Follow up:
Could you solve it in O(n2) runtime?

Hide Company Tags Google
Hide Tags Array Two Pointers
Hide Similar Problems (M) 3Sum (M) 3Sum Closest
*/



/*O(n^2) time
1. sort the array
2. i start from 0 to len-2
	j start from i+1
	k start from len-1
	while(j<k){
		add i j k, if < target, count += k-j, j++
		else k--
	}
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int threeSumSmaller(vector<int>& nums, int target) {
        if(nums.size()<3) return 0;
        sort(nums.begin(), nums.end());
        int ret = 0;
        int n = nums.size();
        for(int i = 0; i < n-2; ++i){
            int j = i + 1;
            int k = n - 1;
            while(j < k){
                if(nums[i]+nums[j]+nums[k]<target){
                    ret += k - j;
                    j++;
                } else {
                    k--;
                }
            }
        }
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int threeSumSmaller(int[] nums, int target) {
        if(nums.length < 3) return 0;
        Arrays.sort(nums);
        int ret = 0;
        int n = nums.length;
        for(int i = 0; i < n-2; ++i){
            int j = i + 1;
            int k = n - 1;
            while(j < k){
                if(nums[i]+nums[j]+nums[k] < target){
                    ret += k - j;
                    j++;
                } else {
                    k--;
                }
            }
        }
        return ret;
    }
}
