/*31. Next Permutation  QuestionEditorial Solution  My Submissions
Total Accepted: 83164 Total Submissions: 299955 Difficulty: Medium
Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.

If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).

The replacement must be in-place, do not allocate extra memory.

Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the right-hand column.
1,2,3 → 1,3,2
3,2,1 → 1,2,3
1,1,5 → 1,5,1
Hide Company Tags Google
Hide Tags Array
Hide Similar Problems (M) Permutations (M) Permutations II (M) Permutation Sequence (M) Palindrome Permutation II
*/



/*O(n) time
permutation 置换
1.Find the largest index k such that nums[k] < nums[k + 1]. If no such index exists,
	the permutation is sorted in descending order, just reverse it to ascending order and we are done. For example, the next permutation of [3, 2, 1] is [1, 2, 3].
2. Find the largest index l greater than k such that nums[k] < nums[l].
3. Swap the value of nums[k] with that of nums[l].
4. Reverse the sequence from nums[k + 1] up to and including the final element
	nums[nums.size() - 1]*/

//C++
class Solution {
public:
    void nextPermutation(vector<int>& nums) {
        int k = -1;
        //find the largest index k, that nums[k] < nums[k + 1]
        for(int i = nums.size()-2; i >= 0; --i){
            if(nums[i]<nums[i+1]){
                k=i;
                break;
            }
        }

        //if k==-1, the permutation is sorted in descending order
        //reverse it into ascending order
        if(k==-1){
            reverse(nums.begin(), nums.end());
            return;
        }

        //find the largest index l greater than k, nums[k]<nums[l]
        int l = -1;
        for(int i = nums.size()-1; i > k; --i){
            if(nums[k] < nums[i]){
                l = i;
                break;
            }
        }

        swap(nums[k], nums[l]);
        reverse(nums.begin()+k+1, nums.end());
    }
};




