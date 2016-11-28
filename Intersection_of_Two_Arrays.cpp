/*349. Intersection of Two Arrays  QuestionEditorial Solution  My Submissions
Total Accepted: 44741
Total Submissions: 100407
Difficulty: Easy
Given two arrays, write a function to compute their intersection.

Example:
Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2].

Note:
Each element in the result must be unique.
The result can be in any order.
Subscribe to see which companies asked this question*/



/*1. push nums1 into hash set
2. check if element in nums2 appears in the set, after check, if exist remove it from the set*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> intersection(vector<int>& nums1, vector<int>& nums2) {
        unordered_set<int> myset(nums1.begin(),nums1.end());
        vector<int> ret;
        for(int n:nums2){
            if(myset.count(n)){
                ret.push_back(n);
                myset.erase(n);
            }
        }
        
        return ret;
    }
};





/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int[] intersection(int[] nums1, int[] nums2) {
        Set<Integer> myset = new HashSet<>();
        List<Integer> mylist = new ArrayList<>();
        
        for(int n:nums1){
            myset.add(n);
        }
        
        for(int n:nums2){
            if(myset.contains(n)){
                mylist.add(n);
                myset.remove(n);
            }
        }
        
        return mylist.stream().mapToInt(b->b).toArray();
            
    }
}
