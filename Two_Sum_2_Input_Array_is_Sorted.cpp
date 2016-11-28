/*167. Two Sum II - Input array is sorted   QuestionEditorial Solution  My Submissions
Total Accepted: 32791 Total Submissions: 68140 Difficulty: Medium Contributors: Admin
Given an array of integers that is already sorted in ascending order, find two numbers such that they add up to a specific target number.

The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2. Please note that your returned answers (both index1 and index2) are not zero-based.

You may assume that each input would have exactly one solution.

Input: numbers={2, 7, 11, 15}, target=9
Output: index1=1, index2=2

Hide Company Tags Amazon
Hide Tags Array Two Pointers Binary Search
Hide Similar Problems (E) Two Sum
*/



/* O(n)
since it is already sorted, we use two pointers
 one at start, and another one start from the end
 each time move two pointers
 if larger than target, move the back pointer
 if less than target, move the forward poitner*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> twoSum(vector<int>& numbers, int target) {
        int lo=0, hi=numbers.size()-1;
    while (numbers[lo]+numbers[hi]!=target){
        if (numbers[lo]+numbers[hi]<target){
            lo++;
        } else {
            hi--;
        }
    }
    return vector<int>({lo+1,hi+1});
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int[] twoSum(int[] numbers, int target) {
        int left = 0;
        int right = numbers.length - 1;
        
        while(left <= right){
            int sum = numbers[left] + numbers[right];
            if(sum > target){
                //move the right pointer to make sum smaller
                right--;
            } else if (sum < target){
                left++;
            } else {
                //sum == target
                break;
            }
        }
        return new int[]{left+1, right+1};
    }
}
