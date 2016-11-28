/*1. Two Sum   QuestionEditorial Solution  My Submissions
Total Accepted: 330110 Total Submissions: 1188061 Difficulty: Easy Contributors: Admin
Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution.

Example:
Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].
UPDATE (2016/2/13):
The return format had been changed to zero-based indices. Please read the above updated description carefully.

Hide Company Tags LinkedIn Uber Airbnb Facebook Amazon Microsoft Apple Yahoo Dropbox Bloomberg Yelp Adobe
Hide Tags Array Hash Table
Hide Similar Problems (M) 3Sum (M) 4Sum (M) Two Sum II - Input array is sorted (E) Two Sum III - Data structure design
*/



/*
use hashmap to store the value in array, and their correspond index
for search, check if target-curvalue is exist in map, 
if it is, return their index*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> twoSum(vector<int>& nums, int target) {
        //Key is the number and value is its index in the vector.
	unordered_map<int, int> hash;
	vector<int> result;
	for (int i = 0; i < nums.size(); i++) {
		int numberToFind = target - nums[i];

            //if numberToFind is found in map, return them
		if (hash.find(numberToFind) != hash.end()) {
			result.push_back(hash[numberToFind] );
			result.push_back(i);			
			return result;
		}

            //number was not found. Put it in the map.
		hash[nums[i]] = i;
	}
	return result;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> mymap = new HashMap<>();
        for(int i = 0; i < nums.length; ++i){
            int n1 = target-nums[i];
            if(mymap.containsKey(n1)){
                return new int[]{mymap.get(n1), i};
            }
            mymap.put(nums[i],i);
        }
        return new int[]{-1,-1};
    }
}
