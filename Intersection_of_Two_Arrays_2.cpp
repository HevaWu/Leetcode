/*350. Intersection of Two Arrays II  QuestionEditorial Solution  My Submissions
Total Accepted: 31300
Total Submissions: 73944
Difficulty: Easy
Given two arrays, write a function to compute their intersection.

Example:
Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2, 2].

Note:
Each element in the result should appear as many times as it shows in both arrays.
The result can be in any order.
Follow up:
What if the given array is already sorted? How would you optimize your algorithm?
What if nums1's size is small compared to nums2's size? Which algorithm is better?
What if elements of nums2 are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?
Subscribe to see which companies asked this question

Show Tags
Show Similar Problems
*/



/*1. push the nums1 into a map, 
in c++, we can derictly add the value use [] operator
2. to the element in nums2, check if this value is exist, if it is, add into the list,
count the mapvalue --*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> intersect(vector<int>& nums1, vector<int>& nums2) {
        unordered_map<int,int> mymap;
        vector<int> ret;
        
        for(int n:nums1){
            mymap[n]++;
        }
        
        for(int n:nums2){
            int temp = mymap[n];
            if(temp!=NULL && temp>0){
                ret.push_back(n);
                mymap[n]--;
            }
        }
        
        return ret;
    }
};




/*1. push the nums1 into a map, 
Use hashmap.getOrDefault to get the value in the nums1
2. to the element in nums2, check if this value is exist, if it is, add into the list,
count the mapvalue --
3. transfer the list to array
using list.stream */

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int[] intersect(int[] nums1, int[] nums2) {
        Map<Integer, Integer> mymap = new HashMap<>();
        List<Integer> mylist = new ArrayList<>();
        
        for(int n:nums1){
            mymap.put(n, mymap.getOrDefault(n,0) + 1);  //getOrDefault(Object key, V defaultValue) Returns the value to which the specified key is mapped, or defaultValue if this map contains  no mapping for the key.
        }
        
        for(int n:nums2){
            Integer temp = mymap.get(n);
            
            if(temp!=null && temp>0){
                mylist.add(n);
                mymap.put(n,mymap.get(n)-1);
            }
        }
        
        return mylist.stream().mapToInt(b->b).toArray();
        //mapToInt(ToIntFunction<? super T> mapper) Returns an IntStream consisting of the results of applying the given function to the elements of this stream.

    }
}
